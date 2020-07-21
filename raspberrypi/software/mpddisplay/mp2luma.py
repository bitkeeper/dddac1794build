#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Copyright (c) 2014-17 Richard Hull and contributors
# See LICENSE.rst for details.
# PYTHON_ARGCOMPLETE_OK

"""
Display basic system information.

  needs mpd2 installed
  $ sudo apt-get install python-dev
  $ sudo -H pip install psutil
"""

import os
import sys
import time
import signal
from datetime import datetime
from datetime import timedelta
if os.name != 'posix':
    sys.exit('{} platform not supported'.format(os.name))

from luma_opts import get_device
from luma.core.render import canvas
from PIL import ImageFont
from mpd import MPDClient
from mpd import ConnectionError
import socket
import logging

import RPi.GPIO as GPIO
SOURCE_SWITCH_PIN = 25  # Low active, momentary switch
SOURCE_LED_PIN = 26 # was 12
# The relais are low active; without script default SPDIF DIGITAL 1 is selected
BUS_SELECT_PIN = 23  # SPDIF(1) or I2S (0)
SPDIF_SELECT_PIN = 24  # DIGITAL 1(1) or DIGITAL 2 (0)

from gpiozero import LED, Button
SOURCE_LED = LED(SOURCE_LED_PIN)
SOURCE_SWITCH = Button(SOURCE_SWITCH_PIN)


class MpdDisplay (object):
    def __init__(self, device):
        self.running = True
        self.client = MPDClient()  # create client object
        self.device = device
#         client.timeout = 10  # network timeout in seconds (floats allowed), default: None
#         client.idletimeout = None  # timeout for fetching the result of the idle command is handled seperately, default: None

        self.status_mpd = {}
        self.current_song_mpd = {}

        self.connected = False
        self.state = None
        self.bitrate = ''
        self.samplerate = ''
        self.bits = ''
        self.type = ''

        self.elapsed = ''
        self.left = '    ---'
        self.progress = 0
        self.title = ''
        self.artist = ''
        self.showsplashscreen = 1  # timer before hide splashscreen

        self.blink = False  # used to blink elapsed and left is the player is paused

        font_path = os.path.abspath(os.path.join(os.path.dirname(__file__),
                                    'fonts', 'C&C Red Alert [INET].ttf'))
        self.font2 = ImageFont.truetype(font_path, 12)
        self.fontbig = ImageFont.truetype(font_path, 24)
        self.bottom = 63

        self.port = 6600
#         try:
#             self.client.connect("localhost", self.port)  # connect to localhost:6600
#             self.connected = True
#         except ConnectionRefusedError:
#             self.connected = False
        self.source_index = 0
        self.initIo()
        self.select_source(self.source_index)

        self.press_duration= None # used to measure how long a button is pressed

        start_time=time.time()
        signal.signal(signal.SIGINT, self.exit_gracefully)
        signal.signal(signal.SIGTERM, self.exit_gracefully)


    def exit_gracefully(self, signum, frame):
        self.kill_now = True
        self.running = False
        GPIO.output(BUS_SELECT_PIN, GPIO.HIGH)
        GPIO.output(SPDIF_SELECT_PIN, GPIO.HIGH)
        # GPIO.output(SOURCE_LED_PIN, GPIO.LOW)
        SOURCE_LED.off()
        with canvas(device) as draw:
            pass


    def initIo(self):
        GPIO.setwarnings(False)
        GPIO.setmode(GPIO.BCM)
        GPIO.setup(BUS_SELECT_PIN, GPIO.OUT)
        GPIO.setup(SPDIF_SELECT_PIN, GPIO.OUT)
        SOURCE_LED.on()        

        #            (Label ,    Bus,       Spdif source, Led)
        self.SOURCES = [ ('Streamer', GPIO.LOW, GPIO.HIGH, GPIO.HIGH)
                  , ('Digital 1', GPIO.HIGH, GPIO.HIGH, GPIO.LOW)
                  , ('Digital 2', GPIO.HIGH, GPIO.LOW, GPIO.LOW) ]

        SOURCE_SWITCH.when_pressed = self.source_pressed
        SOURCE_SWITCH.when_released = self.source_released

    def source_pressed(self):
        SOURCE_LED.off()
        self.press_duration = datetime.now()

    def source_released(self):
        press_duration = datetime.now() - self.press_duration
        if press_duration >  timedelta(milliseconds=500):
            self.client.pause()
            # if self.client.status().state == 'play':
            #   SOURCE_LED.on()
        elif press_duration >  timedelta(milliseconds=100):
            self.source_select_pressed(None)

        SOURCE_LED.on()            

    def select_source(self, index):
        GPIO.output(BUS_SELECT_PIN, self.SOURCES[index][1])
        GPIO.output(SPDIF_SELECT_PIN, self.SOURCES[index][2])

            
    def source_select_pressed (self, channel):
        global source_index, active, toggle
        self.source_index = (self.source_index + 1) % 3
        self.select_source(self.source_index)

    def collect(self):
        try:
            self._collect()
        except socket.error as e:			
            self.connected = False
            self.client.disconnect()
            time.sleep(5)		
        except ConnectionError as e:
            self.connected = False
            self.client.disconnect()
            time.sleep(5)

    def _collect(self):
        kind = ''
        bitrate = ''
        samplerate = ''
        bits = ''

        title = ''
        artist = ''

        elapseds = '---'
        lefts = '     ---'
        progress = None

        songs = None
        song = None

        if self.connected == False:
            self.client.connect("localhost", self.port)  # connect to localhost:6600

        self.status = self.client.status()
        self.current_song = self.client.currentsong()
        self.connected = True
