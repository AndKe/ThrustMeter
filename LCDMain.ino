void UpdateLCD() {
  lcd.noCursor();
  lcd.setCursor(0, 0);
  lcd.print(V,2);
  lcd.print("V");
  if (V < 10)  lcd.print(" ");
  lcd.setCursor(7, 0);
  if (I < 10)  lcd.print(" ");
  lcd.print(I,2);
  lcd.print("A");

  lcd.setCursor(14 ,0);
  lcd.print(W,0);
  lcd.print("W");
  if (W < 1000) lcd.print(" ");
  if (W < 100) lcd.print(" ");
  if (W < 10)  lcd.print(" ");   


  lcd.setCursor(0, 1);
  lcd.print(g,0);
  lcd.print("g");
  if (g < 1000) lcd.print(" ");
  if (g < 100) lcd.print(" ");
  if (g < 10)  lcd.print(" ");


  lcd.setCursor(6, 1);
  lcd.print(gw,1);
  lcd.print("g/W");
  if (gw < 100) lcd.print(" ");
  if (gw < 10)  lcd.print(" ");


  lcd.setCursor(14, 1);
  lcd.print("@ ");
  lcd.print(throttle);
  lcd.print("%");
  if (throttle < 100) lcd.print(" ");
  if (throttle < 10)  lcd.print(" ");

  lcd.setCursor(0, 2);
  lcd.print("M.eff ");
  lcd.print(maxgw,1);
  lcd.print("g/W");
  if (maxgw < 10)  lcd.print(" ");
  
  lcd.setCursor(14, 2);
  lcd.print("@ ");
  lcd.print(maxgwthrottle);
  lcd.print("%");
  if (maxgwthrottle < 100) lcd.print(" ");
  if (maxgwthrottle < 10)  lcd.print(" ");
  

  lcd.setCursor(0, 3);
  lcd.print("Max ");
  lcd.print(maxg,0);
  lcd.print("g ");
  lcd.print(maxgthrottle);
  lcd.print("% ");
  lcd.print(maxW,0);
  lcd.print("W");
  if (maxW < 100) lcd.print(" ");
  if (maxW < 10)  lcd.print(" ");
  lcd.print("   ");

#ifdef DEBUG_V  
  lcd.print("raw");
  lcd.print(ADv);
  if (ADv < 1000) lcd.print(" ");
  if (ADv < 100) lcd.print(" ");
  if (ADv < 10)  lcd.print(" ");
#endif
#ifdef DEBUG_I  
  lcd.print("raw");
  lcd.print(ADi);
  if (ADi < 1000) lcd.print(" ");
  if (ADi < 100) lcd.print(" ");
  if (ADi < 10)  lcd.print(" ");
#endif
#ifdef DEBUG_g  
  lcd.setCursor(13, 3);
  lcd.print("raw");
  lcd.print(ADg);
  if (ADg < 1000) lcd.print(" ");
  if (ADg < 100) lcd.print(" ");
  if (ADg < 10)  lcd.print(" ");
#endif

}

/*
Display 4x20
01234567890123456789
--------------------
14.72V 30.20A 501W
1032g 16.2g/W @ 100%
M.eff 20.1g/W @ 22%
Max 1200g 100% 123W
*/



