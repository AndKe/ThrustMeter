
/*

todo:
-efficiency mode: for xx throttle for xx seconds.  - measure power consumed. (measure mAh, Wh consumed)
-add a "playback" mode for throttle with repeatable varaition within a given range, for xx seconds. (measure mAh, Wh consumed.)
-add a sync-test mode, run 5-20, 5-50 jump routine. 

1.0  Initial version.


Leonardo
USB == Serial
RX/TX == Serial1

----------------------------------------------
0tx
1rx
2 LCD
3-BTN_Run
4 LCD
5-LCD
6-LCD
7 LCD
8 LCD
9-LCD
10-PWM Out (ESC)  //Counter1 capable PWM output(PB6) , default 490hz PWM
11-
12
13-

A0 analog I in
A1 analog V in
A2 PowerLED
A3
A4
A5
------------------------------------------------
HD44780 pinout *=needed
1 GND
2 +5V
3 Contrast adj.
4 RS*
5 RW*
6 EN*
7 DB0
8 f
9 DB2
10DB3
11DB4*
12DB5*
13DB6*
14DB7*
15 backlit +
16 Baklit GND
*/

#include <Servo.h>

Servo ESC;

//#define DEBUG
//#define DEBUG_g
//#define DEBUG_V
//#define DEBUG_I
//#define DEBUG_Imul

#ifndef cbi
#define cbi(sfr, bit) (_SFR_BYTE(sfr) &= ~_BV(bit))
#endif
#ifndef sbi
#define sbi(sfr, bit) (_SFR_BYTE(sfr) |= _BV(bit))
#endif


#include <LiquidCrystal.h>
#define LCD_RS 2
#define LCD_RW 4
#define LCD_EN 5
#define LCD_D4 6
#define LCD_D5 7
#define LCD_D6 8
#define LCD_D7 9
#define LCD_CHARS 20
#define LCD_LINES 4
LiquidCrystal lcd(LCD_RS, LCD_RW, LCD_EN, LCD_D4, LCD_D5, LCD_D6, LCD_D7);
#define Ipin  A0  //reads 0-1024 (
#define Vpin  A1
#define Gpin  A2
#define ESCpin 10

#define b_run 3

//#define mVA 0.02 //ACS758 100A returns 20mV/Amp.
//#define mVA 0.04 //ACS758 50A returns 40mV/Amp.

#define Vmul 0.0247723705 //Voltage per AD step, 28v/1024 steps.
#define Imul 0.039
//2.54v/1024= 0,002392578 v/step.   100A sensor = 40mV/Step.  ca 16,7 steps per A. teoretisk 1A  = AD d16  ,= multiplier:  0,05981445    Hvis AD er 256 = , betyr det ca 15.329A
#define ADiOffset 0  // AD offset,  (measured when No current)
#define gmul 5.7452488  // Thrust multiplicator
#define ADgOffset 27  // Thrust Offset


float V = 0;  //sensed voltage
float I = 0;  //sensed current
float gw = 0;  //gram/watt
float maxgw = 0;  //gram/watt
float W = 0; //calculated power
float maxW = 0;
bool active = false;
bool newdata = false;
unsigned long millisLCD = 0;
unsigned long millisBTN = 0;
unsigned long millisNOBTN = 0;
unsigned long millisSEC = millis();
unsigned long millisAD = 0; //last AD average
int BTNseq = 0; //how many passes did we had w/o buton press.
uint16_t Ia ;//Analog read I
uint16_t Va ;//Analog read V
float g = 0 ;//Analog read thrust (gram)
float maxg = 0;//Analog read thrust (gram)



