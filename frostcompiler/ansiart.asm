





 
 

 


ansiadt udata
aart00 RES .1
#ifdef HLLMULTITASK
#ifdef HLLGUARDaart
aart00isr RES .1
#endif 
#endif 
aart01 RES .1
#ifdef HLLMULTITASK
#ifdef HLLGUARDaart
aart01isr RES .1
#endif 
#endif 
aart02 RES .1
#ifdef HLLMULTITASK
#ifdef HLLGUARDaart
aart02isr RES .1
#endif 
#endif 

 
ansiara CODE

ansiadu udata
aartpr00 RES .1
#ifdef HLLMULTITASK
#ifdef HLLGUARDaartpr
aart00prisr RES .1
#endif 
#endif 

cprntuc CODE



#define margpi aartpr00


printu:  
#ifdef HLLMULTITASK
#ifdef HLLGUARDaartpr 
 movf in_isr,f  
 btfsc STATUS,Z
 


 goto printu0

 POP
 banksel margpi
 movwf margpi
 PUSH
 movlw .100 
 PUSH
 FAR_CALL printu,divu
 POP
 addlw '0' 
 PUSH
 FAR_CALL printu, printch
 banksel margpi 
 movfw margpi
 PUSH
 movlw .100 
 PUSH
 FAR_CALL printu, modu
 movlw .10
 PUSH
 FAR_CALL printu, divu
 POP
 addlw '0' 
 PUSH
 FAR_CALL printu, printch
 banksel margpi
 movfw margpi
 PUSH
 movlw .10 
 PUSH
 FAR_CALL printu, modu
 POP
 addlw '0' 
 PUSH
 FAR_CALL printu, printch  
 return



#undefine margpi


#define margpi aartpr00+1


printu0:
#endif
#endif

 POP
 banksel margpi
 movwf margpi
 PUSH
 movlw .100 
 PUSH
 FAR_CALL printu,divu
 POP
 addlw '0' 
 PUSH
 FAR_CALL printu, printch
 banksel margpi 
 movfw margpi
 PUSH
 movlw .100 
 PUSH
 FAR_CALL printu, modu
 movlw .10
 PUSH
 FAR_CALL printu, divu
 POP
 addlw '0' 
 PUSH
 FAR_CALL printu, printch
 banksel margpi
 movfw margpi
 PUSH
 movlw .10 
 PUSH
 FAR_CALL printu, modu
 POP
 addlw '0' 
 PUSH
 FAR_CALL printu, printch  
 return



#undefine margpi
