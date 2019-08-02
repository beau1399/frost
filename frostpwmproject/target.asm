
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
 


 
 FAR_CALL hlluserprog,pwm1on


 movlw .122
 



   
 FAR_CALL hlluserprog ,safepush


 movlw .9
 


   
 FAR_CALL hlluserprog ,safepush


 movlw .0

   
 HALF_FAR_CALL safepush


 
 FAR_CALL hlluserprog,pwmf

    
hllprogend:
 goto hllprogend
 

hllt450 CODE
pwm1on:


 movlw .255 

   
 FAR_CALL pwm1on ,safepush

 POP
 banksel PR2
 movwf PR2
 


 movlw CCP1SEL


   
 FAR_CALL pwm1on ,safepush

   banksel APFCON0
   movfw APFCON0
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL pwm1on,clearbit

 POP
 banksel APFCON0
 movwf APFCON0
 


 movlw TRISB3


   
 FAR_CALL pwm1on ,safepush

   banksel TRISB
   movfw TRISB
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL pwm1on,setbit

 POP
 banksel TRISB
 movwf TRISB
 


 movlw P1M0


   
 FAR_CALL pwm1on ,safepush


 movlw P1M1


   
 FAR_CALL pwm1on ,safepush

   banksel CCP1CON
   movfw CCP1CON
   
   

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL clearbit


 
 FAR_CALL pwm1on,clearbit

 POP
 banksel CCP1CON
 movwf CCP1CON
 


 movlw CCP1M0


   
 FAR_CALL pwm1on ,safepush


 movlw CCP1M1


   
 FAR_CALL pwm1on ,safepush

   banksel CCP1CON
   movfw CCP1CON
   
   

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL clearbit


 
 FAR_CALL pwm1on,clearbit

 POP
 banksel CCP1CON
 movwf CCP1CON
 


 movlw CCP1M2


   
 FAR_CALL pwm1on ,safepush


 movlw CCP1M3


   
 FAR_CALL pwm1on ,safepush

   banksel CCP1CON
   movfw CCP1CON
   
   

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL setbit


 
 FAR_CALL pwm1on,setbit

 POP
 banksel CCP1CON
 movwf CCP1CON
 


 movlw C1TSEL0


   
 FAR_CALL pwm1on ,safepush


 movlw C1TSEL1


   
 FAR_CALL pwm1on ,safepush

   banksel CCPTMRS
   movfw CCPTMRS
   
   

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL clearbit


 
 FAR_CALL pwm1on,clearbit

 POP
 banksel CCPTMRS
 movwf CCPTMRS
 


 movlw TMR2IF


   
 FAR_CALL pwm1on ,safepush

   banksel PIR1
   movfw PIR1
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL pwm1on,clearbit

 POP
 banksel PIR1
 movwf PIR1
 


 movlw T2CKPS0


   
 FAR_CALL pwm1on ,safepush


 movlw T2CKPS1


   
 FAR_CALL pwm1on ,safepush

   banksel T2CON
   movfw T2CON
   
   

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL clearbit


 
 FAR_CALL pwm1on,clearbit

 POP
 banksel T2CON
 movwf T2CON
 


 movlw TMR2ON


   
 FAR_CALL pwm1on ,safepush

   banksel T2CON
   movfw T2CON
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL pwm1on,setbit

 POP
 banksel T2CON
 movwf T2CON
 


 movlw TRISB3


   
 FAR_CALL pwm1on ,safepush

   banksel TRISB
   movfw TRISB
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL pwm1on,clearbit

 POP
 banksel TRISB
 movwf TRISB
 


 return
 

hllt4511 CODE
pwmf:

 movf FSR0L,w
 

 
 FAR_CALL pwmf ,kpush


 movlw .2

   
 HALF_FAR_CALL safepush


 
 FAR_CALL pwmf,parm


 movlw .1

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL parm


 
 FAR_CALL pwmf,iszerof

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J3 
 

 movlw .0

   
 FAR_CALL pwmf ,safepush

 
 goto hlllb51J4
 

hlllb51J3:


 movlw .2

   
 HALF_FAR_CALL safepush


 
 FAR_CALL pwmf,parm


 movlw .1

   
 HALF_FAR_CALL safepush


 
 FAR_CALL pwmf,parm


 movlw .122
 



   
 FAR_CALL pwmf ,safepush


 movlw .9
 


   
 HALF_FAR_CALL safepush


 
 FAR_CALL pwmf,gtf

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J1 
 

 movlw .255

   
 FAR_CALL pwmf ,safepush

 
 goto hlllb51J2
 

hlllb51J1:


 movlw .2

   
 HALF_FAR_CALL safepush


 
 FAR_CALL pwmf,parm


 movlw .1

   
 HALF_FAR_CALL safepush


 
 FAR_CALL pwmf,parm


 movlw .0
 



   
 FAR_CALL pwmf ,safepush


 movlw .2
 


   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL divf


 
 FAR_CALL pwmf,ftou


hlllb51J2:


hlllb51J4:

 POP
 banksel CCPR1L
 movwf CCPR1L
 


 movlw .2

   
 HALF_FAR_CALL safepush


 
 FAR_CALL pwmf,parm


 movlw .1

   
 HALF_FAR_CALL safepush


 
 FAR_CALL pwmf,parm


 movlw .128
 



   
 FAR_CALL pwmf ,safepush


 movlw .0
 


   
 FAR_CALL pwmf ,safepush


 movlw .0
 



   
 FAR_CALL pwmf ,safepush


 movlw .2
 


   
 FAR_CALL pwmf ,safepush

   banksel CCPR1L
   movfw CCPR1L
   
   

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL utof


 
 HALF_FAR_CALL mulf


 
 HALF_FAR_CALL mulf


 
 HALF_FAR_CALL addf


 
 FAR_CALL pwmf,copyf


 movlw .32
 



   
 FAR_CALL pwmf ,safepush


 movlw .1
 


   
 HALF_FAR_CALL safepush


 
 FAR_CALL pwmf,gtf

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J9 
 

 movlw DC1B1


   
 FAR_CALL pwmf ,safepush


 movlw DC1B0


   
 FAR_CALL pwmf ,safepush

   banksel CCP1CON
   movfw CCP1CON
   
   

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL setbit


 
 FAR_CALL pwmf,setbit

 POP
 banksel CCP1CON
 movwf CCP1CON
 

 
 goto hlllb51J10
 

hlllb51J9:


 
 FAR_CALL pwmf,copyf


 movlw .64
 



   
 FAR_CALL pwmf ,safepush


 movlw .0
 


   
 HALF_FAR_CALL safepush


 
 FAR_CALL pwmf,gtf

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J7 
 

 movlw DC1B1


   
 FAR_CALL pwmf ,safepush

   banksel CCP1CON
   movfw CCP1CON
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL pwmf,setbit

 POP
 banksel CCP1CON
 movwf CCP1CON
 

 
 goto hlllb51J8
 

hlllb51J7:


 
 FAR_CALL pwmf,copyf


 movlw .0
 



   
 FAR_CALL pwmf ,safepush


 movlw .255
 


   
 HALF_FAR_CALL safepush


 
 FAR_CALL pwmf,gtf

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J5 
 

 movlw DC1B0


   
 FAR_CALL pwmf ,safepush

   banksel CCP1CON
   movfw CCP1CON
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL pwmf,setbit

 POP
 banksel CCP1CON
 movwf CCP1CON
 

 
 goto hlllb51J6
 

hlllb51J5:


hlllb51J6:


hlllb51J8:


hlllb51J10:


 
 FAR_CALL pwmf,kpop
; LOAD POINTER

 movwf FSR0L
 

 DISCARD


 DISCARD


 DISCARD


 return
 
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





 
  
hlog1cz CODE


#define margp4 hllblss00


#define margp3 hllblss01


#define margp2 hllblss02


getbit:  
#ifdef HLLMULTITASK
#ifdef HLLGUARDhllblss 
 movf in_isr,f  
 btfsc STATUS,Z
 


 goto getbit0

 POP
 banksel margp4
 movwf  margp4
 movlw .1
 banksel margp2
 movwf  margp2
 POP
 banksel margp3
 movwf margp3
rhik3sz:
 btfsc STATUS,Z
 goto shik3sz
 bcf STATUS,C
 banksel margp2
 rlf margp2,f
 banksel margp3
 decf margp3,f
 bra rhik3sz
