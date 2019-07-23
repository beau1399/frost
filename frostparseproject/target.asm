
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
#endif#ifdef HLLMULTITASK
ExitISR:    
 
 RESUME
 
 retfie
#endif

mainvars udata_shr	
#ifdef HLLMULTITASK
pbase res .1			; Used for functions w/ numbered pass/return, to clean up parms/push args
pbaseisr res .1
pmark res .1
pmarkisr res .1
#else
pbase res .1
pmark res .1
#endif
PC_Save res .1

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
 


 movlw CREN


   
 FAR_CALL hlluserprog ,safepush

   banksel RCSTA
   movfw RCSTA
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL hlluserprog,setbit

 POP
 banksel RCSTA
 movwf RCSTA
 


 movlw BRGH


   
 FAR_CALL hlluserprog ,safepush

   banksel TXSTA
   movfw TXSTA
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL hlluserprog,setbit

 POP
 banksel TXSTA
 movwf TXSTA
 


 movlw BRG16


   
 FAR_CALL hlluserprog ,safepush

   banksel BAUDCON
   movfw BAUDCON
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL hlluserprog,setbit

 POP
 banksel BAUDCON
 movwf BAUDCON
 


 movlw .68 

   
 FAR_CALL hlluserprog ,safepush

 POP
 banksel SPBRG
 movwf SPBRG
 


 movlw .0 

   
 FAR_CALL hlluserprog ,safepush

 POP
 banksel SPBRGH
 movwf SPBRGH
 


 movlw TX9


   
 FAR_CALL hlluserprog ,safepush


 movlw TXEN


   
 FAR_CALL hlluserprog ,safepush


 movlw SYNC


   
 FAR_CALL hlluserprog ,safepush

   banksel TXSTA
   movfw TXSTA
   
   

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL clearbit


 
 HALF_FAR_CALL setbit


 
 FAR_CALL hlluserprog,clearbit

 POP
 banksel TXSTA
 movwf TXSTA
 


 movlw SCKP


   
 FAR_CALL hlluserprog ,safepush

   banksel BAUDCON
   movfw BAUDCON
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL hlluserprog,setbit

 POP
 banksel BAUDCON
 movwf BAUDCON
 


 movlw SPEN


   
 FAR_CALL hlluserprog ,safepush

   banksel RCSTA
   movfw RCSTA
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL hlluserprog,setbit

 POP
 banksel RCSTA
 movwf RCSTA
 


 movlw .5 

   
 FAR_CALL hlluserprog ,safepush

   banksel TRISB
   movfw TRISB
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL hlluserprog,clearbit

 POP
 banksel TRISB
 movwf TRISB
 


 movlw .5 

   
 FAR_CALL hlluserprog ,safepush

   banksel ANSELB
   movfw ANSELB
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL hlluserprog,clearbit

 POP
 banksel ANSELB
 movwf ANSELB
 


 movlw .1 

   
 FAR_CALL hlluserprog ,safepush

   banksel ANSELB
   movfw ANSELB
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL hlluserprog,clearbit

 POP
 banksel ANSELB
 movwf ANSELB
 


 movlw TXCKSEL


   
 FAR_CALL hlluserprog ,safepush

   banksel APFCON1
   movfw APFCON1
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL hlluserprog,setbit

 POP
 banksel APFCON1
 movwf APFCON1
 


 movlw SCKP


   
 FAR_CALL hlluserprog ,safepush

   banksel BAUDCON
   movfw BAUDCON
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL hlluserprog,clearbit

 POP
 banksel BAUDCON
 movwf BAUDCON
 


 
 FAR_CALL hlluserprog,outer

    
hllprogend:
 goto hllprogend
 

hllt450 CODE
outer:


 
 FAR_CALL outer,getch


 movlw .0
 



   
 FAR_CALL outer ,safepush


 movlw .128
 


   
 HALF_FAR_CALL safepush


 
 FAR_CALL outer,dofunc

 ;
 goto outer

 

