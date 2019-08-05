




 
 

sfp_prrr CODE 
 


#define thk003 sfpaux00


#define thk002 sfpaux01


#define thk001 sfpaux02


#define thk000 sfpaux03


printf:  
#ifdef HLLMULTITASK
#ifdef HLLGUARDsfpaux 
 movf in_isr,f  
 btfsc STATUS,Z
 


 goto printf0
  

 POP
 banksel thk001 
 movwf thk001
 POP
 movwf thk000
 movlw '(' 
 PUSH
 FAR_CALL printf,printch 
 banksel thk000
 
 movlw '+' 
 btfss thk000,7 
 goto nomin
 
 movfw thk000
 andlw .127 
 movwf thk000 
 movlw '-' 
nomin: 
 PUSH
 FAR_CALL printf, printch 
 banksel thk000
 movfw thk000
 addlw .128 
 movwf thk000 
 movfw thk000 
 PUSH
 movlw .100 
 PUSH
 FAR_CALL printf, divu 
 FAR_CALL printf, ascii 
 FAR_CALL printf, printch 
 banksel thk000
 movfw thk000
 PUSH
 movlw .100 
 PUSH
 FAR_CALL printf, modu 
 movlw .10 
 PUSH
 FAR_CALL printf, divu 
 FAR_CALL printf, ascii 
 FAR_CALL printf, printch 
 
 banksel thk000 
 movfw thk000 
 PUSH
 movlw .10 
 PUSH
 FAR_CALL printf, modu 
 FAR_CALL printf, ascii 
 FAR_CALL printf, printch 
 movlw '/' 
 PUSH
 FAR_CALL printf, printch 
 movlw '1' 
 PUSH
 FAR_CALL printf, printch 
 movlw '2' 
 PUSH
 FAR_CALL printf, printch 
 movlw '8' 
 PUSH
 FAR_CALL printf, printch 
 movlw ')' 
 PUSH
 FAR_CALL printf, printch 
 movlw '*' 
 PUSH
 FAR_CALL printf, printch 
 movlw '2' 
 PUSH
 FAR_CALL printf, printch 
 movlw '^' 
 PUSH
 FAR_CALL printf, printch 
 banksel thk001 
 
 movlw '+' 
 btfss thk001,7 
 goto nomin2 
 movfw thk001 
 xorlw .255 
 addlw .1
 movwf thk001 
 movlw '-' 
nomin2: 
 PUSH
 FAR_CALL printf, printch 
 
 banksel thk001 
 movfw thk001 
 PUSH
 movlw .100 
 PUSH
 FAR_CALL printf, divu 
 FAR_CALL printf, ascii 
 FAR_CALL printf, printch 
 
 banksel thk001 
 movfw thk001 
 PUSH
 movlw .100 
 PUSH
 FAR_CALL printf, modu 
 movlw .10 
 PUSH
 FAR_CALL printf, divu 
 FAR_CALL printf, ascii 
 FAR_CALL printf, printch 
 
 banksel thk001 
 movfw thk001 
 PUSH
 movlw .10 
 PUSH
 FAR_CALL printf, modu
 FAR_CALL printf, ascii 
 FAR_CALL printf, printch 
 movlw ' '
 PUSH
 FAR_CALL printf, printch 
 
 return 



#undefine thk003


#undefine thk002


#undefine thk001


#undefine thk000


#define thk003 sfpaux00+1


#define thk002 sfpaux01+1


#define thk001 sfpaux02+1


#define thk000 sfpaux03+1


printf0:
#endif
#endif
  

 POP
 banksel thk001 
 movwf thk001
 POP
 movwf thk000
 movlw '(' 
 PUSH
 FAR_CALL printf,printch 
 banksel thk000
 
 movlw '+' 
 btfss thk000,7 
 goto hllEEAAA
 
 movfw thk000
 andlw .127 
 movwf thk000 
 movlw '-' 
hllEEAAA: 
 PUSH
 FAR_CALL printf, printch 
 banksel thk000
 movfw thk000
 addlw .128 
 movwf thk000 
 movfw thk000 
 PUSH
 movlw .100 
 PUSH
 FAR_CALL printf, divu 
 FAR_CALL printf, ascii 
 FAR_CALL printf, printch 
 banksel thk000
 movfw thk000
 PUSH
 movlw .100 
 PUSH
 FAR_CALL printf, modu 
 movlw .10 
 PUSH
 FAR_CALL printf, divu 
 FAR_CALL printf, ascii 
 FAR_CALL printf, printch 
 
 banksel thk000 
 movfw thk000 
 PUSH
 movlw .10 
 PUSH
 FAR_CALL printf, modu 
 FAR_CALL printf, ascii 
 FAR_CALL printf, printch 
 movlw '/' 
 PUSH
 FAR_CALL printf, printch 
 movlw '1' 
 PUSH
 FAR_CALL printf, printch 
 movlw '2' 
 PUSH
 FAR_CALL printf, printch 
 movlw '8' 
 PUSH
 FAR_CALL printf, printch 
 movlw ')' 
 PUSH
 FAR_CALL printf, printch 
 movlw '*' 
 PUSH
 FAR_CALL printf, printch 
 movlw '2' 
 PUSH
 FAR_CALL printf, printch 
 movlw '^' 
 PUSH
 FAR_CALL printf, printch 
 banksel thk001 
 
 movlw '+' 
 btfss thk001,7 
 goto hllEEAAA2 
 movfw thk001 
 xorlw .255 
 addlw .1
 movwf thk001 
 movlw '-' 
hllEEAAA2: 
 PUSH
 FAR_CALL printf, printch 
 
 banksel thk001 
 movfw thk001 
 PUSH
 movlw .100 
 PUSH
 FAR_CALL printf, divu 
 FAR_CALL printf, ascii 
 FAR_CALL printf, printch 
 
 banksel thk001 
 movfw thk001 
 PUSH
 movlw .100 
 PUSH
 FAR_CALL printf, modu 
 movlw .10 
 PUSH
 FAR_CALL printf, divu 
 FAR_CALL printf, ascii 
 FAR_CALL printf, printch 
 
 banksel thk001 
 movfw thk001 
 PUSH
 movlw .10 
 PUSH
 FAR_CALL printf, modu
 FAR_CALL printf, ascii 
 FAR_CALL printf, printch 
 movlw ' '
 PUSH
 FAR_CALL printf, printch 
 
 return 



#undefine thk003


#undefine thk002


#undefine thk001


#undefine thk000
sfp_ddbasc CODE 
 
ascii:
 POP
 addlw '0' 
 PUSH
 return

 
 