shik3sz:
 banksel margp4
 movfw  margp4
 banksel margp2
 andwf margp2
 btfss STATUS,Z
 goto shi98e4
 movlw .0
 PUSH
 return
shi98e4:
 movlw .1
 PUSH
 return



#undefine margp4


#undefine margp3


#undefine margp2


#define margp4 hllblss00+1


#define margp3 hllblss01+1


#define margp2 hllblss02+1


getbit0:
#endif
#endif

 POP
 banksel margp4
 movwf  margp4
 movlw .1
 banksel margp2
 movwf  margp2
 POP
 banksel margp3
 movwf margp3
hllIAAAA:
 btfsc STATUS,Z
 goto hllJAAAA
 bcf STATUS,C
 banksel margp2
 rlf margp2,f
 banksel margp3
 decf margp3,f
 bra hllIAAAA
hllJAAAA:
 banksel margp4
 movfw  margp4
 banksel margp2
 andwf margp2
 btfss STATUS,Z
 goto hllKAAAA
 movlw .0
 PUSH
 return
hllKAAAA:
 movlw .1
 PUSH
 return



#undefine margp4


#undefine margp3


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
 goto hllLAAAA
 
 movfw  margp2
 iorlw .1
 goto hllSAAAA
hllLAAAA: 
 
 xorlw .1
 btfss STATUS,Z
 goto hllMAAAA
 
 movfw  margp2
 iorlw .2
 goto hllSAAAA
hllMAAAA: 
 xorlw .1
 xorlw .2
 btfss STATUS,Z
 goto hllNAAAA
 
 movfw margp2
 iorlw .4
 goto hllSAAAA
hllNAAAA: 
 xorlw .2
 xorlw .3
 btfss STATUS,Z
 goto hllOAAAA
 
 movfw margp2
 iorlw .8
 goto hllSAAAA
hllOAAAA: 
 xorlw .3
 xorlw .4
 btfss STATUS,Z
 goto hllPAAAA
 
 movfw margp2
 iorlw .16
 goto hllSAAAA
hllPAAAA: 
 xorlw .4
 xorlw .5
 btfss STATUS,Z
 goto hllQAAAA
 
 movfw margp2
 iorlw .32
 goto hllSAAAA
hllQAAAA: 
 xorlw .5
 xorlw .6
 btfss STATUS,Z
 goto hllRAAAA
 
 movfw margp2
 iorlw .64
 goto hllSAAAA
hllRAAAA: 
 
 movfw margp2
 iorlw .128 
hllSAAAA:  
 PUSH 
 return




#undefine margp2




sfpu UDATA
 
 
 
 
sfploc00 res .1
sfpaux00 res .1

#ifdef HLLMULTITASK   
#ifdef HLLGUARDsfploc
sfploc00isr res .1
sfpaux00isr res .1
#endif
#endif

sfploc01 res .1
sfpaux01 res .1

#ifdef HLLMULTITASK
#ifdef HLLGUARDsfploc
sfploc01isr res .1
sfpaux01isr res .1
#endif
#endif


sfploc02 res .1
sfpaux02 res .1

#ifdef HLLMULTITASK
#ifdef HLLGUARDsfploc
sfploc02isr res .1
sfpaux02isr res .1
#endif
#endif


sfploc03 res .1
sfpaux03 res .1

#ifdef HLLMULTITASK
#ifdef HLLGUARDsfploc
sfploc03isr res .1
sfpaux03isr res .1
#endif
#endif


sfploc04 res .1

#ifdef HLLMULTITASK
#ifdef HLLGUARDsfploc
sfploc04isr res .1
#endif
#endif


sfploc05 res .1

#ifdef HLLMULTITASK
#ifdef HLLGUARDsfploc
sfploc05isr res .1
#endif
#endif


sfploc06 res .1

#ifdef HLLMULTITASK
#ifdef HLLGUARDsfploc
sfploc06isr res .1
#endif
#endif


sfploc07 res .1

#ifdef HLLMULTITASK
#ifdef HLLGUARDsfploc
sfploc07isr res .1
#endif
#endif


sfploc08 res .1

#ifdef HLLMULTITASK
#ifdef HLLGUARDsfploc
sfploc08isr res .1
#endif
#endif


sfploc09 res .1

#ifdef HLLMULTITASK
#ifdef HLLGUARDsfploc
sfploc09isr res .1
#endif
#endif


sfploc10 res .1

#ifdef HLLMULTITASK
#ifdef HLLGUARDsfploc
sfploc10isr res .1
#endif
#endif


sfploc11 res .1

#ifdef HLLMULTITASK
#ifdef HLLGUARDsfploc
sfploc11isr res .1
#endif
#endif


sfploc12 res .1

#ifdef HLLMULTITASK
#ifdef HLLGUARDsfploc
sfploc12isr res .1
#endif
#endif


sfploc13 res .1

#ifdef HLLMULTITASK
#ifdef HLLGUARDsfploc
sfploc13isr res .1
#endif
#endif


sfploc14 res .1

#ifdef HLLMULTITASK
#ifdef HLLGUARDsfploc
sfploc14isr res .1
#endif
#endif


sfploc15 res .1

#ifdef HLLMULTITASK
#ifdef HLLGUARDsfploc
sfploc15isr res .1
#endif
#endif


sfploc16 res .1

#ifdef HLLMULTITASK
#ifdef HLLGUARDsfploc
sfploc16isr res .1
#endif
#endif


sfploc17 res .1 

#ifdef HLLMULTITASK
#ifdef HLLGUARDsfploc
sfploc17isr res .1
#endif
#endif


 








 
 

sfp_add CODE




#define mout_hi sfploc00


#define big_c sfploc01


#define min2_lower sfploc02


#define minres sfploc03


#define fulmin2H sfploc04


#define fulminH sfploc05


#define min_lower sfploc06


#define rev sfploc07


#define fulmin2 sfploc08


#define fulmin sfploc09


#define multiplier sfploc10


#define mout sfploc11


#define util sfploc12


#define neg sfploc13


#define ein2 sfploc14


#define min2 sfploc15


#define ein1 sfploc16


#define min sfploc17


addf:  
#ifdef HLLMULTITASK
#ifdef HLLGUARDsfploc 
 movf in_isr,f  
 btfsc STATUS,Z
 


 goto addf0


 
 
 
 
 
 
 
 
 POP
 banksel min
 movwf ein2 
 POP
 banksel min
 movwf min2 

 POP
 banksel min
 movwf ein1 

 POP
 banksel min
 movwf min 
 
 
 
 
 bcf minres,0 
 
 
 
 clrf mout 
 
 
 
 
 
 clrf neg
 btfsc min,7
 bsf neg,0
 
 
 
 btfsc min2,7
 bsf neg,1
 



 btfsc ein2,7  
 goto yzpt44
 
 btfss ein1,7
 goto yzpt65
 
 goto ein_lt_ein2
yzpt65: 
 
 movfw ein1
 subwf ein2,w    
 btfss STATUS,C 
 goto ein_lt_ein1  
lz_ein15:
 goto ein_lt_ein2  
yzpt44:   
 
 
 btfsc ein1,7
 goto yzpt65  
ein_lt_ein1:  
 
 


 movf ein2,w
 xorwf ein1,f

 movf ein1,w
 xorwf ein2,f

 movf ein2,w
 xorwf ein1,f


 movf min2,w
 xorwf min,f

 movf min,w
 xorwf min2,f

 movf min2,w
 xorwf min,f
 
 
 
 bsf rev,0 
 
 
 
 goto ein_lt_ein2_done 
ein_lt_ein2: 
 
 
 
 clrf rev 
ein_lt_ein2_done: 
 
 
 
 
 movfw min 
 andlw .127 
 movwf min 
 
 
 
 movfw min2 
 andlw .127 
 movwf min2 
 
 
 
 clrf fulminH 
 movfw min 
 addlw .128 
 btfsc STATUS,C 
 incf fulminH,f 
 
 
 movwf fulmin 
 
 
 
 clrf fulmin2H 
 movfw min2 
 addlw .128 
 btfsc STATUS,C 
 incf fulmin2H,f 
 
 movwf fulmin2 
 
 	
	
	
	
	


 clrf min_lower

 clrf min2_lower
 
whi77:


 movfw ein1 
 xorwf ein2,w 
 btfsc STATUS,Z 
 goto eein2outw  
 


 RSHIFT min_lower
 


 RSHIFT fulmin
 

 btfss STATUS,C
 goto nocar001
 

 bsf min_lower,7