hllt453 CODE
dofunc:


 movf FSR0L,w
 addlw -.2 

 
 FAR_CALL dofunc ,kpush

 movf FSR0L,w
 

 
 FAR_CALL dofunc ,kpush


 movlw .2

   
 HALF_FAR_CALL safepush


 
 FAR_CALL dofunc,parm

 ; char ' '


 movlw .32


   
 HALF_FAR_CALL safepush


 
 FAR_CALL dofunc,eq

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J1 
 

 movlw .1

   
 HALF_FAR_CALL safepush


 
 FAR_CALL dofunc,parm


 movlw .0

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL parm


 
 FAR_CALL dofunc,printf


 movlw .13

   
 HALF_FAR_CALL safepush


 
 FAR_CALL dofunc,printch


 movlw .10

   
 HALF_FAR_CALL safepush


 
 FAR_CALL dofunc,printch

 
 goto hlllb51J2
 

hlllb51J1:


 
 FAR_CALL dofunc,getch


 movlw .1

   
 HALF_FAR_CALL safepush


 
 FAR_CALL dofunc,parm


 movlw .0

   
 HALF_FAR_CALL safepush


 
 FAR_CALL dofunc,parm


 movlw .32
 



   
 FAR_CALL dofunc ,safepush


 movlw .3
 


   
 HALF_FAR_CALL safepush


 
 FAR_CALL dofunc,mulf


 movlw .2

   
 HALF_FAR_CALL safepush


 
 FAR_CALL dofunc,parm


 movlw -.1

   
 FAR_CALL dofunc ,safepush

 ; char '0'


 movlw .48


   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL mul


 
 HALF_FAR_CALL add


 
 HALF_FAR_CALL utof


 
 HALF_FAR_CALL addf


 
 FAR_CALL dofunc,dofunc


hlllb51J2:


 
 FAR_CALL dofunc,kpop
; LOAD POINTER

 movwf FSR0L
 

 DISCARD


 DISCARD

 KDISCARD


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
 banksel PIR1
geth2: 
 btfss PIR1,RCIF
 goto geth2
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

hllparmcorel macro 
 movwf sstack2
 movfw HLFSR 
           
		   
 movwf sstack0
 
 movfw HLINDF    
 addwf sstack2,w 
 decf HLFSR      
 subwf HLINDF,w  
 addlw -.1       
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

#define sstack0 softstack0 
#define sstack1 softstack1 
#define sstack2 softstack2 
hllkrna12 CODE  
lparm:
 KPOP 
 
#ifdef HLLMULTITASK 
 movf in_isr,f 
 btfss STATUS,Z
 goto parm4
 hllparmcorel
#undefine sstack0 
#undefine sstack1
#undefine sstack2 
#define sstack0 softstack0+1
#define sstack1 softstack1+1
#define sstack2 softstack2+1
parm4:
#endif 
 hllparmcorel
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
 goto hllSAAAA
 
 btfss ein1,7
 goto hllQAAAA
 
 goto hllUAAAA
hllQAAAA: 
 
 movfw ein1
 subwf ein2,w    
 btfss STATUS,C 
 goto hllTAAAA  
hllRAAAA:
 goto hllUAAAA  
hllSAAAA:   
 
 
 btfsc ein1,7
 goto hllQAAAA  
hllTAAAA:  
 
 


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
 
 
 
 goto hllUAAAA_done 
hllUAAAA: 
 
 
 
 clrf rev 
hllUAAAA_done: 
 
 
 
 
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
 
hllWAAAA:


 movfw ein1 
 xorwf ein2,w 
 btfsc STATUS,Z 
 goto hllYAAAA  
 


 RSHIFT min_lower
 


 RSHIFT fulmin
 

 btfss STATUS,C
 goto hllXAAAA
 

 bsf min_lower,7