# example output status:
#     {'volume': '-1', 'repeat': '0', 'random': '0', 'single': '0', 'consume': '0', 'playlist': '7', 'playlistlength': '11', 'mixrampdb': '0.000000', 'state': 'play', 'song': '0', 'songid': '1', 'time': '15:317', 'elapsed': '15.092', 'bitrate': '364', 'audio': '44100:16:2', 'nextsong': '1', 'nextsongid': '2'}
# example output song:
#     {'file': 'NAS/bitspot/Batik - Headland (2014)/2014 - Headland/01 - Batik - Neon.flac', 'last-modified': '2014-10-02T16:52:31Z', 'artist': 'Batik', 'title': 'Neon', 'album': 'Headland', 'albumartist': 'Batik', 'genre': 'Jazz/Slow', 'date': '2014', 'track': '1', 'disc': '1', 'time': '317', 'pos': '0', 'id': '1'}

        status = self.status
        current_song = self.current_song
        if 'state' in self.status:
            self.state = self.status['state']
        if 'audio' in status:
            samplerate, bits, channels = status['audio'].split(':')
            bits = bits + 'b'
            samplerate = int(samplerate) / 1000
            if samplerate >= 100:
                samplerate = int(samplerate)
            samplerate = str(samplerate) + 'k'
            if status['bitrate'] != '0':
                bitrate = status['bitrate'] + "k"

        if 'file' in current_song:
            filename = current_song['file']
            kind = filename.split('.')[-1].upper()

        if 'elapsed' in status:
            duration = None
            elapsed = int(float(status['elapsed']))
            elapseds = str(timedelta(seconds=elapsed))[2:]
            if 'time' in current_song:
                duration = int(current_song['time'])
                durations = str(timedelta(seconds=duration))[2:]

            if elapsed and duration:
                left = duration - elapsed
                lefts = '-' + str(timedelta(seconds=left))[2:]
                progress = float(elapsed) / float(duration)

        if 'artist' in current_song:
            artist = current_song['artist']

        if 'title' in current_song:
            title = current_song['title']

        if 'song' in status:
            song = int(status['song']) + 1

        if 'playlistlength' in status:
            songs = int(status['playlistlength'])
        self.type = kind
        self.samplerate = samplerate
        self.bits = bits
        self.bitrate = bitrate

        self.artist = artist
        self.title = title

        self.elapsed = elapseds
        self.left = lefts
        self.progress = progress

        self.songs = songs
        self.song = song

    def draw_align(self):
        '''
        Used for mounting the display
        '''
        with canvas(self.device) as draw:
            draw.rectangle((0, 0, 127, 63), outline="blue")

    def draw(self):
        device = self.device
        font2 = self.font2

        with canvas(device) as draw:
            if  not(self.connected) or self.showsplashscreen:
                draw.text((6, 4), 'DDDAC 1794', font=self.fontbig, fill="white")
                draw.text((43, 26), 'NOS', font=self.fontbig, fill="white")
                draw.text((20, 50), 'WAITING FOR PLAYER', font=font2, fill="white")
                if self.showsplashscreen > 0:
                    self.showsplashscreen -= 1
            elif self.source_index == 0:
                if self.type:
                    draw.rectangle((0, 0, 24, 10), outline="blue", fill="white")
                    draw.text((1, 0), self.type, font=font2, fill="black")
                draw.text((28, 0), "%s %s %s" % (self.samplerate, self.bits, self.bitrate), font=font2, fill="white")

                draw.text((0, 17), self.title, font=font2, fill="white")
                draw.text((0, 31), self.artist, font=font2, fill="white")


                if self.state != 'pause' or self.blink == False:
                    draw.text((0, 50), self.elapsed, font=font2, fill="white")
                    draw.text((98, 50), self.left, font=font2, fill="white")                    
                    
                if self.state == 'pause':
                    self.blink = not(self.blink)
                    SOURCE_LED.on ()  if self.blink else SOURCE_LED.off()

                if self.song and self.songs:
                    draw.text((54, 50), '%d/%d' % (self.song, self.songs), font=font2, fill="white")
                elif self.songs:
                    draw.text((54, 50), '-/%d' % (self.songs), font=font2, fill="white")
                    draw.text((16, 17), 'NO PLAYLIST RUNNING', font=font2, fill="white")
                else:
                    draw.text((54, 50), '-/-', font=font2, fill="white")
                    draw.text((30, 17), 'EMPTY PLAYLIST', font=font2, fill="white")

                if self.progress:
                    draw.line((0, self.bottom, device.width * self.progress, self.bottom), fill="white")
            else:
                draw.text((33, 20), self.SOURCES[self.source_index][0], font=self.fontbig, fill="white")



def main():
    logger = logging.getLogger('mpd')
    logger.setLevel(logging.WARN)
    client = MpdDisplay(device)
    client.draw()
    time.sleep(2)

    while client.running:
        client.collect()
#         client.draw_align()  # used calibrating the mounting of the display
        client.draw()
        if client.source_index == 0:
            time.sleep(1)
        else:
            time.sleep(0.5)

if __name__ == "__main__":
    time.sleep(0.5)
    device = get_device()

    max_reconnects = 2
    reconnect_count = 0
    try:
        main()
    except KeyboardInterrupt:
        pass