nocar001:




 incf ein1,f


 goto whi77
 

eein2outw:	

 
 
 
 
 
 btfss rev,0 
 goto if_2_done 



 movf fulmin2,w
 xorwf fulmin,f

 movf fulmin,w
 xorwf fulmin2,f

 movf fulmin2,w
 xorwf fulmin,f 
 
 
 movfw min_lower 
 movwf min2_lower 
 
 clrf min_lower
 
 
 
 
 
if_2_done: 

 banksel min_lower

 
 

nrev0:	

 btfss neg,0
 goto nextspeci0
 

 btfss neg,1
 goto nextspeci0




 bsf minres,0

 goto nextspeci2

 
 
 
 
nextspeci0:
 

 btfss neg,0
 goto nextspeci1 

 
rrrout0:

	
	
	
 movfw fulmin 
 subwf fulmin2,w 
 movwf mout 
 
 
 btfsc STATUS,C
 goto nc11rr		
		
	
 bsf minres,0	
	
	
 goto rrrout1	
	
nc11rr:

	
 movf mout,f
 btfsc STATUS,Z
 goto specidone0	
mouty:

	
 btfsc mout,7	
 goto nn91   
	
	
    
 LSHIFT mout
 
	
 btfss min_lower,7	
 goto yym43   

 
 decf mout,f	

	
 movlw .255
 xorwf mout,w
 btfss STATUS,Z
 goto yym43	
	
     
 bsf minres,0
 
	 
 goto rrrout1
	 

yym43:

   
 LSHIFT min_lower
 
	
 decf ein1,f	

	
 goto mouty

nn91:
	
 btfss min_lower,7	
 goto trup5   
		
	
 decf mout,f

	
 movlw .255
 xorwf mout,w
 btfss STATUS,Z
 goto fltu54	
		
     
 bsf minres,0	 
	 
	 
 goto rrrout1	 
	 
	 
fltu54:
	
 movlw .127
 xorwf mout,w
 btfss STATUS,Z
 goto trup5	
	
	
	
	
 LSHIFT mout
	
	
 decf ein1,f	
	
	
 btfsc min_lower,6
 goto trup5 
	
	
 incf mout,f	
	
trup5:
	
 goto specidone0
nextspeci1:
 

	
 btfss neg,1
 goto nextspeci2 
 
	
rrrout1:

	
 movfw fulmin2
 subwf fulmin,w 
 movwf mout 

 
 btfsc STATUS,C
 goto rmxd3		
	
	
	
	
 bsf minres,0
	
	
 goto rrrout0	

rmxd3:

	
 movf mout,f 
 btfsc STATUS,Z 
 goto specidone0 
	
moutx:

	
 btfsc mout,7
 goto nn91b
 
 	
	
    
 LSHIFT mout 
 
	
 btfss min2_lower,7
 goto spyr5

	
	
 decf mout,f	
	
	
 movlw .255
 xorwf mout,w
 btfss STATUS,Z
 goto spyr5	
	

 bsf minres,0
	

 goto rrrout0
	
spyr5:

 
 LSHIFT min2_lower
 

 decf ein1,f
   
	
 goto moutx	
nn91b:

	
 btfss min2_lower,7
 goto cxaa

	
 decf mout,f	
	
	
 movlw .255
 xorwf mout,w
 btfss STATUS,Z
 goto iwrtt	
		
	
 bsf minres,0
 
	
 goto rrrout0
iwrtt:


	
 movlw .127
 xorwf mout,w
 btfss STATUS,Z
 goto cxaa	
		
	
	
	
 LSHIFT mout

	
 decf ein1,f	

	
 btfsc min2_lower,6
 goto cxaa 
 
	
	
 incf mout,f	
	
cxaa:

	
 goto specidone0

tpc0lea:
	 
 movfw fulmin
 subwf fulmin2,w 
 movwf mout 
	 
	 
	 
     
 bsf minres,0	 
	
 goto specidone0

	
nextspeci2:


 

	
 clrf mout_hi
	
	
	
 movf fulmin,w
 addwf fulmin2,w
 movwf mout
	
	

	
 btfss STATUS,C	
 goto cxab			
	
	
 incf mout_hi,f	
	
cxab:



	
 movf min_lower,w
 addwf min2_lower,w
 btfsc STATUS,C
 goto bihhg   
 

	
	
 andlw .128	
 btfss STATUS,Z
 goto bihhg	  
	
	
 goto bihh0	
	
bihhg:


	
 incf mout,f	
	
	
 movf mout,f
 btfss STATUS,Z
 goto bihh0 

	
 incf mout_hi,f

bihh0:
	
 movf mout_hi,f
 btfsc STATUS,Z
 goto specidone0 

	
	
	
	
 clrf big_c
 RSHIFT fulmin
 btfsc STATUS,C
 bsf big_c,0
	
	
 RSHIFT min_lower

	
	
 btfss big_c,0
 goto ddnyy
	
	
	
 bsf min_lower,7	
	
ddnyy:

	
	
 clrf big_c
 RSHIFT fulmin2
 btfsc STATUS,C
 bsf big_c,0
	
	
	
	
 RSHIFT min2_lower
	
	
	
 btfss big_c,0
 goto ddnzz

	
	
	
 bsf min_lower,7		
	
ddnzz:

	
 incf ein1,f	
	
	
 goto nextspeci2


specidone0:

 movfw mout 
 
 
 btfss STATUS,Z 
 goto nomoutzeer 
 
 
 
 movlw .0 

 PUSH
 
 
 
 movlw 0x80 
 PUSH
 
 
 
 goto re455tu
 
 
 
nomoutzeer: 
 
 
 
 
 movfw mout
 addlw -.128 
 movwf mout 

 
 
 
 btfsc minres,0 
 bsf mout,7
 
 movfw mout 
 PUSH
 
 
 
 banksel min
 movfw ein1 

 PUSH
 
re455tu:
 
 return 

 


#undefine mout_hi


#undefine big_c


#undefine min2_lower


#undefine minres


#undefine fulmin2H


#undefine fulminH


#undefine min_lower


#undefine rev


#undefine fulmin2


#undefine fulmin


#undefine multiplier


#undefine mout


#undefine util


#undefine neg


#undefine ein2


#undefine min2


#undefine ein1


#undefine min


#define mout_hi sfploc00+1


#define big_c sfploc01+1


#define min2_lower sfploc02+1


#define minres sfploc03+1


#define fulmin2H sfploc04+1


#define fulminH sfploc05+1


#define min_lower sfploc06+1


#define rev sfploc07+1


#define fulmin2 sfploc08+1


#define fulmin sfploc09+1


#define multiplier sfploc10+1


#define mout sfploc11+1


#define util sfploc12+1


#define neg sfploc13+1


#define ein2 sfploc14+1


#define min2 sfploc15+1


#define ein1 sfploc16+1


#define min sfploc17+1


addf0:
#endif
#endif


 
 
 
 
 
 
 
 
 POP
 banksel min
 movwf ein2 
 POP
 banksel min
 movwf min2 

 POP
 banksel min
 movwf ein1 

 POP
 banksel min
 movwf min 
 
 
 
 
 bcf minres,0 
 
 
 
 clrf mout 
 
 
 
 
 
 clrf neg
 btfsc min,7
 bsf neg,0
 
 
 
 btfsc min2,7
 bsf neg,1
 



 btfsc ein2,7  
 goto hllVAAAA
 
 btfss ein1,7
 goto hllTAAAA
 
 goto hllXAAAA
hllTAAAA: 
 
 movfw ein1
 subwf ein2,w    
 btfss STATUS,C 
 goto hllWAAAA  
hllUAAAA:
 goto hllXAAAA  
hllVAAAA:   
 
 
 btfsc ein1,7
 goto hllTAAAA  
hllWAAAA:  
 
 


 movf ein2,w
 xorwf ein1,f

 movf ein1,w
 xorwf ein2,f

 movf ein2,w
 xorwf ein1,f


 movf min2,w
 xorwf min,f

 movf min,w
 xorwf min2,f

 movf min2,w
 xorwf min,f
 
 
 
 bsf rev,0 
 
 
 
 goto hllXAAAA_done 
hllXAAAA: 
 
 
 
 clrf rev 
