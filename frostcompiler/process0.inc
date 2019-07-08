 banksel INTCON
 btfss INTCON,T0IF
 goto hllnotisr%s
 bcf INTCON,T0IF
