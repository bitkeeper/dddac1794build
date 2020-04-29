/*
 * M. van de Weert 
 * mvdweert@bitlab.nl
 * 26-11-2017
 * 
 * Pi Power Switch
 * 
   Soft power off controller for the Raspberry PI.
   board package: https://raw.githubusercontent.com/damellis/attiny/ide-1.6.x-boards-manager/package_damellis_attiny_index.json

  Summary:
  Goal is turn on and off a Raspberry Pi with momentary switch, while using no power when it is off.

  Used setup:
  - tiny85 or tinker85 board (without bootloader, else it takes to long to activate relais on press button)
  - momentary DPTD switch 2xno
  - Power led (integrated in to the switch)
  - Relais board
  - 5 Volt power supply

  For interface with the PI
  - Skotty Diode + 1k resistor (3.3V input protection)
    
  The relais is used to swith the 230/115V for the power supply.
  One side momentary 

    Use a moment
  Use a momentary DPTD switch to switch on 
*/

/* ----------------------------------------------------------
 * Hardware mapping tinker85 / tiny85 
 * ----------------------------------------------------------
 */
const int relaisPin          = 4; //OUT
const int buttonPin          = 2; //IN
const int ledPin             = 3; //OUT
const int piPowerStatePin    = 0; //IN
const int piPowerDownRequest = 1; //OUT

// depending on your relais electronics; active high or low
// active LOW:
/*
const static int POWERON = LOW;
const static int POWEROFF = HIGH;
*/
// active HIGH:
const static int POWERON = HIGH;
const static int POWEROFF = LOW;
  
/* ---------------------------------------------------------- 
 * States of application 
 * ----------------------------------------------------------
 */
const static int WAITPIPOWER      = 1;
const static int IDLE             = 2;
const static int POWERDOWNTIMEOUT = 4;
const static int POWERDOWN        = 5;
const static int WAITPOWERDOWNACK = 6;


//const static int POWERDOWNACKTIMEOUT = 2000;
const static int POWERDOWNDELAY = 8000;

/* ----------------------------------------------------------
 * TIMER Ids 
 * ----------------------------------------------------------
 */
const static int TM_LEDBLINK  = 0;
const static int TM_PWDNDELAY = 1;

/*
 * Application variables
 */
// Application State
int state = WAITPIPOWER;

int buttonState = 0;
int lastButtonState = 1;

bool ledPinState = true;

/*----------------------------------------------------------
 * TIMER API
 *----------------------------------------------------------
 */ 
//vars for timer api
const static int MAX_TIMERS         = 3; 
int timerTicks[MAX_TIMERS]          = {0, 0, 0}; // setting per timer
unsigned long prev_time[MAX_TIMERS] = {0, 0, 0}; // last time for each timer

// set the configuration for each timer.
// for reuse; also required after the timer is fired.
void setTimer(unsigned int number, int time) {
  timerTicks[number] = time;
  prev_time[number] = millis();
}

// update timer and returns if it has fired (=reached time)
bool timerUpdate(unsigned int number) {
  timerTicks[number] -= millis() - prev_time[number];
  prev_time[number] = millis();
  return timerTicks[number] <= 0;
}

//----------------------------------------------------------
void blink_led(int pulse_on, int pulse_off) {
  if ( ledPinState ) {
    digitalWrite(ledPin, HIGH);
    setTimer(TM_LEDBLINK, pulse_on);
  } else {
    digitalWrite(ledPin, LOW);
    setTimer(TM_LEDBLINK, pulse_off);
  }
  ledPinState = !ledPinState;
}

//----------------------------------------------------------
void setup() {
  pinMode(relaisPin, OUTPUT);
  pinMode(ledPin, OUTPUT);  
  pinMode(buttonPin, INPUT_PULLUP);

  pinMode(piPowerDownRequest, OUTPUT);
  pinMode(piPowerStatePin, INPUT);

  digitalWrite(relaisPin, POWERON);
  digitalWrite(ledPin, LOW);
  digitalWrite(piPowerDownRequest, LOW);
  
  delay(30);
  lastButtonState = digitalRead(buttonPin);
}

void loop() {
  if (state == WAITPIPOWER) {
    // Ok pi is awake goto IDLE
    if (digitalRead(piPowerStatePin) == HIGH )
    {
      state = IDLE;
      digitalWrite(ledPin, HIGH);
    }
    else {
      if (timerUpdate(TM_LEDBLINK) ) {
        blink_led(800,200);
      }
    }
  }  
  else if (state == IDLE) {
    buttonState = digitalRead(buttonPin);
    // Power button is pressed to request a power down
    if (buttonState != lastButtonState) {           
      if (buttonState == LOW) {
        state = WAITPOWERDOWNACK;
        // Make powerdown request to Pi
        digitalWrite(piPowerDownRequest, HIGH);       
      };
    }
    // Pi indicates it is going down by itself
    else if (digitalRead(piPowerStatePin) == LOW ){
      state = POWERDOWNTIMEOUT;
      digitalWrite(piPowerDownRequest, LOW);
      setTimer(TM_PWDNDELAY, POWERDOWNDELAY);      
    }
    lastButtonState = buttonState;
  }
  else if (state == WAITPOWERDOWNACK) {
    // Pi acknowledge PowerDown request completed by lowering the powerstatepin
    if (digitalRead(piPowerStatePin) == LOW )
    {
      state = POWERDOWNTIMEOUT;
      digitalWrite(piPowerDownRequest, LOW);
      setTimer(TM_PWDNDELAY, POWERDOWNDELAY);
    }    
    else {
      if (timerUpdate(TM_LEDBLINK) ) {
         blink_led(500,500);
      }
    }
  }
  else if (state == POWERDOWNTIMEOUT) {
    if (timerUpdate(TM_PWDNDELAY)) {
      state = POWERDOWN;
    } else {
      if (timerUpdate(TM_LEDBLINK) ) {
        blink_led(200,800);
      }      
    }
  }
  else if (state == POWERDOWN) {    
    digitalWrite(relaisPin, POWEROFF);
    
    // makes it easier to see when the C's of the PS are empty
    if (timerUpdate(TM_LEDBLINK) ) {
        blink_led(50,950);
    }      

    // not needed, but helps with simulation
    state = POWERDOWN;
    buttonState = 0;
    lastButtonState = 1;        
  }
  delay(10);
}