hllXAAAA:




 incf ein1,f


 goto hllWAAAA
 

hllYAAAA:	

 
 
 
 
 
 btfss rev,0 
 goto hllZAAAA 



 movf fulmin2,w
 xorwf fulmin,f

 movf fulmin,w
 xorwf fulmin2,f

 movf fulmin2,w
 xorwf fulmin,f 
 
 
 movfw min_lower 
 movwf min2_lower 
 
 clrf min_lower
 
 
 
 
 
hllZAAAA: 

 banksel min_lower

 
 

hllABAAA:	

 btfss neg,0
 goto hllBBAAA
 

 btfss neg,1
 goto hllBBAAA




 bsf minres,0

 goto hllSBAAA

 
 
 
 
hllBBAAA:
 

 btfss neg,0
 goto hllJBAAA 

 
hllCBAAA:

	
	
	
 movfw fulmin 
 subwf fulmin2,w 
 movwf mout 
 
 
 btfsc STATUS,C
 goto hllDBAAA		
		
	
 bsf minres,0	
	
	
 goto hllKBAAA	
	
hllDBAAA:

	
 movf mout,f
 btfsc STATUS,Z
 goto hllYBAAA	
hllEBAAA:

	
 btfsc mout,7	
 goto hllGBAAA   
	
	
    
 LSHIFT mout
 
	
 btfss min_lower,7	
 goto hllFBAAA   

 
 decf mout,f	

	
 movlw .255
 xorwf mout,w
 btfss STATUS,Z
 goto hllFBAAA	
	
     
 bsf minres,0
 
	 
 goto hllKBAAA
	 

hllFBAAA:

   
 LSHIFT min_lower
 
	
 decf ein1,f	

	
 goto hllEBAAA

hllGBAAA:
	
 btfss min_lower,7	
 goto hllIBAAA   
		
	
 decf mout,f

	
 movlw .255
 xorwf mout,w
 btfss STATUS,Z
 goto hllHBAAA	
		
     
 bsf minres,0	 
	 
	 
 goto hllKBAAA	 
	 
	 
hllHBAAA:
	
 movlw .127
 xorwf mout,w
 btfss STATUS,Z
 goto hllIBAAA	
	
	
	
	
 LSHIFT mout
	
	
 decf ein1,f	
	
	
 btfsc min_lower,6
 goto hllIBAAA 
	
	
 incf mout,f	
	
hllIBAAA:
	
 goto hllYBAAA
hllJBAAA:
 

	
 btfss neg,1
 goto hllSBAAA 
 
	
hllKBAAA:

	
 movfw fulmin2
 subwf fulmin,w 
 movwf mout 

 
 btfsc STATUS,C
 goto hllLBAAA		
	
	
	
	
 bsf minres,0
	
	
 goto hllCBAAA	

hllLBAAA:

	
 movf mout,f 
 btfsc STATUS,Z 
 goto hllYBAAA 
	
hllMBAAA:

	
 btfsc mout,7
 goto hllGBAAAb
 
 	
	
    
 LSHIFT mout 
 
	
 btfss min2_lower,7
 goto hllNBAAA

	
	
 decf mout,f	
	
	
 movlw .255
 xorwf mout,w
 btfss STATUS,Z
 goto hllNBAAA	
	

 bsf minres,0
	

 goto hllCBAAA
	
hllNBAAA:

 
 LSHIFT min2_lower
 

 decf ein1,f
   
	
 goto hllMBAAA	
hllGBAAAb:

	
 btfss min2_lower,7
 goto hllQBAAA

	
 decf mout,f	
	
	
 movlw .255
 xorwf mout,w
 btfss STATUS,Z
 goto hllPBAAA	
		
	
 bsf minres,0
 
	
 goto hllCBAAA
hllPBAAA:


	
 movlw .127
 xorwf mout,w
 btfss STATUS,Z
 goto hllQBAAA	
		
	
	
	
 LSHIFT mout

	
 decf ein1,f	

	
 btfsc min2_lower,6
 goto hllQBAAA 
 
	
	
 incf mout,f	
	
