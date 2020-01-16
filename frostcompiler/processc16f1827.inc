 banksel IOCBF
 movf IOCBF,w
 btfsc STATUS,Z
 goto hllnotisr%s
 ;clrf IOCBF
 ;banksel PORTB
 ;movf PORTB,f
