




 


 
ansiard CODE




#define charx aart00


#define ansiG aart01


graphx:  
#ifdef HLLMULTITASK
#ifdef HLLGUARDaart 
 movf in_isr,f  
 btfsc STATUS,Z
 


 goto graphx0



 
 movlw 0x1b
 PUSH
 FAR_CALL graphx,printch
 movlw '['
 PUSH
 FAR_CALL graphx,printch
 FAR_CALL graphx,printu
 movlw ';'
 PUSH
 FAR_CALL graphx,printch
 FAR_CALL graphx,printu
 movlw 'H'
 PUSH
 FAR_CALL graphx,printch
 

 POP
 banksel charx
 movwf charx
 
 xorlw .0 
 btfsc STATUS,Z
 goto allgxy
 banksel ansiG
 movwf ansiG
lblgxy22:
 movlw 0xDB
 PUSH
 FAR_CALL graphx,printch
 banksel ansiG
 decfsz ansiG,f
 goto lblgxy22
 
allgxy: 
 banksel charx
 movf charx,w
 subwf HLINDF,f
 POP
 xorlw .0 
 btfsc STATUS,Z
 goto retgxy
 banksel ansiG
 movwf ansiG
lblgxy3:
 movlw 0xB0 
 PUSH
 FAR_CALL graphx,printch
 banksel ansiG
 decfsz ansiG,f
 goto lblgxy3
retgxy:

 
 return



#undefine charx


#undefine ansiG


#define charx aart00+1


#define ansiG aart01+1


graphx0:
#endif
#endif



 
 movlw 0x1b
 PUSH
 FAR_CALL graphx,printch
 movlw '['
 PUSH
 FAR_CALL graphx,printch
 FAR_CALL graphx,printu
 movlw ';'
 PUSH
 FAR_CALL graphx,printch
 FAR_CALL graphx,printu
 movlw 'H'
 PUSH
 FAR_CALL graphx,printch
 

 POP
 banksel charx
 movwf charx
 
 xorlw .0 
 btfsc STATUS,Z
 goto hllBAAAA
 banksel ansiG
 movwf ansiG
hllAAAAA:
 movlw 0xDB
 PUSH
 FAR_CALL graphx,printch
 banksel ansiG
 decfsz ansiG,f
 goto hllAAAAA
 
hllBAAAA: 
 banksel charx
 movf charx,w
 subwf HLINDF,f
 POP
 xorlw .0 
 btfsc STATUS,Z
 goto hllDAAAA
 banksel ansiG
 movwf ansiG
hllCAAAA:
 movlw 0xB0 
 PUSH
 FAR_CALL graphx,printch
 banksel ansiG
 decfsz ansiG,f
 goto hllCAAAA
hllDAAAA:

 
 return



#undefine charx


#undefine ansiG