hllQBAAA:

	
 goto hllYBAAA

hllRBAAA:
	 
 movfw fulmin
 subwf fulmin2,w 
 movwf mout 
	 
	 
	 
     
 bsf minres,0	 
	
 goto hllYBAAA

	
hllSBAAA:


 

	
 clrf mout_hi
	
	
	
 movf fulmin,w
 addwf fulmin2,w
 movwf mout
	
	

	
 btfss STATUS,C	
 goto hllTBAAA			
	
	
 incf mout_hi,f	
	
hllTBAAA:



	
 movf min_lower,w
 addwf min2_lower,w
 btfsc STATUS,C
 goto hllUBAAA   
 

	
	
 andlw .128	
 btfss STATUS,Z
 goto hllUBAAA	  
	
	
 goto hllVBAAA	
	
hllUBAAA:


	
 incf mout,f	
	
	
 movf mout,f
 btfss STATUS,Z
 goto hllVBAAA 

	
 incf mout_hi,f

hllVBAAA:
	
 movf mout_hi,f
 btfsc STATUS,Z
 goto hllYBAAA 

	
	
	
	
 clrf big_c
 RSHIFT fulmin
 btfsc STATUS,C
 bsf big_c,0
	
	
 RSHIFT min_lower

	
	
 btfss big_c,0
 goto hllWBAAA
	
	
	
 bsf min_lower,7	
	
hllWBAAA:

	
	
 clrf big_c
 RSHIFT fulmin2
 btfsc STATUS,C
 bsf big_c,0
	
	
	
	
 RSHIFT min2_lower
	
	
	
 btfss big_c,0
 goto hllXBAAA

	
	
	
 bsf min_lower,7		
	
hllXBAAA:

	
 incf ein1,f	
	
	
 goto hllSBAAA


hllYBAAA:

 movfw mout 
 
 
 btfss STATUS,Z 
 goto hllZBAAA 
 
 
 
 movlw .0 

 PUSH
 
 
 
 movlw 0x80 
 PUSH
 
 
 
 goto hllACAAA
 
 
 
hllZBAAA: 
 
 
 
 
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
 
hllACAAA:
 
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
 goto hllBCAAA
 movlw .127	
 
 andwf HLINDF,w 
 
 btfsc STATUS,Z
 goto hllJCAAA
 
hllBCAAA: 

 
 
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
 goto hllCCAAA
 movlw .127

 andwf HLINDF,w 
 btfsc STATUS,Z
 goto hllKCAAA
hllCCAAA:

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
 goto hllMCAAA 

hllDCAAA:

 
 POP


 banksel mout
 movwf mout 

 
 btfss mout,7 
 goto hllECAAA 

 
 POP

 
 banksel util
 incf util,f 


 
 andlw .128 
 btfss STATUS,Z
 incf mout,f

 goto hllFCAAA 


hllECAAA: 

 
 
 
 
 

 
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
 


hllFCAAA: 

 
 movfw mout 

 
 addlw -.128 

 
 movwf mout 

 
 btfsc neg,0
 goto hllGCAAA 
 btfss neg,1
 goto hllICAAA 
 goto hllHCAAA 
hllGCAAA: 
 btfsc neg,1
 goto hllICAAA 

hllHCAAA: 

 
 movfw mout 

 
 iorlw .128 

 
 movwf mout 


hllICAAA: 

 
 movfw mout 

 
 PUSH

 
 banksel util
 movfw util 
 PUSH
 
 goto hllLCAAA 

hllJCAAA: 

 POP
 POP


hllKCAAA:
 POP

 
 movlw .128
 PUSH
 PUSH

 
 
hllLCAAA:
 
 return
 
 
 
 