uint16_t ADi = 0; //AD raw data
uint32_t ADDi = 0;      // the readings from the analog input
uint16_t ADDicount = 0;
uint16_t ADv = 0;
uint32_t ADDv = 0;
uint16_t ADDvcount = 0;
uint16_t ADg = 0;
uint32_t ADDg = 0;
uint16_t ADDgcount = 0;
uint8_t  throttle = 0;
uint8_t  maxgthrottle = 0;
uint8_t  maxgwthrottle = 0;
void setup() {

  pinMode(b_run, INPUT_PULLUP);
  pinMode(Gpin, INPUT);
  pinMode(Ipin, INPUT);
  pinMode(Vpin, INPUT);
  pinMode(ESCpin, OUTPUT);

  lcd.begin(LCD_CHARS, LCD_LINES);
  lcd.clear();

  ESC.attach(ESCpin);


#ifdef DEBUG
  delay(2000);
  Serial.begin(115200);
  //while (!Serial) ;// wait for serial port to connect. Needed for Leonardo only
#endif
  CalibrateESC();

}


void loop() {

  //*********** UPDATE LCD
  if (millis() - millisLCD > 150)  {
    UpdateLCD();
  }

  if (millis() - millisSEC >= 300 && !digitalRead(b_run))  {  //if more than half a sec since last throttle change, calculate

    if (g > maxg) {
      maxg = g;   //new highest thrust
      maxgthrottle = throttle;
    }
    if (g / W > maxgw && W!=0 && g!=0) {maxgw = g / W;  maxgwthrottle = throttle;} //max grams
  }


  //*********** Process standard AD inputs
  ADi = ReadADC(0);  //I = A0
  //if (ADi >=ADiOffset) ADi = ADi - ADiOffset; else ADi=0 ;//   suitable for 100A sensor
  ADDi = ADDi + ADi;
  ADDicount ++;

  ADv = ReadADC(1);  //V = A1
  ADDv = ADDv + ADv;
  ADDvcount ++;

  ADg  = ReadADC(2);  //thrust = A2
  if (ADg >= ADgOffset)   ADDg = ADDg + (ADg - ADgOffset) ;
  ADDgcount ++;


  if (millis() - millisAD > 100)  {    //sample AD continously and read out after xx ms.
    millisAD = millis();
    I = (ADDi / ADDicount) * Imul;
    //Serial.println(ADDicount);
    ADDicount = 0;
    ADDi = 0;
    // PWMout();

    V = (ADDv / ADDvcount) * Vmul;
    ADDvcount = 0;
    ADDv = 0;

    W = I * V;
    if (W > maxW) maxW=W;
    if (W > 0) gw = g / W; else gw = 0;

    g = (ADDg / ADDgcount) * gmul;
    newdata=true;
//Serial.println(ADDgcount);  //4 is max
    ADDgcount = 0;
    ADDg = 0;


  }



    
  if (!digitalRead(b_run))  {  //button pressed
  
  if (newdata) { Writelog(); newdata=false;}
    //buttom pressed, START procedure
    if (!active) { //We have just started, clear old stats
      maxg = 0;  //max grams
      maxgw = 0; //max grams/W
      maxW=0;
      maxgthrottle = 0;//throttle @ max grams
      maxgwthrottle = 0; //throttle @ max efficiency
      millisSEC = millis();  //start counter
      active = true;
    }

    //are we in soft-start range ?
    if (throttle <  15 && (millis() - millisSEC) > 300)    {
      throttle += 1;  // do slow start with 1% each 300ms
      ESC.write((throttle + 40)); //  0...180 are valid position
      millisSEC = millis();  //count time since last increase
    } else {     //now normal throttle increase
      if (throttle <  100 && throttle >= 15 && (millis() - millisSEC) > 980) {
        throttle += 5;
        ESC.write((throttle + 40)); //  0...180 are valid position
        millisSEC = millis();  //count time since last increase
      }
    }
    while (throttle == 100 && (millis() - millisSEC) > 980 && !digitalRead(b_run)) {
          ESC.write((0 + 40)); //  0...180 are valid position
          delay(300);
      }
    
  } else {     //button not pressed
    if (active) {
    throttle = 0;
    ESC.write(40);   //  0...180 are valid position
    active=false;
    }
       if ((millis() - millisSEC) > 1980) {
        Writelog();  //if idle, log every 2 sec
        millisSEC = millis();  //start counter  
    }

  }


} //end loop


