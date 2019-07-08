 banksel PIR1
 btfss PIR1,TMR1IF
 goto hllnotisr%s	
 bcf PIR1,TMR1IF
