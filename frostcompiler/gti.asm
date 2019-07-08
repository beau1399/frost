



 
 

hllcmppdd CODE



#define mkarg2 hllblss00


#define mkarg1 hllblss01


gti:  
#ifdef HLLMULTITASK
#ifdef HLLGUARDhllblss 
 movf in_isr,f  
 btfsc STATUS,Z
 


 goto gti0


 
 
 
 
 
 
 POP 
 banksel mkarg1
 
 movwf mkarg1		
 btfsc mkarg1,7
 goto $+15
 POP
 
 movwf mkarg2 
 btfss mkarg2,7
 
 goto bdlbl
 movlw .0
 PUSH
 
 return
 bdlbl: subwf mkarg1,w 
 btfsc STATUS,C    
 goto $+5
 movlw .1
 PUSH
 
 return
 movlw .0
 PUSH
 
 return
 POP
 
 movwf mkarg2
 btfsc mkarg2,7
 goto $-0F
 movlw .1
 PUSH
 
 return
 


#undefine mkarg2


#undefine mkarg1


#define mkarg2 hllblss00+1


#define mkarg1 hllblss01+1


gti0:
#endif
#endif


 
 
 
 
 
 
 POP 
 banksel mkarg1
 
 movwf mkarg1		
 btfsc mkarg1,7
 goto $+15
 POP
 
 movwf mkarg2 
 btfss mkarg2,7
 
 goto hllKAAAA
 movlw .0
 PUSH
 
 return
 hllKAAAA: subwf mkarg1,w 
 btfsc STATUS,C    
 goto $+5
 movlw .1
 PUSH
 
 return
 movlw .0
 PUSH
 
 return
 POP
 
 movwf mkarg2
 btfsc mkarg2,7
 goto $-0F
 movlw .1
 PUSH
 
 return
 


#undefine mkarg2


#undefine mkarg1
