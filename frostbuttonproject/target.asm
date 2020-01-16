
#include "hloe.inc"

 __config  _CONFIG1,_WDTE_OFF  & _BOREN_OFF & _FOSC_INTOSC & _PWRTE_OFF & _MCLRE_OFF & _CLKOUTEN_OFF & _IESO_OFF & _FCMEN_OFF
 __config  _CONFIG2,_PLLEN_ON & _STVREN_ON & _LVP_OFF



Resetv code 0 
 bcf INTCON,GIE
 pagesel hloego
 goto hloego
 
#ifdef HLLMULTITASK
vectr code 4	 ;Device specific
ISR:


 PREEMPT
#endif
 banksel PIR1
 btfss PIR1,TMR1IF
 goto hllnotisr49	
 bcf PIR1,TMR1IF


 movlw .1 

   
 FAR_CALL ISR ,safepush

   banksel PORTA
   movfw PORTA
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL ISR,clearbit

 POP
 banksel PORTA
 movwf PORTA
 


hllnotisr49:

 banksel IOCBF
 movf IOCBF,w
 btfsc STATUS,Z
 goto hllnotisr98
 clrf IOCBF
 banksel PORTB
 movf PORTB,f


 movlw .1 

   
 FAR_CALL ISR ,safepush

   banksel PORTA
   movfw PORTA
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL ISR,setbit

 POP
 banksel PORTA
 movwf PORTA
 


hllnotisr98:








#ifdef HLLMULTITASK
ExitISR:    
 
 RESUME
 
 retfie
#endif

mainvars udata_shr	
#ifdef HLLMULTITASK
pbase res .1			; Used for functions w/ numbered pass/return, to clean up parms/push args
pbaseisr res .1	
#else
pbase res .1
#endif

main code
hloego:

  clrf in_isr
 
  movlw LOW (stack-1)		;Set up stack starting position based on literals det. by incremental linker
  movwf FSR0L 
  movlw HIGH (stack-1)
  movwf FSR0H
 
  
 movlw LOW (alt_stack-1)
 movwf FSR1L
 movlw HIGH (alt_stack-1)
 movwf FSR1H
 
 
 clrf softstack0 
 
 
 pagesel hlluserprog
 goto hlluserprog

hllupuser CODE
hlluserprog: 
 

 movlw .112 

   
 FAR_CALL hlluserprog ,safepush


 movlw .247 

   
 FAR_CALL hlluserprog ,safepush

   banksel OSCCON
   movfw OSCCON
   
   

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL andu


 
 FAR_CALL hlluserprog,oru

 POP
 banksel OSCCON
 movwf OSCCON
 


 movlw .7 

   
 FAR_CALL hlluserprog ,safepush

   banksel OPTION_REG
   movfw OPTION_REG
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL hlluserprog,clearbit

 POP
 banksel OPTION_REG
 movwf OPTION_REG
 


 movlw GIE


   
 FAR_CALL hlluserprog ,safepush


 movlw IOCIE


   
 FAR_CALL hlluserprog ,safepush

   banksel INTCON
   movfw INTCON
   
   

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL setbit


 
 FAR_CALL hlluserprog,setbit

 POP
 banksel INTCON
 movwf INTCON
 


 movlw .16 

   
 FAR_CALL hlluserprog ,safepush

 POP
 banksel IOCBP
 movwf IOCBP
 


 movlw .16 

   
 FAR_CALL hlluserprog ,safepush

 POP
 banksel TRISB
 movwf TRISB
 


 movlw .0 

   
 FAR_CALL hlluserprog ,safepush

 POP
 banksel ANSELB
 movwf ANSELB
 


 movlw .16 

   
 FAR_CALL hlluserprog ,safepush

 POP
 banksel WPUB
 movwf WPUB
 


 movlw .0 

   
 FAR_CALL hlluserprog ,safepush

 POP
 banksel TRISA
 movwf TRISA
 


 movlw .0 

   
 FAR_CALL hlluserprog ,safepush

 POP
 banksel ANSELA
 movwf ANSELA
 


 movlw TMR1CS0


   
 FAR_CALL hlluserprog ,safepush


 movlw TMR1GE


   
 FAR_CALL hlluserprog ,safepush


 movlw T1CKPS1


   
 FAR_CALL hlluserprog ,safepush


 movlw T1CKPS0


   
 FAR_CALL hlluserprog ,safepush


 movlw NOT_T1SYNC


   
 FAR_CALL hlluserprog ,safepush


 movlw T1OSCEN


   
 FAR_CALL hlluserprog ,safepush

   banksel T1CON
   movfw T1CON
   
   

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL clearbit


 
 HALF_FAR_CALL clearbit


 
 HALF_FAR_CALL setbit


 
 HALF_FAR_CALL setbit


 
 HALF_FAR_CALL clearbit


 
 FAR_CALL hlluserprog,clearbit

 POP
 banksel T1CON
 movwf T1CON
 


 movlw TMR1IE


   
 FAR_CALL hlluserprog ,safepush

   banksel PIE1
   movfw PIE1
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL hlluserprog,setbit

 POP
 banksel PIE1
 movwf PIE1
 


 movlw PEIE


   
 FAR_CALL hlluserprog ,safepush

   banksel INTCON
   movfw INTCON
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL hlluserprog,setbit

 POP
 banksel INTCON
 movwf INTCON
 


 movlw TMR1ON


   
 FAR_CALL hlluserprog ,safepush

   banksel T1CON
   movfw T1CON
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL hlluserprog,setbit

 POP
 banksel T1CON
 movwf T1CON
 


 movlw GIE


   
 FAR_CALL hlluserprog ,safepush

   banksel INTCON
   movfw INTCON
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL hlluserprog,setbit

 POP
 banksel INTCON
 movwf INTCON
 

    
