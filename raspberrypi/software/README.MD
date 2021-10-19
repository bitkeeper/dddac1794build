# Install software
The target is a DDDAC 1794 NOS with a Raspberry Pi. See the system description in the toplevel README.MD.
If that doesn't match you system, you can still use the installation procedure, but use it selective.


# Install Moode 7.0.0

## Install the image
* Download image from https://github.com/moode-player/moode/releases/download/r700prod/moode-r700-iso.zip
* Unpack zip
* Use Win32 Disk Imager tp write img to SD card <image>
* Wait until the leds on the pi stop blinking
* Open browser to http://moode/

## Basic configuration

```
System Config
	General
		Timezone (set)
		Host name (set)
	System Modifications
		Integrated WiFi adapter off (set)
		Integrated BT adapter off (set)
		HDMI port : off (set)
		File system: expand
	Local Services:
		SSH term server: on (set)  < If you have and prefer an SSH client like PuTTY or MobaXTerm you can leave it off.

Audio Config
	I2S audio device: HifiBerry Digi+ Pro
	Edit MPD Config

MPD Config
	SoxX Resampling
		Samplerate: 24 bit/* kHz    < force everything 24 bit to make it work with the DDDAC 1794 NOS
```

The preferences settings are about the look and feel and are offcourse a personal choice:
```
Preferences
	Appearance
		Accent color: Fallenleaf
		Alpha blend: 0.65
		Cover backdrop: Yes
		Cover blur: 10px
		Cover scale: 1.0
	Playback
		Show Queue thumbs: yes
	Library
		On touch action: Play
		Albumview sort order: by Artist/Year
		Tagview sort order: by Artist/Year
		Show sample rate: HD Only
		Cover search priority: cover file
		Thumbnail resolution: 500px
		Thumbnail columns: 8/4
	Library(Advanced)
		Ellipsis limited text: Yes
```

After this restart the system ( menu power > restart)

## Test sound
* Wait until the LED When the leds are quiet again.
* Reconnect * Open browser to http://moode/

Before making any changes check if standard supplied file 'Stereo Test' works.

* In the library view select 'Stero Test'
* Probably the volume of moode is default set to 0; set the volume to a normal level
This file has a samplerate of 48k, so even if the 44k clock select of the Allo Isolator mod isn't applied, you should here sound.


# Install mods and tweaks

Directory content:
* mpddisplay - python app for OLED display with luma.oled + mpd2 client
* softpowerdown - bring moode safe power down (requires hardware module)
* systemd
* tweaks -
  * starting with moode 7 - all the tweaks are one way or other integrated in moOde.
  * [switched to FifoPi] ~~hifiberry-digi-pro-remap - allow 44k1 based crystal to be used with Allo Isolator (requires hardware mod).~~
  * [obsolute|integrated 6.6] ~~moode_albumsearch_trim - strip whitespace before and after. ensures better search during live typing.~~
  * [obsolute|integrated 6.6] ~~moode_albumyear - make the albumyear search priority  OriginalRelease, OriginalYear, Date insteadof only Date.~~
  * [obsolute|integrated 6.6] ~~moode_mpd_tweaks - Moode doesn't support all mpd options, with this tweak you can add in the mpd config screen.~~
  * [obsolute|integrated 6.6] ~~moode_nativelazy_loading - use browser native lazy loading for album art by browser that support it.~~
  * moode_responsive_orientationchange
  * [obsolute|integrated 6.6]~~moode_sq_overlay~~
  * [obsolute|integrated 7.0]~~mpd_selective_resample - Patch MPD (tested on 0.21.20 and 0.21.23) to support selective resample and add it selectable to the Moode MPD version selector.~~
  * [obsolute|integrated 7.0] ~~Show album cover on playlist~~

Some of the patches are already integrated and part of the moOde source tree.

## Prepare install

Start ssh session (instead of using a client it can also be done in the webinterface of Moode in system configuration)

Get the mods and tweaks:
```
cd ~
git clone https://github.com/bitkeeper/dddac1794build.git
chmod +x dddac1794build/raspberrypi/software/util/*
```

## Soft Power Download
add to /boot/config.txt:
```
dtoverlay=gpio-shutdown,gpio_pin=22,active_low=0,gpio_pull=off
```

Add service to start the overlay only when the system is fully booted:
```
cd ~
sudo cp dddac1794build/raspberrypi/software/softpowerdown/pipower.service /etc/systemd/system
sudo systemctl enable pipower
sudo systemctl start pipower
```

## MPD Display

Enable I2C interface

```
sudo raspi-config
```

* Select "3 interfaces""
* Select "P5 I2C"
* yes enable

```
cd ~
sudo apt-get install python-dev python-pip libfreetype6-dev libjpeg-dev build-essential
sudo -H pip install --upgrade luma.oled==3.4 luma.core==1.13
sudo pip install python-mpd2 gpiozero
```

vesion luma.oled=3.4 and luma.core 1.13 are required as later version will only work with Python3.
_Need to port this daemon from py2 to py3_


Install service for display:
```
cp -r dddac1794build/raspberrypi/software/mpddisplay/ mpddisplay
sudo cp dddac1794build/raspberrypi/software/mpddisplay/mpddisplay.service /etc/systemd/system
sudo systemctl enable mpddisplay.service
sudo systemctl start mpddisplay.service
```

## Moode: Change the number of visible albums on several device types

_In 6.6 the scheme is changed, need new fix for 7.0.0_


Instead of changing the original file, the new css media queries are placed in a separated file.
This file will be include after the moode.min.css include.

```
cd /var/local/www
sudo cp header.php header_dev.php
sudo patch -b header.php < /home/pi/dddac1794build/raspberrypi/software/tweaks/moode_albumcols/moode_652_custom_css.patch
sudo cp /home/pi/dddac1794build/raspberrypi/software/tweaks/moode_albumcols/moode_additional_media.css /var/www/css/moodecustom.css
```

Or in case of development replace the last line by:
```
sudo ln -s /home/pi/dddac1794build/raspberrypi/software/tweaks/moode_albumcols/moode_additional_media.css /var/www/css/moodecustom.css
```

## More responsive orientation change
In the header.php remove the orientation change handler.

Original:
```html
<body onorientationchange="javascript:location.reload(true); void 0;">
```

New:
```html
<body >
```

## Prevent MPD scanning of cue files:

In the root of the music library create a file called .mpdignore with the following content:
```
*.cue
**/*.cue
```

## Install of npm and development tree
_Only required if your are going todo some development on moOde, else skip._

```
sudo apt-get install npm
```
Is about 60MB.

```
sudo apt-get install mc htop
```

git clone your_moode_repo_url

npm ci

pi@moodep4:~/moode $ git config --global user.name "yourusername"
pi@moodep4:~/moode $ git config --global user.eamil "yourusername@users.noreply.github.com"






