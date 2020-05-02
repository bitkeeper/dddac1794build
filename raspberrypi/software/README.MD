# Install software
The target is a DDDAC 1794 NOS with a Raspberry Pi. See the system description in the toplevel README.MD.
If that doesn't match you system, you can still use the installation procedure, but use it selective.


# Install Moode 6.5.1

## Install the image
* Download image from https://github.com/moode-player/moode/releases/download/r651prod/moode-r651-iso.zip
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

The appearance settings are offcourse a personal choice:
```
Appearance
	Theme & Background
		Alpha blend: 0.65
		Cover backdrop: Yes
		Cover blur: 10px
		Cover scale: 1.0
	Library
		Hi-res thumbnails: 300px
		Cover search priority: cover file
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
  * hifiberry-digi-pro-remap - allow 44k1 based crystal to be used with Allo Isolator (requires hardware mod).
  * moode_albumcols - alternative css @media query for more albums on PC and tablet screens.
  * moode_mpd_tweaks - Moode doesn't support all mpd options, with this tweak you can add in the mpd config screen.
  * mpd_selective_resample - Patch MPD (tested on 0.21.20 and 0.21.23) to support selective resample and add it selectable to the Moode MPD version selector.
* util - utils to easy moode/mpd development easier.


## Prepare install

Start ssh session (instead of using a client it can also be done in the webinterface of Moode in system configuration)

Get the mods and tweaks:
```
cd ~
git clone https://github.com/bitkeeper/dddac1794build.git
chmod +x dddac1794build/raspberrypi/software/util/*
```

## HifiBerry Digi+ Pro remapped GPIO pins

Build the new overlay:
```
cd ~
sudo apt-get install raspi-gpio device-tree-compiler
dtc -@ -I dts -O dtb -o hifiberry-digi-pro-remap.dtbo /home/pi/dddac1794build/raspberrypi/software/tweaks/hifiberry-digi-pro-remap/hifiberry-digi-pro-remap-overlay.dts 
sudo cp hifiberry-digi-pro-remap.dtbo /boot/overlays/
```

In /boot/config.txt make the hifiberry overlay comment and add the remap overlay:
```
#dtoverlay=hifiberry-digi-pro
dtoverlay=hifiberry-digi-pro-remap,clock44_gpio_pin=16,clock48_gpio_pin=6
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

* Select "5 interfaces"" 
* Select "P5 I2C" 
* yes enable

```
cd ~
sudo apt-get install python-dev python-pip libfreetype6-dev libjpeg-dev build-essential
sudo -H pip install --upgrade luma.oled luma.core==1.13
sudo pip install python-mpd2 gpiozero
```

vesion luma.core 1.13 is required as later version will only work with Python3.


Install service for display:
```
cp -r dddac1794build/raspberrypi/software/mpddisplay/ mpddisplay
sudo cp dddac1794build/raspberrypi/software/mpddisplay/mpddisplay.service /etc/systemd/system
sudo systemctl enable mpddisplay.service
sudo systemctl start mpddisplay.service
```

## Add MPD Tweak options to Moode MPD Config

```
cd /var/www
sudo patch -b -p2 < /home/pi/dddac1794build/raspberrypi/software/tweaks/moode_mpd_tweaks/moode_6.5.1_mpd_tweaks.patch
sqlite3 /var/local/www/db/moode-sqlite3.db < /home/pi/dddac1794build/raspberrypi/software/tweaks/moode_mpd_tweaks/moode_mpd_tweaks.sql
sqlite3 /var/local/www/db/moode-sqlite3.db 'UPDATE cfg_mpd  SET value="1" where param="mpd_tweaks_unlock";'
/home/pi/dddac1794build/raspberrypi/software/util/stopit.sh
/home/pi/dddac1794build/raspberrypi/software/util/startit.sh
```

## Upgrade to MPD 0.21.23 and apply Selective Resample patch

```
cd ~
wget http://www.musicpd.org/download/mpd/0.21/mpd-0.21.23.tar.xz
tar xf mpd-0.21.23.tar.xz
cd mpd-0.21.23
sudo patch -b -p1 < /home/pi/dddac1794build/raspberrypi/software/tweaks/mpd_selective_resample/mpd_0.21.23_selective_44k_resample.patch
meson . output/release --buildtype=release -Db_ndebug=true
meson configure \
-Dalsa=enabled \
-Dbzip2=enabled \
-Dcurl=enabled \
-Ddatabase=true \
-Ddsd=true \
-Dffmpeg=enabled \
-Dfaad=enabled \
-Dflac=enabled \
-Dhttpd=true \
-Did3tag=enabled \
-Dlame=enabled \
-Dlibmpdclient=enabled \
-Dmad=enabled \
-Dmpg123=enabled \
-Dpipe=true \
-Drecorder=true \
-Dshout=enabled \
-Dsoundcloud=enabled \
-Dsoxr=enabled \
-Dvorbis=enabled \
-Dwave_encoder=true \
-Dwavpack=enabled \
-Dzeroconf=avahi \
-Dzzip=enabled \
-Dao=disabled \
-Daudiofile=disabled \
-Ddbus=disabled \
-Dexpat=disabled \
-Dfluidsynth=disabled \
-Dgme=disabled \
-Dipv6=disabled \
-Djack=disabled \
-Dlibsamplerate=disabled \
-Dnfs=disabled \
-Doss=disabled \
-Dpulse=disabled \
-Dsidplay=disabled \
-Dsmbclient=disabled \
-Dsndfile=disabled \
-Dsqlite=disabled \
-Dudisks=disabled \
-Dupnp=disabled \
-Dwildmidi=disabled \
output/release
ninja -C output/release
```

* Copy result to the moode location with the mpd executables:
```
sudo cp output/release/mpd /var/www/inc/mpd-0.21.23sr
```

Add this mpd version to the moode mpd selection list:
```
cd /var/www
sudo patch -b < /home/pi/dddac1794build/raspberrypi/software/tweaks/mpd_selective_resample/moode_mpdver_0.21.23sr.patch
```
Now you can select mpd version 0.21.23sr from the audio configure page.

* Enable  MPD Tweaks in MPD Configuration page
* In MPD Configuration > MPD Tweaks > General Parameters add the option
```
selective_44k_resample "yes"
```

* Press the save button at the top of the screen





## Change the number of visible albums on several device types
Instead of changing the original file, the new css media queries are placed in a separated file.
This file will first include the original one and then override.

```
cd /var/www/css
sudo mv /var/www/css/moode.min.css /var/www/css/moode.min.css.clean
sudo ln -s ~/dddac1794build/raspberrypi/software/tweaks/moode_albumcols/moode_additional_media.css moode.min.css
```