hllprogend:
 goto hllprogend
 
hllprgen2:
 goto hllprgen2
 





 

 
hlog1h CODE
andu: 
 POP
 andwf HLINDF,w
 decf HLFSR,f 
 PUSH
 return
 







 


hlog1a CODE



#define margp2 hllblss00


clearbit:  
#ifdef HLLMULTITASK
#ifdef HLLGUARDhllblss 
 movf in_isr,f  
 btfsc STATUS,Z
 


 goto clearbit0

 POP
 banksel margp2
 movwf margp2
 POP 
 xorlw .0
 btfss STATUS,Z
 goto tff00h
 
 movfw margp2
 andlw .255-.1
 goto tff99h
tff00h: 
 
 xorlw .1
 btfss STATUS,Z
 goto tff01h
 
 movfw margp2
 andlw .255-.2
 goto tff99h
tff01h: 
 xorlw .1
 xorlw .2
 btfss STATUS,Z
 goto tff02h
 
 movfw margp2
 andlw .255-.4
 goto tff99h
tff02h: 
 xorlw .2
 xorlw .3
 btfss STATUS,Z
 goto tff03h
 
 movfw margp2
 andlw .255-.8
 goto tff99h
tff03h: 
 xorlw .3
 xorlw .4
 btfss STATUS,Z
 goto tff04h
 
 movfw margp2
 andlw .255-.16
 goto tff99h
tff04h: 
 xorlw .4
 xorlw .5
 btfss STATUS,Z
 goto tff05h
 
 movfw margp2
 andlw .255-.32
 goto tff99h
tff05h: 
 xorlw .5
 xorlw .6
 btfss STATUS,Z
 goto tff07h
 
 movfw margp2
 andlw .255-.64
 goto tff99h
tff07h: 
 
 movfw margp2
 andlw .255-.128
tff99h:  
 PUSH
 return




#undefine margp2


#define margp2 hllblss00+1


clearbit0:
#endif
#endif

 POP
 banksel margp2
 movwf margp2
 POP 
 xorlw .0
 btfss STATUS,Z
 goto hllAAAAA
 
 movfw margp2
 andlw .255-.1
 goto hllHAAAA
hllAAAAA: 
 
 xorlw .1
 btfss STATUS,Z
 goto hllBAAAA
 
 movfw margp2
 andlw .255-.2
 goto hllHAAAA
