



 
 

hllcmppic CODE



#define mkarg1 hllblss00


geu:  
#ifdef HLLMULTITASK
#ifdef HLLGUARDhllblss 
 movf in_isr,f  
 btfsc STATUS,Z
 


 goto geu0


 POP
 banksel mkarg1
 movwf mkarg1	 
 POP
 subwf mkarg1,w
 btfsc STATUS,Z
 goto mxhbl
 btfsc STATUS,C
 goto mxhbm
mxhbl:
 movlw .1
 PUSH
 
 return
mxhbm:
 movlw .0
 PUSH
 
 return



#undefine mkarg1


#define mkarg1 hllblss00+1


geu0:
#endif
#endif


 POP
 banksel mkarg1
 movwf mkarg1	 
 POP
 subwf mkarg1,w
 btfsc STATUS,Z
 goto hllLAAAA
 btfsc STATUS,C
 goto hllMAAAA
hllLAAAA:
 movlw .1
 PUSH
 
 return
hllMAAAA:
 movlw .0
 PUSH
 
 return



#undefine mkarg1
