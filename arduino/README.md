This file is meant to be used on an Arduino Pro Mini 5v or 3.3v
This following program will be used to monitor Ignition Position and either Boot or Shutdown the Raspberry Pi 
The Arduino Pro Mini can be set into a "Powered Down State" that requires only a few µA to run in this state
There are a couple physical alterations that need to be done to the Arduino for the board to use so little amperage which can be found here : http://www.home-automation-community.com/arduino-low-power-how-to-run-atmega328p-for-a-year-on-coin-cell-battery/
You will need an external library which can be found here: https://github.com/rocketscream/Low-Power
The library can also be found through manage libraries in the Arduino Desktop Program (you will need to add it manually)
If you end up trying to cheap out and don't buy an arduino board, at least make sure the board uses a supported chipset for the LowPower library
