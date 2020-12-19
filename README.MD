This project is about creating a DAC system based on [DDDAC 1794 NOS](http://www.dddac.com/dddac1794.html) kits.
It uses a Raspberry Pi as audio source and includes a nice enclosure.

System exists out of:
* DDDAC 1794 system
 * DDDAC 1794 mainboard
 * 2 Deck DAC with Tent regulators
  * DDDAC 12V PS
  * 2 Cinemags 600/600L for audio output
* I2S audio source
 * Raspberry 3B
 * ~~Hifiberry Digi+ Pro~~
 * ~~Allo Isolator~~
 * Ian Canada Fifopi Q3 with two upgraded clocks
 * The Pi runs Moode Audio 7.0.0
 * Wired network
* Digital Inputs
  * 2 SPDIF
  * 1 Toslink
* Digital Output
  * 1 SPDIF with transformer
* Low noise 5 Volt for pi
* Separate low noise 5 Volt for isolator and the hifiberry
* Power controller for soft power down (kill power after Pi is down)
* Hifi2000 Galaxy enclosure with custom back and front panel
* OLED display with track information or source selection

More about the software install can be found in [README.MD](raspberrypi/software/README.MD).