hllMCAAA: 

 POP
 banksel factor1
 movwf factor1

 POP
 banksel factor2
 movwf factor2


 
 clrf hi_byte
 
 clrf make_mout
 
 clrf iterator

hllNCAAA:

 
 btfss factor1,0
 goto hllOCAAA

 
 
 movfw factor2
 addwf make_mout,f

 
 btfsc STATUS,C
 incf hi_byte,f


hllOCAAA:
 
 
 RSHIFT factor1
 
 
 
 RSHIFT hi_byte
 
 
 
 
 
 
 rrf make_mout,f


 
 
 
 
 
 
 
 
 
 
 
 
 btfsc STATUS,C
 bsf factor1,7 


 incf iterator,f


 movlw .8
 xorwf iterator,w
 btfss STATUS,Z
 goto hllNCAAA

 
 movfw factor1 
 PUSH

 
 banksel make_mout
 movfw make_mout
 PUSH

 goto hllDCAAA 





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
 
 FAR_CALL printf,printch 
 banksel thk000
 movfw thk000
 addlw .128 
 movwf thk000 
 movfw thk000 
 PUSH
 movlw .100 
 PUSH
 
 HALF_FAR_CALL divu 
 
 HALF_FAR_CALL ascii 
 
 FAR_CALL printf,printch 
 banksel thk000
 movfw thk000
 PUSH
 movlw .100 
 PUSH
 
 FAR_CALL printf,modu 
 movlw .10 
 PUSH
 
 HALF_FAR_CALL divu 
 
 HALF_FAR_CALL ascii 
 
 FAR_CALL printf,printch 
 
 banksel thk000 
 movfw thk000 
 PUSH
 movlw .10 
 PUSH
 
 HALF_FAR_CALL modu 
 
 HALF_FAR_CALL ascii 
 
 FAR_CALL printf,printch 
 movlw '/' 
 PUSH
 
 FAR_CALL printf,printch 
 movlw '1' 
 PUSH
 
 FAR_CALL printf,printch 
 movlw '2' 
 PUSH
 
 FAR_CALL printf,printch 
 movlw '8' 
 PUSH
 
 FAR_CALL printf,printch 
 movlw ')' 
 PUSH
 
 FAR_CALL printf,printch 
 movlw '*' 
 PUSH
 
 FAR_CALL printf,printch 
 movlw '2' 
 PUSH
 
 FAR_CALL printf,printch 
 movlw '^' 
 PUSH
 
 FAR_CALL printf,printch 
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
 
 FAR_CALL printf,printch 
 
 banksel thk001 
 movfw thk001 
 PUSH
 movlw .100 
 PUSH
 
 HALF_FAR_CALL divu 
 
 HALF_FAR_CALL ascii 
 
 FAR_CALL printf,printch 
 
 banksel thk001 
 movfw thk001 
 PUSH
 movlw .100 
 PUSH
 
 FAR_CALL printf,modu 
 movlw .10 
 PUSH
 
 HALF_FAR_CALL divu 
 
 HALF_FAR_CALL ascii 
 
 FAR_CALL printf,printch 
 
 banksel thk001 
 movfw thk001 
 PUSH
 movlw .10 
 PUSH
 
 HALF_FAR_CALL modu
 
 HALF_FAR_CALL ascii 
 
 FAR_CALL printf,printch 
 movlw ' '
 PUSH
 
 FAR_CALL printf,printch 
 
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
 goto hllPCAAA
 
 movfw thk000
 andlw .127 
 movwf thk000 
 movlw '-' 
