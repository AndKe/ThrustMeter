

uint16_t ReadADC(int port)  //10bit AD with 2.56v internal referance
{
  if (port == 0) ADMUX = (1 << REFS1) | (1 << REFS0) | (0 << MUX4) | (0 << MUX3) | (1 << MUX2) | (1 << MUX1) | (1 << MUX0); // 2.56v referance port A0
  if (port == 1) ADMUX = (1 << REFS1) | (1 << REFS0) | (0 << MUX4) | (0 << MUX3) | (1 << MUX2) | (1 << MUX1) | (0 << MUX0); // 2.56v referance port A1
  if (port == 2) ADMUX = (1 << REFS1) | (1 << REFS0) | (0 << MUX4) | (0 << MUX3) | (1 << MUX2) | (0 << MUX1) | (1 << MUX0); // 2.56v referance port A2
  ADCSRA |= _BV(ADSC);                // Start conversion
  while (!bit_is_set(ADCSRA, ADIF));  // Loop until conversion is complete
  ADCSRA |= _BV(ADIF);   // Clear ADIF by writing a 1 (this sets the value to 0)
  return (ADC);
}


void PWMout() {

W = V * I;

     
  }

void  CalibrateESC() {
  lcd.noCursor();
  lcd.setCursor(4, 0);
  lcd.print("Thrust Meter");
  lcd.setCursor(2, 2);
  lcd.print("ESC Calibration");
  
  ESC.write(140);   //  0...180 are valid position 
  delay(5000);
  ESC.write(40);   //  0...180 are valid position
  lcd.clear(); 
}

    

void Writelog() {
//*********** Logging data
//$1;state(int);time(ms);V;I;W;throttle;g;gw;checksum (LF)
Serial.print("$1"); //start+dataset
Serial.write(59); //separator ;
Serial.print(active);
Serial.write(59); //separator ;
Serial.print(millis());
Serial.write(59); //separator ;
Serial.print(V * 100, 0);
Serial.write(59); //separator ;
Serial.print(I * 100, 0);
Serial.write(59); //separator ;
Serial.print(W * 10, 0);
Serial.write(59);   //separator ;
Serial.print(throttle);
Serial.write(59); //separator ;
Serial.print(g * 10, 0);
Serial.write(59); //separator ;
Serial.print(gw * 10, 0);
Serial.write(59); //separator ;
Serial.print("0"); // dummy checksum
Serial.println(""); //LF.
//*********** Debugging data
}

