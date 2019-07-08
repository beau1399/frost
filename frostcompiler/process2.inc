 banksel PIR1
 btfss PIR1,TMR2IF
 goto hllnotisr%s
 bcf PIR1,TMR2IF
 