hllPCAAA: 
 PUSH
 
 FAR_CALL printf,printch 
 banksel thk000
 movfw thk000
 addlw .128 
 movwf thk000 
 movfw thk000 
 PUSH
 movlw .100 
 PUSH
 
 HALF_FAR_CALL divu 
 
 HALF_FAR_CALL ascii 
 
 FAR_CALL printf,printch 
 banksel thk000
 movfw thk000
 PUSH
 movlw .100 
 PUSH
 
 FAR_CALL printf,modu 
 movlw .10 
 PUSH
 
 HALF_FAR_CALL divu 
 
 HALF_FAR_CALL ascii 
 
 FAR_CALL printf,printch 
 
 banksel thk000 
 movfw thk000 
 PUSH
 movlw .10 
 PUSH
 
 HALF_FAR_CALL modu 
 
 HALF_FAR_CALL ascii 
 
 FAR_CALL printf,printch 
 movlw '/' 
 PUSH
 
 FAR_CALL printf,printch 
 movlw '1' 
 PUSH
 
 FAR_CALL printf,printch 
 movlw '2' 
 PUSH
 
 FAR_CALL printf,printch 
 movlw '8' 
 PUSH
 
 FAR_CALL printf,printch 
 movlw ')' 
 PUSH
 
 FAR_CALL printf,printch 
 movlw '*' 
 PUSH
 
 FAR_CALL printf,printch 
 movlw '2' 
 PUSH
 
 FAR_CALL printf,printch 
 movlw '^' 
 PUSH
 
 FAR_CALL printf,printch 
 banksel thk001 
 
 movlw '+' 
 btfss thk001,7 
 goto hllPCAAA2 
 movfw thk001 
 xorlw .255 
 addlw .1
 movwf thk001 
 movlw '-' 
hllPCAAA2: 
 PUSH
 
 FAR_CALL printf,printch 
 
 banksel thk001 
 movfw thk001 
 PUSH
 movlw .100 
 PUSH
 
 HALF_FAR_CALL divu 
 
 HALF_FAR_CALL ascii 
 
 FAR_CALL printf,printch 
 
 banksel thk001 
 movfw thk001 
 PUSH
 movlw .100 
 PUSH
 
 FAR_CALL printf,modu 
 movlw .10 
 PUSH
 
 HALF_FAR_CALL divu 
 
 HALF_FAR_CALL ascii 
 
 FAR_CALL printf,printch 
 
 banksel thk001 
 movfw thk001 
 PUSH
 movlw .10 
 PUSH
 
 HALF_FAR_CALL modu
 
 HALF_FAR_CALL ascii 
 
 FAR_CALL printf,printch 
 movlw ' '
 PUSH
 
 FAR_CALL printf,printch 
 
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
 goto hllRCAAA 
 
 
 

 bcf arg1,7 
 movfw arg1 
 
 PUSH


 movlw .7
 PUSH
 
 goto hllZCAAA

hllRCAAA: 
 btfss arg1,6
 goto hllSCAAA 


 
 

 
 
 

 banksel arg1
 bcf arg1,6 
 bcf STATUS,C 
 rlf arg1,f
 movfw arg1
 PUSH

 movlw .6
 PUSH
 
 goto hllZCAAA
hllSCAAA: 

 btfss arg1,5
 goto hllTCAAA

 banksel arg1
 bcf arg1,5 
 bcf STATUS,C 
 rlf arg1,f
 rlf arg1,f
 movfw arg1
 PUSH

 movlw .5
 PUSH
 
 goto hllZCAAA
hllTCAAA: 

 btfss arg1,4
 goto hllUCAAA


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
 
 goto hllZCAAA
hllUCAAA: 

 btfss arg1,3
 goto hllVCAAA

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
 
 goto hllZCAAA

hllVCAAA: 

 btfss arg1,2
 goto hllWCAAA


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
 
 goto hllZCAAA

hllWCAAA: 

 btfss arg1,1
 goto hllXCAAA

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

 goto hllZCAAA
hllXCAAA: 
 btfss arg1,0
 goto hllYCAAA
 movlw .0
 PUSH

 movlw .0
 PUSH
 
 goto hllZCAAA
hllYCAAA:
 movlw .0
 PUSH

 movlw -.128
 PUSH
 
hllZCAAA:
 
 return




#undefine arg1

 end