hllXAAAA_done: 
 
 
 
 
 movfw min 
 andlw .127 
 movwf min 
 
 
 
 movfw min2 
 andlw .127 
 movwf min2 
 
 
 
 clrf fulminH 
 movfw min 
 addlw .128 
 btfsc STATUS,C 
 incf fulminH,f 
 
 
 movwf fulmin 
 
 
 
 clrf fulmin2H 
 movfw min2 
 addlw .128 
 btfsc STATUS,C 
 incf fulmin2H,f 
 
 movwf fulmin2 
 
 	
	
	
	
	


 clrf min_lower

 clrf min2_lower
 
hllZAAAA:


 movfw ein1 
 xorwf ein2,w 
 btfsc STATUS,Z 
 goto hllBBAAA  
 


 RSHIFT min_lower
 


 RSHIFT fulmin
 

 btfss STATUS,C
 goto hllABAAA
 

 bsf min_lower,7
hllABAAA:




 incf ein1,f


 goto hllZAAAA
 

hllBBAAA:	

 
 
 
 
 
 btfss rev,0 
 goto hllCBAAA 



 movf fulmin2,w
 xorwf fulmin,f

 movf fulmin,w
 xorwf fulmin2,f

 movf fulmin2,w
 xorwf fulmin,f 
 
 
 movfw min_lower 
 movwf min2_lower 
 
 clrf min_lower
 
 
 
 
 
hllCBAAA: 

 banksel min_lower

 
 

hllDBAAA:	

 btfss neg,0
 goto hllEBAAA
 

 btfss neg,1
 goto hllEBAAA




 bsf minres,0

 goto hllVBAAA

 
 
 
 
hllEBAAA:
 

 btfss neg,0
 goto hllMBAAA 

 
hllFBAAA:

	
	
	
 movfw fulmin 
 subwf fulmin2,w 
 movwf mout 
 
 
 btfsc STATUS,C
 goto hllGBAAA		
		
	
 bsf minres,0	
	
	
 goto hllNBAAA	
	
hllGBAAA:

	
 movf mout,f
 btfsc STATUS,Z
 goto hllBCAAA	
hllHBAAA:

	
 btfsc mout,7	
 goto hllJBAAA   
	
	
    
 LSHIFT mout
 
	
 btfss min_lower,7	
 goto hllIBAAA   

 
 decf mout,f	

	
 movlw .255
 xorwf mout,w
 btfss STATUS,Z
 goto hllIBAAA	
	
     
 bsf minres,0
 
	 
 goto hllNBAAA
	 

hllIBAAA:

   
 LSHIFT min_lower
 
	
 decf ein1,f	

	
 goto hllHBAAA

hllJBAAA:
	
 btfss min_lower,7	
 goto hllLBAAA   
		
	
 decf mout,f

	
 movlw .255
 xorwf mout,w
 btfss STATUS,Z
 goto hllKBAAA	
		
     
 bsf minres,0	 
	 
	 
 goto hllNBAAA	 
	 
	 
hllKBAAA:
	
 movlw .127
 xorwf mout,w
 btfss STATUS,Z
 goto hllLBAAA	
	
	
	
	
 LSHIFT mout
	
	
 decf ein1,f	
	
	
 btfsc min_lower,6
 goto hllLBAAA 
	
	
 incf mout,f	
	
hllLBAAA:
	
 goto hllBCAAA
hllMBAAA:
 

	
 btfss neg,1
 goto hllVBAAA 
 
	
hllNBAAA:

	
 movfw fulmin2
 subwf fulmin,w 
 movwf mout 

 
 btfsc STATUS,C
 goto hllOBAAA		
	
	
	
	
 bsf minres,0
	
	
 goto hllFBAAA	

hllOBAAA:

	
 movf mout,f 
 btfsc STATUS,Z 
 goto hllBCAAA 
	
hllPBAAA:

	
 btfsc mout,7
 goto hllJBAAAb
 
 	
	
    
 LSHIFT mout 
 
	
 btfss min2_lower,7
 goto hllQBAAA

	
	
 decf mout,f	
	
	
 movlw .255
 xorwf mout,w
 btfss STATUS,Z
 goto hllQBAAA	
	

 bsf minres,0
	

 goto hllFBAAA
	
hllQBAAA:

 
 LSHIFT min2_lower
 

 decf ein1,f
   
	
 goto hllPBAAA	
hllJBAAAb:

	
 btfss min2_lower,7
 goto hllTBAAA

	
 decf mout,f	
	
	
 movlw .255
 xorwf mout,w
 btfss STATUS,Z
 goto hllSBAAA	
		
	
 bsf minres,0
 
	
 goto hllFBAAA
hllSBAAA:


	
 movlw .127
 xorwf mout,w
 btfss STATUS,Z
 goto hllTBAAA	
		
	
	
	
 LSHIFT mout

	
 decf ein1,f	

	
 btfsc min2_lower,6
 goto hllTBAAA 
 
	
	
 incf mout,f	
	
hllTBAAA:

	
 goto hllBCAAA

hllUBAAA:
	 
 movfw fulmin
 subwf fulmin2,w 
 movwf mout 
	 
	 
	 
     
 bsf minres,0	 
	
 goto hllBCAAA

	
hllVBAAA:


 

	
 clrf mout_hi
	
	
	
 movf fulmin,w
 addwf fulmin2,w
 movwf mout
	
	

	
 btfss STATUS,C	
 goto hllWBAAA			
	
	
 incf mout_hi,f	
	
hllWBAAA:



	
 movf min_lower,w
 addwf min2_lower,w
 btfsc STATUS,C
 goto hllXBAAA   
 

	
	
 andlw .128	
 btfss STATUS,Z
 goto hllXBAAA	  
	
	
 goto hllYBAAA	
	
hllXBAAA:


	
 incf mout,f	
	
	
 movf mout,f
 btfss STATUS,Z
 goto hllYBAAA 

	
 incf mout_hi,f

hllYBAAA:
	
 movf mout_hi,f
 btfsc STATUS,Z
 goto hllBCAAA 

	
	
	
	
 clrf big_c
 RSHIFT fulmin
 btfsc STATUS,C
 bsf big_c,0
	
	
 RSHIFT min_lower

	
	
 btfss big_c,0
 goto hllZBAAA
	
	
	
 bsf min_lower,7	
	
hllZBAAA:

	
	
 clrf big_c
 RSHIFT fulmin2
 btfsc STATUS,C
 bsf big_c,0
	
	
	
	
 RSHIFT min2_lower
	
	
	
 btfss big_c,0
 goto hllACAAA

	
	
	
 bsf min_lower,7		
	
hllACAAA:

	
 incf ein1,f	
	
	
 goto hllVBAAA


hllBCAAA:

 movfw mout 
 
 
 btfss STATUS,Z 
 goto hllCCAAA 
 
 
 
 movlw .0 

 PUSH
 
 
 
 movlw 0x80 
 PUSH
 
 
 
 goto hllDCAAA
 
 
 
hllCCAAA: 
 
 
 
 
 movfw mout
 addlw -.128 
 movwf mout 

 
 
 
 btfsc minres,0 
 bsf mout,7
 
 movfw mout 
 PUSH
 
 
 
 banksel min
 movfw ein1 

 PUSH
 
hllDCAAA:
 
 return 

 


#undefine mout_hi


#undefine big_c


#undefine min2_lower


#undefine minres


#undefine fulmin2H


#undefine fulminH


#undefine min_lower


#undefine rev


#undefine fulmin2


#undefine fulmin


#undefine multiplier


#undefine mout


#undefine util


#undefine neg


#undefine ein2


#undefine min2


#undefine ein1


#undefine min




 

sfp_copy CODE 



#define mye sfploc00


#define mym sfploc01


copyf:  
#ifdef HLLMULTITASK
#ifdef HLLGUARDsfploc 
 movf in_isr,f  
 btfsc STATUS,Z
 


 goto copyf0

 POP
 banksel mye 
 movwf mye
 POP
 movwf mym
 PUSH
 movfw mye
 PUSH
 movfw mym
 PUSH
 movfw mye
 PUSH
 return
 


#undefine mye


#undefine mym


#define mye sfploc00+1


#define mym sfploc01+1


copyf0:
#endif
#endif

 POP
 banksel mye 
 movwf mye
 POP
 movwf mym
 PUSH
 movfw mye
 PUSH
 movfw mym
 PUSH
 movfw mye
 PUSH
 return
 


#undefine mye


#undefine mym











  
 

sfp_div CODE 


#define rounded sfploc00


