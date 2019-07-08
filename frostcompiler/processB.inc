 banksel INTCON
 btfss INTCON,RABIF
 goto hllnotisr%s
 bcf INTCON,RABIF
 banksel PORTB
 movf PORTB,f