hllBAAAA: 
 xorlw .1
 xorlw .2
 btfss STATUS,Z
 goto hllCAAAA
 
 movfw margp2
 andlw .255-.4
 goto hllHAAAA
hllCAAAA: 
 xorlw .2
 xorlw .3
 btfss STATUS,Z
 goto hllDAAAA
 
 movfw margp2
 andlw .255-.8
 goto hllHAAAA
hllDAAAA: 
 xorlw .3
 xorlw .4
 btfss STATUS,Z
 goto hllEAAAA
 
 movfw margp2
 andlw .255-.16
 goto hllHAAAA
hllEAAAA: 
 xorlw .4
 xorlw .5
 btfss STATUS,Z
 goto hllFAAAA
 
 movfw margp2
 andlw .255-.32
 goto hllHAAAA
hllFAAAA: 
 xorlw .5
 xorlw .6
 btfss STATUS,Z
 goto hllGAAAA
 
 movfw margp2
 andlw .255-.64
 goto hllHAAAA
hllGAAAA: 
 
 movfw margp2
 andlw .255-.128
hllHAAAA:  
 PUSH
 return




#undefine margp2







 



ukrnl2 UDATA
stack res HLOE_STACK_SIZE
 
ukrnl3 UDATA 
alt_stack res HLOE_STACK2_SIZE
 


ukernl udata 





hllblss00 res 1 	  
#ifdef HLLMULTITASK
#ifdef HLLGUARDhllblss
hllblss00isr res 1      
#endif
#endif

hllblss01 res 1    
#ifdef HLLMULTITASK
#ifdef HLLGUARDhllblss
hllblss01isr res 1      
#endif
#endif

hllblss02 res 1    
#ifdef HLLMULTITASK
#ifdef HLLGUARDhllblss
hllblss02isr res 1      
#endif
#endif
  
ukrshr udata_shr


softstack0 res 1		
#ifdef HLLMULTITASK
softstack0isr res 1
#endif

softstack1 res 1		
#ifdef HLLMULTITASK
softstack1isr res 1
#endif

softstack2 res 1		
#ifdef HLLMULTITASK
softstack2isr res 1
#endif

alt_fsr res 1
W_Save res 1 
STATUS_Save res 1
FSR_Save res 1
ALT_Save res 1
in_isr res 1

hllkrna00 CODE

 


#define mterm hllblss00


mul:  
#ifdef HLLMULTITASK
#ifdef HLLGUARDhllblss 
 movf in_isr,f  
 btfsc STATUS,Z
 


 goto mul0

 POP
 banksel mterm 
 movwf mterm
 clrw 
 addwf HLINDF,w 
 decf mterm,f 
 btfss STATUS,Z 
 goto $-3
 movwf HLINDF
 return



#undefine mterm


#define mterm hllblss00+1


mul0:
#endif
#endif

 POP
 banksel mterm 
 movwf mterm
 clrw 
 addwf HLINDF,w 
 decf mterm,f 
 btfss STATUS,Z 
 goto $-3
 movwf HLINDF
 return



#undefine mterm
hllkrna01 CODE

add: 
 POP
 addwf HLINDF,w
 decf HLFSR,f 
 PUSH
 return
 
hllkrna02 CODE 

negti:  
 comf HLINDF,f
 incf HLINDF,f
 return
 
hllkrna03 CODE 
 
printch:
 POP
#ifdef HLLMULTITASK 
 
 banksel PIR1
 btfss PIR1,TXIF  
 goto $-1 
#endif 
 
 banksel TXREG
 movwf TXREG  
 
 banksel PIR1
 btfss PIR1,TXIF  
 goto $-1  
 return  




hllkrna04 CODE
 


#define mterm hllblss00


#define mdiv hllblss01


#define mquot hllblss02


