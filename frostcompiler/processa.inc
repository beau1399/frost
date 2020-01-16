 banksel INTCON
 btfss INTCON,RABIF
 goto hllnotisr%s
 bcf INTCON,RABIF
 banksel PORTA
 movf PORTA,f