#define big_c sfploc01


#define a_hi_msb sfploc02


#define loop_count sfploc03


#define run_total sfploc04


#define min2_lower sfploc05


#define subtrahend sfploc06


#define quotient_lo sfploc07


#define term sfploc08


#define exam sfploc09


#define multiplier sfploc10


#define mout sfploc11


#define util sfploc12


#define neg sfploc13


#define ein2 sfploc14


#define min2 sfploc15


#define ein sfploc16


#define min sfploc17


divf:  
#ifdef HLLMULTITASK
#ifdef HLLGUARDsfploc 
 movf in_isr,f  
 btfsc STATUS,Z
 


 goto divf0















 POP

 banksel min
 movwf ein2 
 clrf neg 


 POP

 banksel min
 movwf min2 
 btfsc min2,7
 bsf neg,1
 bcf min2,7 

 POP

 banksel min
 movwf ein 

 POP

 banksel min
 movwf min 
 btfsc min,7
 bsf neg,0 
 bcf min,7 
 movfw ein 
 movwf util 
 movfw ein2 
 subwf util,f 

 clrf exam 

 
 movfw min 
 addlw .128 
 movwf min 

 movfw min2 
 addlw .128 
 movwf min2 

 
 

 
 movwf term 




 clrf quotient_lo


 clrf subtrahend


 clrf min2_lower


 clrf run_total


 clrf loop_count

f4tp:

 movf loop_count,w
 xorlw .16
 btfsc STATUS,Z
 goto f4dn


 movf min,w
 andlw .128
 movwf a_hi_msb
 

 LSHIFT min2_lower



 LSHIFT run_total


 btfss STATUS,C
 goto que4


 incf min2_lower,f

que4:


 LSHIFT min



 LSHIFT quotient_lo


 btfsc STATUS,C



 incf min,f


 movf a_hi_msb,f
 btfsc STATUS,Z
 goto nry4


 incf run_total,f


 btfsc STATUS,Z
 incf min2_lower,f

nry4:


 clrf big_c 
 movfw min2
 subwf run_total,w 
 btfss STATUS,C 
 bsf big_c,0 


 movf subtrahend,w
 subwf min2_lower,f 


 movf min2,w
 subwf run_total,f


 btfsc big_c,0 
 decf min2_lower,f


 btfss min2_lower,7
 goto ga4g0



 movf min2,w
 addwf run_total,w
 clrf big_c
 btfsc STATUS,C
 bsf big_c,0


 movf subtrahend,w
 addwf min2_lower,f


 movf min2,w
 addwf run_total,f



 btfsc big_c,0 
 incf min2_lower,f



 movlw .254
 andwf quotient_lo,f


 goto ga5g0
ga4g0:


 movlw .1
 iorwf quotient_lo,f
ga5g0:



 incf loop_count,f


 goto f4tp

f4dn:


 movf quotient_lo,w
 movwf mout


 clrf multiplier
 btfsc min,0
 bsf multiplier,0

 
 RSHIFT term
 
 clrf rounded
 movfw run_total
 subwf term,w    
 btfsc STATUS,C 
 goto fr9rh   
 incf mout,f 
 bsf rounded,0 
 
fr9rh:
 


 movf multiplier,f
 btfsc STATUS,Z
 goto notmult0
 




 
 btfss mout,0
 goto prpg1

 
 btfsc rounded,0
 goto prpg1
 
 

 RSHIFT mout
 

 incf mout,f


 goto prpgm

prpg1:


 RSHIFT mout
 
prpgm:


 bsf mout,7

 goto notmult1
notmult0:
 decf util,f 
notmult1:
 movfw mout 

retrydvif1: 

  addlw -.128 
  movwf exam 
  btfss exam,7 
  goto nodivfcarr2 
  addlw .128    

 
 decf util,f 

 
 LSHIFT mout
 movfw mout 
 goto retrydvif1 

nodivfcarr2: 


 movwf mout



 
 
 btfsc neg,0
 goto ita33nq 
 btfss neg,1
 goto div_sames 
 goto div_dif5 
ita33nq: 
 btfsc neg,1
 goto div_sames 

div_dif5: 

 
 
 
 
 movfw mout 
 iorlw .128 
 movwf mout 
 

div_sames: 
 movfw mout 
 PUSH
 banksel min
 movfw util 
 PUSH
 
 return 

 
 


#undefine rounded


#undefine big_c


#undefine a_hi_msb


#undefine loop_count


#undefine run_total


#undefine min2_lower


#undefine subtrahend


#undefine quotient_lo


#undefine term


#undefine exam


#undefine multiplier


#undefine mout


#undefine util


#undefine neg


#undefine ein2


#undefine min2


#undefine ein


#undefine min


#define rounded sfploc00+1


#define big_c sfploc01+1


#define a_hi_msb sfploc02+1


#define loop_count sfploc03+1


#define run_total sfploc04+1


#define min2_lower sfploc05+1


#define subtrahend sfploc06+1


#define quotient_lo sfploc07+1


#define term sfploc08+1


#define exam sfploc09+1


#define multiplier sfploc10+1


#define mout sfploc11+1


#define util sfploc12+1


#define neg sfploc13+1


#define ein2 sfploc14+1


#define min2 sfploc15+1


#define ein sfploc16+1


#define min sfploc17+1


divf0:
#endif
#endif















 POP

 banksel min
 movwf ein2 
 clrf neg 


 POP

 banksel min
 movwf min2 
 btfsc min2,7
 bsf neg,1
 bcf min2,7 

 POP

 banksel min
 movwf ein 

 POP

 banksel min
 movwf min 
 btfsc min,7
 bsf neg,0 
 bcf min,7 
 movfw ein 
 movwf util 
 movfw ein2 
 subwf util,f 

 clrf exam 

 
 movfw min 
 addlw .128 
 movwf min 

 movfw min2 
 addlw .128 
 movwf min2 

 
 

 
 movwf term 




 clrf quotient_lo


 clrf subtrahend


 clrf min2_lower


 clrf run_total


 clrf loop_count

hllECAAA:

 movf loop_count,w
 xorlw .16
 btfsc STATUS,Z
 goto hllJCAAA


 movf min,w
 andlw .128
 movwf a_hi_msb
 

 LSHIFT min2_lower



 LSHIFT run_total


 btfss STATUS,C
 goto hllFCAAA


 incf min2_lower,f

hllFCAAA:


 LSHIFT min



 LSHIFT quotient_lo


 btfsc STATUS,C



 incf min,f


 movf a_hi_msb,f
 btfsc STATUS,Z
 goto hllGCAAA


 incf run_total,f


 btfsc STATUS,Z
 incf min2_lower,f

hllGCAAA:


 clrf big_c 
 movfw min2
 subwf run_total,w 
 btfss STATUS,C 
 bsf big_c,0 


 movf subtrahend,w
 subwf min2_lower,f 


 movf min2,w
 subwf run_total,f


 btfsc big_c,0 
 decf min2_lower,f


 btfss min2_lower,7
 goto hllHCAAA



 movf min2,w
 addwf run_total,w
 clrf big_c
 btfsc STATUS,C
 bsf big_c,0


 movf subtrahend,w
 addwf min2_lower,f


 movf min2,w
 addwf run_total,f



 btfsc big_c,0 
 incf min2_lower,f



 movlw .254
 andwf quotient_lo,f


 goto hllICAAA
hllHCAAA:


 movlw .1
 iorwf quotient_lo,f
hllICAAA:



 incf loop_count,f


 goto hllECAAA

hllJCAAA:


 movf quotient_lo,w
 movwf mout


 clrf multiplier
 btfsc min,0
 bsf multiplier,0

 
 RSHIFT term
 
 clrf rounded
 movfw run_total
 subwf term,w    
 btfsc STATUS,C 
 goto hllKCAAA   
 incf mout,f 
 bsf rounded,0 
 
hllKCAAA:
 


 movf multiplier,f
 btfsc STATUS,Z
 goto hllNCAAA
 




 
 btfss mout,0
 goto hllLCAAA

 
 btfsc rounded,0
 goto hllLCAAA
 
 

 RSHIFT mout
 

 incf mout,f


 goto hllMCAAA

hllLCAAA:


 RSHIFT mout
 
hllMCAAA:


 bsf mout,7

 goto hllOCAAA
hllNCAAA:
 decf util,f 
hllOCAAA:
 movfw mout 