modu:  
#ifdef HLLMULTITASK
#ifdef HLLGUARDhllblss 
 movf in_isr,f  
 btfsc STATUS,Z
 


 goto modu0

 banksel mquot 
 clrf mquot
 POP
 movwf mdiv
 POP
 movwf mterm
 movfw mdiv
 subwf mterm,f
 btfss STATUS,C 
 goto $+3
 incf mquot,f 
 goto $-4
 addwf mterm,w
 PUSH
 return 



#undefine mterm


#undefine mdiv


#undefine mquot


#define mterm hllblss00+1


#define mdiv hllblss01+1


#define mquot hllblss02+1


modu0:
#endif
#endif

 banksel mquot 
 clrf mquot
 POP
 movwf mdiv
 POP
 movwf mterm
 movfw mdiv
 subwf mterm,f
 btfss STATUS,C 
 goto $+3
 incf mquot,f 
 goto $-4
 addwf mterm,w
 PUSH
 return 



#undefine mterm


#undefine mdiv


#undefine mquot
hllkrna05 CODE



#define mterm hllblss00


#define mdiv hllblss01


#define mquot hllblss02


divu:  
#ifdef HLLMULTITASK
#ifdef HLLGUARDhllblss 
 movf in_isr,f  
 btfsc STATUS,Z
 


 goto divu0

 banksel mquot 
 clrf mquot
 POP
 movwf mdiv
 POP
 movwf mterm
 movfw mdiv
 subwf mterm,f
 btfss STATUS,C 
 goto $+3
 incf mquot,f 
 goto $-4
 movfw mquot
 PUSH
 return 



#undefine mterm


#undefine mdiv


#undefine mquot


#define mterm hllblss00+1


#define mdiv hllblss01+1


#define mquot hllblss02+1


divu0:
#endif
#endif

 banksel mquot 
 clrf mquot
 POP
 movwf mdiv
 POP
 movwf mterm
 movfw mdiv
 subwf mterm,f
 btfss STATUS,C 
 goto $+3
 incf mquot,f 
 goto $-4
 movfw mquot
 PUSH
 return 



#undefine mterm


#undefine mdiv


#undefine mquot
hllkrna06 CODE

 
 
 
getch:
 banksel RCSTA
 btfss RCSTA,OERR
 goto geth2
 bcf RCSTA,CREN
 bsf RCSTA,CREN
geth2:
 btfss RCSTA,FERR
 goto geth4
 bcf RCSTA,SPEN
 bsf RCSTA,SPEN
geth4:
 banksel PIR1
geth3: 
 btfss PIR1,RCIF
 goto geth3
 banksel RCREG
 movf RCREG,w
 PUSH 
 return
 
hllkrna07 CODE 
 
eq: 
 POP 
 xorwf HLINDF,w
 movlw .1 
 btfss STATUS,Z
 movlw .0 
 decf HLFSR,f 
 PUSH 
 return
 
 
 

#define sstack0 softstack0 
#define sstack1 softstack1 
#define sstack2 softstack2 

hllparmcore macro 
 movwf sstack2
 movfw HLFSR 
           
		   
 movwf sstack0
 movfw HLINDF
 
 subwf sstack2,w
 movwf HLFSR 
 movfw HLINDF 
 
 movwf sstack1
 
 movfw sstack0
 movwf HLFSR 
 clrf sstack0
 movfw sstack1 
 movwf HLINDF
 
 movfw sstack2
 pagesel kpush
 goto kpush 
 endm

 
hllkrna08 CODE  
parm:
 KPOP 
 
#ifdef HLLMULTITASK 
 movf in_isr,f 
 btfss STATUS,Z
 goto parm4
 hllparmcore
#undefine sstack0 
#undefine sstack1
#undefine sstack2 
#define sstack0 softstack0+1
#define sstack1 softstack1+1
#define sstack2 softstack2+1
parm4:
#endif 
 hllparmcore
#undefine sstack0 
#undefine sstack1
#undefine sstack2 
 
hllkrna09 CODE  
kpop: 
 KPOP
 return 
 
hllkrna10 CODE   
kpush: 
 KPUSH
 return

hllkrna11 CODE   
dispose:
 DISCARD
 return 
 
 






 
 

 
