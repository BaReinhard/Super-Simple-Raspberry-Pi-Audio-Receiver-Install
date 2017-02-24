// This file is meant to be used on an Arduino Pro Mini 5v or 3.3v
// This following program will be used to monitor Ignition Position and either Boot or Shutdown the Raspberry Pi 
// The Arduino Pro Mini can be set into a "Powered Down State" that requires only a few µA to run in this state
// There are a couple physical alterations that need to be done to the Arduino for the board to use so little amperage which can be found here : http://www.home-automation-community.com/arduino-low-power-how-to-run-atmega328p-for-a-year-on-coin-cell-battery/
// You will need an external library which can be found here: https://github.com/rocketscream/Low-Power
// The library can also be found through manage libraries in the Arduino Desktop Program (you will need to add it manually)
// If you end up trying to cheap out and don't buy an arduino board, at least make sure the board uses a supported chipset for the LowPower library

// **** INCLUDES *****
#include "LowPower.h"

// Use pin 2 as wake up pin
const int accPin = 2;
const int shutDownPin = 3;
const int switchPin = 4;
int ignitionPosition = 0;
unsigned long piBootCounter = 0;
void wakeUp()
{
    // Just a handler for the pin interrupt. Needs to be empty
}

void setup()
{
    // Configure wake up pin as input.
    // This will consumes few uA of current.
    pinMode(accPin, INPUT);
    pinMode(shutDownPin,OUTPUT);
    pinMode(switchPin,OUTPUT);
}

void loop() 
{
    // Allow wake up pin to trigger interrupt on low.
    attachInterrupt(accPin, wakeUp, HIGH);
    
    // Enter power down state with ADC and BOD module disabled.
    // Wake up when ignition (acc) pin is high
    LowPower.powerDown(SLEEP_FOREVER, ADC_OFF, BOD_OFF); 
    
    // Disable external pin interrupt on wake up pin.
    detachInterrupt(accPin); 
    
    // Turn on the Pi, this pin will be connected to a Relay that powers the Pi
    digitalWrite(switchPin,HIGH);
    
    // While the ignition is on, wait check that the ignition is still on.
    do{
    ignitionPosition = digitalRead(accPin)
    delay(1000);
    piBootCount++;
    }while(!ignitionPosition)
    
    // Once ignition is turned off, Set the shutdown Pin to High, The Pi, will need a script to monitor this pin and shutdown when its HIGH
    digitalWrite(shutDownPin,HIGH);
    
    //Wait 2 minutes before reseting the output pins to low and looping back into a Power Down State to manage
    if (piBootCounter > 10){
    delay(120000);
    }
    digitalWrite(switchPin,LOW);
    digitalWrite(shutDownPin,LOW);
    piBootCounter = 0;
    
}