hllPCAAA: 

  addlw -.128 
  movwf exam 
  btfss exam,7 
  goto hllQCAAA 
  addlw .128    

 
 decf util,f 

 
 LSHIFT mout
 movfw mout 
 goto hllPCAAA 

hllQCAAA: 


 movwf mout



 
 
 btfsc neg,0
 goto hllRCAAA 
 btfss neg,1
 goto hllTCAAA 
 goto hllSCAAA 
hllRCAAA: 
 btfsc neg,1
 goto hllTCAAA 

hllSCAAA: 

 
 
 
 
 movfw mout 
 iorlw .128 
 movwf mout 
 

hllTCAAA: 
 movfw mout 
 PUSH
 banksel min
 movfw util 
 PUSH
 
 return 

 
 


#undefine rounded


#undefine big_c


#undefine a_hi_msb


#undefine loop_count


#undefine run_total


#undefine min2_lower


#undefine subtrahend


#undefine quotient_lo


#undefine term


#undefine exam


#undefine multiplier


#undefine mout


#undefine util


#undefine neg


#undefine ein2


#undefine min2


#undefine ein


#undefine min




 

sfp_tou CODE 



#define util sfploc00


#define divisor sfploc01


#define karg2 sfploc02


#define karg1 sfploc03


ftou:  
#ifdef HLLMULTITASK
#ifdef HLLGUARDsfploc 
 movf in_isr,f  
 btfsc STATUS,Z
 


 goto ftou0






 POP
 banksel karg2
 movwf karg2 
 clrf karg1 
 
 
 
 
 btfss karg2,7
 goto re55zek
 POP
 goto re55zer 
re55zek:
 
 POP
 addlw .128
 banksel karg1
 movwf karg1 
 
 movfw karg2
 sublw .7
 
 movwf divisor 

 movlw high FPRollTbl3 
 movwf PCLATH 
 movlw low FPRollTbl3
 addwf divisor,w 
 btfsc STATUS,C 
 incf PCLATH,f 
 movwf PCL 


FPRollTbl3:
 goto shift0
 goto shift1
 goto shift2 
 goto shift3
 goto shift4
 goto shift5
 goto shift6
 goto shift7
 
shift7:
 RSHIFT karg1
 rrf util,f
shift6:
 RSHIFT karg1
 rrf util,f
shift5:
 RSHIFT karg1
 rrf util,f
shift4:
 RSHIFT karg1
 rrf util,f
shift3:
 RSHIFT karg1
 rrf util,f
shift2:
 RSHIFT karg1
 rrf util,f
shift1:
 RSHIFT karg1
 rrf util,f
shift0:

re55zer:
 banksel karg1
 movfw karg1 
 PUSH
 
 
 return




#undefine util


#undefine divisor


#undefine karg2


#undefine karg1


#define util sfploc00+1


#define divisor sfploc01+1


#define karg2 sfploc02+1


#define karg1 sfploc03+1


ftou0:
#endif
#endif






 POP
 banksel karg2
 movwf karg2 
 clrf karg1 
 
 
 
 
 btfss karg2,7
 goto hllUCAAA
 POP
 goto hllEDAAA 
hllUCAAA:
 
 POP
 addlw .128
 banksel karg1
 movwf karg1 
 
 movfw karg2
 sublw .7
 
 movwf divisor 

 movlw high hllVCAAA 
 movwf PCLATH 
 movlw low hllVCAAA
 addwf divisor,w 
 btfsc STATUS,C 
 incf PCLATH,f 
 movwf PCL 


hllVCAAA:
 goto hllDDAAA
 goto hllCDAAA
 goto hllBDAAA 
 goto hllADAAA
 goto hllZCAAA
 goto hllYCAAA
 goto hllXCAAA
 goto hllWCAAA
 
hllWCAAA:
 RSHIFT karg1
 rrf util,f
hllXCAAA:
 RSHIFT karg1
 rrf util,f
hllYCAAA:
 RSHIFT karg1
 rrf util,f
hllZCAAA:
 RSHIFT karg1
 rrf util,f
hllADAAA:
 RSHIFT karg1
 rrf util,f
hllBDAAA:
 RSHIFT karg1
 rrf util,f
hllCDAAA:
 RSHIFT karg1
 rrf util,f
hllDDAAA:

hllEDAAA:
 banksel karg1
 movfw karg1 
 PUSH
 
 
 return




#undefine util


#undefine divisor


#undefine karg2


#undefine karg1




 

sfp_gt CODE



#define karg4 sfploc00


#define karg3 sfploc01


#define karg2 sfploc02


#define karg1 sfploc03


#define neg2 sfploc04


#define neg sfploc05


gtf:  
#ifdef HLLMULTITASK
#ifdef HLLGUARDsfploc 
 movf in_isr,f  
 btfsc STATUS,Z
 


 goto gtf0

 
 
 
 
 

 
 
 
 
 
 POP
 banksel karg4
 movwf karg4 

 POP

 movwf karg3 
 
 POP

 movwf karg2 

 POP

 movwf karg1 
 
 
 
 clrf neg 
 clrf neg2 

 btfsc karg1,7
 bsf neg,0 
 btfsc karg3,7
 bsf neg2,0 


 
 btfss neg,0
 goto tsok7
 btfsc neg2,0
 goto tsok7
 movlw .0

 PUSH
 
 goto retok7
tsok7:






 
 btfsc neg,0
 goto tsok8
 btfss neg2,0
 goto tsok8
 movlw .1 
 PUSH
 
 goto retok7
tsok8:



 
 
 bcf karg1,7
 bcf karg3,7


 
 
 
 

 
 
 
 
 
 

 btfsc karg4,7 
 goto nxclg55
 movf karg4,f
 btfsc STATUS,Z 
 goto nxclg55 
 

 movf karg2,f
 btfsc STATUS,Z
 goto iiout4
 btfsc karg2,7
 goto iiout4
 goto iistl3
 
nxclg55: 

 btfsc karg2,7 
 goto iiout4
 movf karg2,f
 btfsc STATUS,Z 
 goto iiout4 
 goto retnn
iistl3: 
 movfw 	karg2			
 subwf karg4,w    
 btfsc STATUS,C    
 goto iiout4
 goto retnn



iiout4: 



 





 btfsc karg2,7 
 goto nzxlg55
 movf karg2,f
 btfsc STATUS,Z 
 goto nzxlg55 
 

 movf karg4,f
 btfsc STATUS,Z
 goto izxut4
 btfsc karg4,7
 goto izxut4
 goto izxtl3
 
nzxlg55: 

 btfsc karg4,7 
 goto izxut4
 movf karg4,f
 btfsc STATUS,Z 
 goto izxut4 
 goto retin
izxtl3: 
 movfw 	karg4			
 subwf karg2,w    
 btfsc STATUS,C    
 goto izxut4
 goto retin
izxut4: 








 
 
 
 
 movfw karg1
 subwf karg3,w
 btfss STATUS,C 
 goto retnn 
 
 movfw karg3
 subwf karg1,w
 btfss STATUS,C 
 goto retin

 
 movlw .0 
 PUSH
 
 goto retok7 

 
retin:
 banksel neg
 movlw .0 
 btfsc neg,0
 movlw .1 
 PUSH
 
 goto retok7 
retnn:
 banksel neg
 movlw .0 
 btfss neg,0
 movlw .1
 PUSH
 
retok7:
 
 return 
 



#undefine karg4


#undefine karg3


#undefine karg2


#undefine karg1


#undefine neg2


#undefine neg


#define karg4 sfploc00+1


#define karg3 sfploc01+1


#define karg2 sfploc02+1


#define karg1 sfploc03+1


#define neg2 sfploc04+1


#define neg sfploc05+1


gtf0:
#endif
#endif

 
 
 
 
 

 
 
 
 
 
 POP
 banksel karg4
 movwf karg4 

 POP

 movwf karg3 
 
 POP

 movwf karg2 

 POP

 movwf karg1 
 
 
 
 clrf neg 
 clrf neg2 

 btfsc karg1,7
 bsf neg,0 
 btfsc karg3,7
 bsf neg2,0 


 
 btfss neg,0
 goto hllFDAAA
 btfsc neg2,0
 goto hllFDAAA
 movlw .0

 PUSH
 
 goto hllPDAAA
hllFDAAA:






 
 btfsc neg,0
 goto hllGDAAA
 btfss neg2,0
 goto hllGDAAA
 movlw .1 
 PUSH
 
 goto hllPDAAA