hlog1d CODE

oru: 
 POP
 iorwf HLINDF,w
 decf HLFSR,f 
 PUSH
 return

 








hllkrn444 CODE    
safepush: 
 PUSH
 
 
 
 movf HLFSR,w
 sublw stack  
 btfsc STATUS,Z
 goto kspox5 
 btfsc STATUS,C 
 goto sperr11 
kspox5:
  

 movf HLFSR,w
 addlw .1
 sublw (stack+HLOE_STACK_SIZE)  
 btfss STATUS,C
 goto sperr11
 movf HLINDF,w
 return
sperr11:
 BCF INTCON,GIE 
 DISCARD 
dmm445:
 movlw '!' 
 PUSH
 
 FAR_CALL safepush,printch
 goto dmm445
 
 





 
 

 
hlog1b CODE


#define margp2 hllblss00


setbit:  
#ifdef HLLMULTITASK
#ifdef HLLGUARDhllblss 
 movf in_isr,f  
 btfsc STATUS,Z
 


 goto setbit0

 POP
 banksel margp2
 movwf  margp2
 POP
 xorlw .0
 btfss STATUS,Z
 goto tcf00h
 
 movfw  margp2
 iorlw .1
 goto tcf99h
tcf00h: 
 
 xorlw .1
 btfss STATUS,Z
 goto tcf01h
 
 movfw  margp2
 iorlw .2
 goto tcf99h
tcf01h: 
 xorlw .1
 xorlw .2
 btfss STATUS,Z
 goto tcf02h
 
 movfw margp2
 iorlw .4
 goto tcf99h
tcf02h: 
 xorlw .2
 xorlw .3
 btfss STATUS,Z
 goto tcf03h
 
 movfw margp2
 iorlw .8
 goto tcf99h
tcf03h: 
 xorlw .3
 xorlw .4
 btfss STATUS,Z
 goto tcf04h
 
 movfw margp2
 iorlw .16
 goto tcf99h
tcf04h: 
 xorlw .4
 xorlw .5
 btfss STATUS,Z
 goto tcf05h
 
 movfw margp2
 iorlw .32
 goto tcf99h
tcf05h: 
 xorlw .5
 xorlw .6
 btfss STATUS,Z
 goto tcf07h
 
 movfw margp2
 iorlw .64
 goto tcf99h
tcf07h: 
 
 movfw margp2
 iorlw .128 
tcf99h:  
 PUSH 
 return




#undefine margp2


#define margp2 hllblss00+1


setbit0:
#endif
#endif

 POP
 banksel margp2
 movwf  margp2
 POP
 xorlw .0
 btfss STATUS,Z
 goto hllIAAAA
 
 movfw  margp2
 iorlw .1
 goto hllPAAAA
hllIAAAA: 
 
 xorlw .1
 btfss STATUS,Z
 goto hllJAAAA
 
 movfw  margp2
 iorlw .2
 goto hllPAAAA
hllJAAAA: 
 xorlw .1
 xorlw .2
 btfss STATUS,Z
 goto hllKAAAA
 
 movfw margp2
 iorlw .4
 goto hllPAAAA
hllKAAAA: 
 xorlw .2
 xorlw .3
 btfss STATUS,Z
 goto hllLAAAA
 
 movfw margp2
 iorlw .8
 goto hllPAAAA
hllLAAAA: 
 xorlw .3
 xorlw .4
 btfss STATUS,Z
 goto hllMAAAA
 
 movfw margp2
 iorlw .16
 goto hllPAAAA
hllMAAAA: 
 xorlw .4
 xorlw .5
 btfss STATUS,Z
 goto hllNAAAA
 
 movfw margp2
 iorlw .32
 goto hllPAAAA
hllNAAAA: 
 xorlw .5
 xorlw .6
 btfss STATUS,Z
 goto hllOAAAA
 
 movfw margp2
 iorlw .64
 goto hllPAAAA
hllOAAAA: 
 
 movfw margp2
 iorlw .128 
hllPAAAA:  
 PUSH 
 return




#undefine margp2

 end
