 
 ;This only works on next generation PICs w/ extra timers, e.g. PIC16F1827
 
 banksel PIR3
 btfss PIR3,TMR4IF
 goto hllnotisr%s
 bcf PIR3,TMR4IF
 