hllGDAAA:



 
 
 bcf karg1,7
 bcf karg3,7


 
 
 
 

 
 
 
 
 
 

 btfsc karg4,7 
 goto hllHDAAA
 movf karg4,f
 btfsc STATUS,Z 
 goto hllHDAAA 
 

 movf karg2,f
 btfsc STATUS,Z
 goto hllJDAAA
 btfsc karg2,7
 goto hllJDAAA
 goto hllIDAAA
 
hllHDAAA: 

 btfsc karg2,7 
 goto hllJDAAA
 movf karg2,f
 btfsc STATUS,Z 
 goto hllJDAAA 
 goto hllODAAA
hllIDAAA: 
 movfw 	karg2			
 subwf karg4,w    
 btfsc STATUS,C    
 goto hllJDAAA
 goto hllODAAA



hllJDAAA: 



 





 btfsc karg2,7 
 goto hllKDAAA
 movf karg2,f
 btfsc STATUS,Z 
 goto hllKDAAA 
 

 movf karg4,f
 btfsc STATUS,Z
 goto hllMDAAA
 btfsc karg4,7
 goto hllMDAAA
 goto hllLDAAA
 
hllKDAAA: 

 btfsc karg4,7 
 goto hllMDAAA
 movf karg4,f
 btfsc STATUS,Z 
 goto hllMDAAA 
 goto hllNDAAA
hllLDAAA: 
 movfw 	karg4			
 subwf karg2,w    
 btfsc STATUS,C    
 goto hllMDAAA
 goto hllNDAAA
hllMDAAA: 








 
 
 
 
 movfw karg1
 subwf karg3,w
 btfss STATUS,C 
 goto hllODAAA 
 
 movfw karg3
 subwf karg1,w
 btfss STATUS,C 
 goto hllNDAAA

 
 movlw .0 
 PUSH
 
 goto hllPDAAA 

 
hllNDAAA:
 banksel neg
 movlw .0 
 btfsc neg,0
 movlw .1 
 PUSH
 
 goto hllPDAAA 
hllODAAA:
 banksel neg
 movlw .0 
 btfss neg,0
 movlw .1
 PUSH
 
hllPDAAA:
 
 return 
 



#undefine karg4


#undefine karg3


#undefine karg2


#undefine karg1


#undefine neg2


#undefine neg






 
 


sfp_iszero CODE

iszerof: 
 POP
 xorlw 0x80 
 btfss STATUS,Z 
 goto nonzf 
 POP
 andlw .127
 xorlw .0 
 btfss STATUS,Z 
 goto nonzg
 movlw .1 
 goto nonzr
nonzf: 
 decf HLFSR,f
nonzg:  
 movlw .0 
nonzr:  
 PUSH
 return 


 
 







 
 

sfp_mul CODE




#define savelsb sfploc00


#define iterator sfploc01


#define hi_byte sfploc02


#define make_mout sfploc03


#define factor2 sfploc04


#define factor1 sfploc05


#define mulhi sfploc06


#define mout sfploc07


#define util sfploc08


#define neg sfploc09


#define ein2 sfploc10


#define min2 sfploc11


#define ein sfploc12


#define min sfploc13


mulf:  
#ifdef HLLMULTITASK
#ifdef HLLGUARDsfploc 
 movf in_isr,f  
 btfsc STATUS,Z
 


 goto mulf0


 
 POP

 
 banksel ein2
 movwf ein2 
 xorlw .128 
 btfss STATUS,Z
 goto mulf_zokr1
 movlw .127	
 
 andwf HLINDF,w 
 
 btfsc STATUS,Z
 goto mulf_zeer1
 
mulf_zokr1: 

 
 
 clrf neg 
 
 
 
 POP

 
 banksel min2
 movwf min2 
 btfsc min2,7
 bsf neg,1      

 
 bcf min2,7 

 POP

 banksel ein
 movwf ein
 xorlw .128 
 btfss STATUS,Z
 goto mulf_zokr2
 movlw .127

 andwf HLINDF,w 
 btfsc STATUS,Z
 goto mulf_zeer2
mulf_zokr2:

 POP

 
 banksel min
 movwf min 
 btfsc min,7
 bsf neg,0

 
 bcf min,7 
 
 
 
 movfw ein 

 
 movwf util 

 
 movfw ein2 

 
 addwf util,f 
 
 
 movfw min 

 
 addlw .128 

 
 PUSH
 banksel min2
 movfw min2 
 addlw .128 

 PUSH
 goto kmul16 

bmul16:

 
 POP


 banksel mout
 movwf mout 

 
 btfss mout,7 
 goto no_mulf_carry 

 
 POP

 
 banksel util
 incf util,f 


 
 andlw .128 
 btfss STATUS,Z
 incf mout,f

 goto mulf_if1_done 


no_mulf_carry: 

 
 
 
 
 

 
 bcf STATUS,C 

 
 POP

 banksel savelsb
 movwf savelsb
 
 
 andlw .128 
 btfss STATUS,Z 
 bsf STATUS,C 

 
 
 banksel mout
 rlf mout,f 

 
 
 
 movf savelsb,w

 banksel mout
 andlw .64
 btfss STATUS,Z
 incf mout,f
 


mulf_if1_done: 

 
 movfw mout 

 
 addlw -.128 

 
 movwf mout 

 
 btfsc neg,0
 goto ita22nq 
 btfss neg,1
 goto mul_sames 
 goto mul_dif5 
ita22nq: 
 btfsc neg,1
 goto mul_sames 

mul_dif5: 

 
 movfw mout 

 
 iorlw .128 

 
 movwf mout 


mul_sames: 

 
 movfw mout 

 
 PUSH

 
 banksel util
 movfw util 
 PUSH
 
 goto reto9k 

mulf_zeer1: 

 POP
 POP


mulf_zeer2:
 POP

 
 movlw .128
 PUSH
 PUSH

 
 
reto9k:
 
 return
 
 
 
 
kmul16: 

 POP
 banksel factor1
 movwf factor1

 POP
 banksel factor2
 movwf factor2


 
 clrf hi_byte
 
 clrf make_mout
 
 clrf iterator

bptz2:

 
 btfss factor1,0
 goto nyyu11

 
 
 movfw factor2
 addwf make_mout,f

 
 btfsc STATUS,C
 incf hi_byte,f


nyyu11:
 
 
 RSHIFT factor1
 
 
 
 RSHIFT hi_byte
 
 
 
 
 
 
 rrf make_mout,f


 
 
 
 
 
 
 
 
 
 
 
 
 btfsc STATUS,C
 bsf factor1,7 


 incf iterator,f


 movlw .8
 xorwf iterator,w
 btfss STATUS,Z
 goto bptz2

 
 movfw factor1 
 PUSH

 
 banksel make_mout
 movfw make_mout
 PUSH

 goto bmul16 





#undefine savelsb


#undefine iterator


#undefine hi_byte


#undefine make_mout


#undefine factor2


#undefine factor1


#undefine mulhi


#undefine mout


#undefine util


#undefine neg


#undefine ein2


#undefine min2


#undefine ein


#undefine min


#define savelsb sfploc00+1


#define iterator sfploc01+1


#define hi_byte sfploc02+1


#define make_mout sfploc03+1


#define factor2 sfploc04+1


#define factor1 sfploc05+1


#define mulhi sfploc06+1


#define mout sfploc07+1


#define util sfploc08+1


#define neg sfploc09+1


#define ein2 sfploc10+1


#define min2 sfploc11+1


#define ein sfploc12+1


#define min sfploc13+1


mulf0:
#endif
#endif


 
 POP

 
 banksel ein2
 movwf ein2 
 xorlw .128 
 btfss STATUS,Z
 goto hllQDAAA
 movlw .127	
 
 andwf HLINDF,w 
 
 btfsc STATUS,Z
 goto hllYDAAA
 
hllQDAAA: 

 
 
 clrf neg 
 
 
 
 POP

 
 banksel min2
 movwf min2 
 btfsc min2,7
 bsf neg,1      

 
 bcf min2,7 

 POP

 banksel ein
 movwf ein
 xorlw .128 
 btfss STATUS,Z
 goto hllRDAAA
 movlw .127

 andwf HLINDF,w 
 btfsc STATUS,Z
 goto hllZDAAA
hllRDAAA:

 POP

 
 banksel min
 movwf min 
 btfsc min,7
 bsf neg,0

 
 bcf min,7 
 
 
 
 movfw ein 

 
 movwf util 

 
 movfw ein2 

 
 addwf util,f 
 
 
 movfw min 

 
 addlw .128 

 
 PUSH
 banksel min2
 movfw min2 
 addlw .128 

 PUSH
 goto hllBEAAA 

hllSDAAA:

 
 POP


 banksel mout
 movwf mout 

 
 btfss mout,7 
 goto hllTDAAA 

 
 POP

 
 banksel util
 incf util,f 


 
 andlw .128 
 btfss STATUS,Z
 incf mout,f

 goto hllUDAAA 


hllTDAAA: 

 
 
 
 
 

 
 bcf STATUS,C 

 
 POP

 banksel savelsb
 movwf savelsb
 
 
 andlw .128 
 btfss STATUS,Z 
 bsf STATUS,C 

 
 
 banksel mout
 rlf mout,f 

 
 
 
 movf savelsb,w

 banksel mout
 andlw .64
 btfss STATUS,Z
 incf mout,f
 


hllUDAAA: 

 
 movfw mout 

 
 addlw -.128 

 
 movwf mout 

 
 btfsc neg,0
 goto hllVDAAA 
 btfss neg,1
 goto hllXDAAA 
 goto hllWDAAA 
hllVDAAA: 
 btfsc neg,1
 goto hllXDAAA 

hllWDAAA: 

 
 movfw mout 

 
 iorlw .128 

 
 movwf mout 


hllXDAAA: 

 
 movfw mout 

 
 PUSH

 
 banksel util
 movfw util 
 PUSH
 
 goto hllAEAAA 

hllYDAAA: 

 POP
 POP


hllZDAAA:
 POP

 
 movlw .128
 PUSH
 PUSH

 
 
hllAEAAA:
 
 return
 
 
 
 
hllBEAAA: 

 POP
 banksel factor1
 movwf factor1

 POP
 banksel factor2
 movwf factor2


 
 clrf hi_byte
 
 clrf make_mout
 
 clrf iterator

hllCEAAA:

 
 btfss factor1,0
 goto hllDEAAA

 
 
 movfw factor2
 addwf make_mout,f

 
 btfsc STATUS,C
 incf hi_byte,f


hllDEAAA:
 
 
 RSHIFT factor1
 
 
 
 RSHIFT hi_byte
 
 
 
 
 
 
 rrf make_mout,f


 
 
 
 
 
 
 
 
 
 
 
 
 btfsc STATUS,C
 bsf factor1,7 


 incf iterator,f


 movlw .8
 xorwf iterator,w
 btfss STATUS,Z
 goto hllCEAAA

 
 movfw factor1 
 PUSH

 
 banksel make_mout
 movfw make_mout
 PUSH

 goto hllSDAAA 





#undefine savelsb


#undefine iterator


#undefine hi_byte


#undefine make_mout


#undefine factor2


#undefine factor1


#undefine mulhi


#undefine mout


#undefine util


#undefine neg


#undefine ein2


#undefine min2


#undefine ein


#undefine min





 



sfp_uto CODE 



#define arg1 sfploc00


utof:  
#ifdef HLLMULTITASK
#ifdef HLLGUARDsfploc 
 movf in_isr,f  
 btfsc STATUS,Z
 


 goto utof0

 
 POP
 banksel arg1 
 movwf arg1

 btfss arg1,7
 goto mbww0 
 
 
 

 bcf arg1,7 
 movfw arg1 
 
 PUSH


 movlw .7
 PUSH
 
 goto ret101

mbww0: 
 btfss arg1,6
 goto mbww1 


 
 

 
 
 

 banksel arg1
 bcf arg1,6 
 bcf STATUS,C 
 rlf arg1,f
 movfw arg1
 PUSH

 movlw .6
 PUSH
 
 goto ret101
mbww1: 

 btfss arg1,5
 goto mbww2

 banksel arg1
 bcf arg1,5 
 bcf STATUS,C 
 rlf arg1,f
 rlf arg1,f
 movfw arg1
 PUSH

 movlw .5
 PUSH
 
 goto ret101
mbww2: 

 btfss arg1,4
 goto mbww3


 banksel arg1
 bcf arg1,4 
 bcf STATUS,C 
 rlf arg1,f
 rlf arg1,f
 rlf arg1,f
 movfw arg1
 PUSH

 movlw .4
 PUSH
 
 goto ret101
mbww3: 

 btfss arg1,3
 goto mbww4

 banksel arg1
 bcf arg1,3 
 bcf STATUS,C 
 rlf arg1,f
 rlf arg1,f
 rlf arg1,f
 rlf arg1,f
 movfw arg1
 PUSH

 movlw .3
 PUSH
 
 goto ret101

mbww4: 

 btfss arg1,2
 goto mbww5


 banksel arg1
 bcf arg1,2 
 bcf STATUS,C 
 rlf arg1,f
 rlf arg1,f
 rlf arg1,f
 rlf arg1,f
 rlf arg1,f
 movfw arg1
 PUSH


 movlw .2
 PUSH
 
 goto ret101

mbww5: 

 btfss arg1,1
 goto mbww6

 banksel arg1
 bcf arg1,1 
 bcf STATUS,C 
 rlf arg1,f
 rlf arg1,f
 rlf arg1,f
 rlf arg1,f
 rlf arg1,f
 rlf arg1,f
 movfw arg1
 PUSH

 movlw .1
 PUSH

 goto ret101
mbww6: 
 btfss arg1,0
 goto tis00
 movlw .0
 PUSH

 movlw .0
 PUSH
 
 goto ret101
tis00:
 movlw .0
 PUSH

 movlw -.128
 PUSH
 
ret101:
 
 return




#undefine arg1


#define arg1 sfploc00+1


utof0:
#endif
#endif

 
 POP
 banksel arg1 
 movwf arg1

 btfss arg1,7
 goto hllEEAAA 
 
 
 

 bcf arg1,7 
 movfw arg1 
 
 PUSH


 movlw .7
 PUSH
 
 goto hllMEAAA

hllEEAAA: 
 btfss arg1,6
 goto hllFEAAA 


 
 

 
 
 

 banksel arg1
 bcf arg1,6 
 bcf STATUS,C 
 rlf arg1,f
 movfw arg1
 PUSH

 movlw .6
 PUSH
 
 goto hllMEAAA
hllFEAAA: 

 btfss arg1,5
 goto hllGEAAA

 banksel arg1
 bcf arg1,5 
 bcf STATUS,C 
 rlf arg1,f
 rlf arg1,f
 movfw arg1
 PUSH

 movlw .5
 PUSH
 
 goto hllMEAAA
hllGEAAA: 

 btfss arg1,4
 goto hllHEAAA


 banksel arg1
 bcf arg1,4 
 bcf STATUS,C 
 rlf arg1,f
 rlf arg1,f
 rlf arg1,f
 movfw arg1
 PUSH

 movlw .4
 PUSH
 
 goto hllMEAAA
hllHEAAA: 

 btfss arg1,3
 goto hllIEAAA

 banksel arg1
 bcf arg1,3 
 bcf STATUS,C 
 rlf arg1,f
 rlf arg1,f
 rlf arg1,f
 rlf arg1,f
 movfw arg1
 PUSH

 movlw .3
 PUSH
 
 goto hllMEAAA

hllIEAAA: 

 btfss arg1,2
 goto hllJEAAA


 banksel arg1
 bcf arg1,2 
 bcf STATUS,C 
 rlf arg1,f
 rlf arg1,f
 rlf arg1,f
 rlf arg1,f
 rlf arg1,f
 movfw arg1
 PUSH


 movlw .2
 PUSH
 
 goto hllMEAAA

hllJEAAA: 

 btfss arg1,1
 goto hllKEAAA

 banksel arg1
 bcf arg1,1 
 bcf STATUS,C 
 rlf arg1,f
 rlf arg1,f
 rlf arg1,f
 rlf arg1,f
 rlf arg1,f
 rlf arg1,f
 movfw arg1
 PUSH

 movlw .1
 PUSH

 goto hllMEAAA
hllKEAAA: 
 btfss arg1,0
 goto hllLEAAA
 movlw .0
 PUSH

 movlw .0
 PUSH
 
 goto hllMEAAA
hllLEAAA:
 movlw .0
 PUSH

 movlw -.128
 PUSH
 
hllMEAAA:
 
 return




#undefine arg1

 end
