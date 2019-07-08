
#include "hloe.inc"

 __config (_INTRC_OSC_NOCLKOUT & _WDT_OFF & _PWRTE_ON & _MCLRE_OFF & _CP_OFF & _BOR_ON & _IESO_OFF & _FCMEN_OFF)




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

PC_Save res .1

main code
hloego:

 
  clrf in_isr
 
  movlw stack-1		;Set up stack starting position based on literals det. by incremental linker
  movwf FSR 
  movlw alt_stack-1
  movwf alt_fsr 
  
  
  clrf softstack0
 
 bankisel stack
 pagesel hlluserprog
 goto hlluserprog
hllupuser CODE
hlluserprog: 
 

 movlw .112 

   
 FAR_CALL hlluserprog ,safepush

   banksel OSCCON
   movfw OSCCON
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL hlluserprog,oru

 POP
 banksel OSCCON
 movwf OSCCON
 


 movlw .17 

   
 FAR_CALL hlluserprog ,safepush

 POP
 banksel SPBRG
 movwf SPBRG
 


 movlw .0 

   
 FAR_CALL hlluserprog ,safepush

 POP
 banksel SPBRGH
 movwf SPBRGH
 


 movlw SYNC


   
 FAR_CALL hlluserprog ,safepush

   banksel TXSTA
   movfw TXSTA
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL hlluserprog,clearbit

 POP
 banksel TXSTA
 movwf TXSTA
 


 movlw CREN


   
 FAR_CALL hlluserprog ,safepush

   banksel RCSTA
   movfw RCSTA
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL hlluserprog,clearbit

 POP
 banksel RCSTA
 movwf RCSTA
 


 movlw CREN


   
 FAR_CALL hlluserprog ,safepush

   banksel RCSTA
   movfw RCSTA
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL hlluserprog,setbit

 POP
 banksel RCSTA
 movwf RCSTA
 


 movlw SPEN


   
 FAR_CALL hlluserprog ,safepush

   banksel RCSTA
   movfw RCSTA
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL hlluserprog,setbit

 POP
 banksel RCSTA
 movwf RCSTA
 


 movlw TXEN


   
 FAR_CALL hlluserprog ,safepush


 movlw TX9


   
 FAR_CALL hlluserprog ,safepush


 movlw BRGH


   
 FAR_CALL hlluserprog ,safepush

   banksel TXSTA
   movfw TXSTA
   
   

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL setbit


 
 HALF_FAR_CALL clearbit


 
 FAR_CALL hlluserprog,setbit

 POP
 banksel TXSTA
 movwf TXSTA
 


 movlw BRG16


   
 FAR_CALL hlluserprog ,safepush


 movlw SCKP


   
 FAR_CALL hlluserprog ,safepush

   banksel BAUDCTL
   movfw BAUDCTL
   
   

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL setbit


 
 FAR_CALL hlluserprog,setbit

 POP
 banksel BAUDCTL
 movwf BAUDCTL
 


 movlw .0 

   
 FAR_CALL hlluserprog ,safepush

 POP
 banksel ANSELH
 movwf ANSELH
 


 movlw .0 

   
 FAR_CALL hlluserprog ,safepush

 POP
 banksel ANSEL
 movwf ANSEL
 


 movlw RCIE


   
 FAR_CALL hlluserprog ,safepush


 movlw TXIE


   
 FAR_CALL hlluserprog ,safepush

   banksel PIE1
   movfw PIE1
   
   

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL clearbit


 
 FAR_CALL hlluserprog,clearbit

 POP
 banksel PIE1
 movwf PIE1
 


 movlw .13

   
 HALF_FAR_CALL safepush


 
 FAR_CALL hlluserprog,printch


 movlw .2

   
 HALF_FAR_CALL safepush


 
 FAR_CALL hlluserprog,maing

    
hllprogend:
 goto hllprogend
 

hllt454 CODE
maing:
 movf FSR,w
 

 
 FAR_CALL maing ,kpush


 movlw .0

   
 HALF_FAR_CALL safepush


 
 FAR_CALL maing,parm


 movlw .255

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL geu


 
 FAR_CALL maing,notb

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J2 
 

 movlw .0

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL parm


 
 FAR_CALL maing,isprime

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J0 
 

 movlw .0

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL parm


 
 FAR_CALL maing,printu


 movlw .13

   
 HALF_FAR_CALL safepush


 
 FAR_CALL maing,printch


 movlw .10

   
 HALF_FAR_CALL safepush


 
 FAR_CALL maing,printch

 
 goto hlllb51J1
 

hlllb51J0:


hlllb51J1:


 movlw .1

   
 HALF_FAR_CALL safepush


 
 FAR_CALL maing,add

 ;


 KDISCARD 
 goto maing
hlllb51J2:
hlllb51J3:

 KDISCARD 
 return 

 

hllt455 CODE
isprime:
 movf FSR,w
 

 
 FAR_CALL isprime ,kpush


 movlw .0

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL parm


 
 FAR_CALL isprime,sqrt


 movlw .0

   
 HALF_FAR_CALL safepush


 
 FAR_CALL isprime,parm


 movlw .2  
 

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL isprimeinner


 
 FAR_CALL isprime,kpop
 
#ifdef HLLMULTITASK 
 movf in_isr,f ;In shared RAM, no need for BANKSEL
 btfsc STATUS,Z
 goto $+3
 movwf pbase+1 ;in_isr... the "in isr" clause comes first in all of these macros. This
 goto $+2      ; is because isr execution is preemptive, and returns only at the 
 movwf pbase   ; completion of all triggered routines. So, it can starve out the main
#else          ; thread, and speeding up isr execution helps this problem. In most of
 movwf pbase   ; these macros, in-isr execution takes just 4 instruction cycles.
#endif 


 POP
 
 FAR_CALL isprime ,kpush
 
#ifdef HLLMULTITASK 
 movf in_isr,f ;In shared RAM, no need for BANKSEL
 btfsc STATUS,Z
 goto $+3
 movf pbase+1,w			;in_isr
 goto $+2
 movf pbase,w	;not in_isr
#else
 movf pbase,w	
#endif  

 
;LOAD POINTER
 movwf FSR
 

 DISCARD


 
 HALF_FAR_CALL kpop


 
 FAR_CALL isprime ,safepush
 

 return
 

hllt4510 CODE
isprimeinner:
 movf FSR,w
 

 
 FAR_CALL isprimeinner ,kpush


 movlw .0

   
 HALF_FAR_CALL safepush


 
 FAR_CALL isprimeinner,parm


 movlw .1 

   
 FAR_CALL isprimeinner ,safepush


 movlw .2

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL parm


 
 HALF_FAR_CALL add


 
 FAR_CALL isprimeinner,eq

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J8 
 

 movlw .1

   
 FAR_CALL isprimeinner ,safepush

 
 goto hlllb51J9
 

hlllb51J8:


 movlw .1

   
 HALF_FAR_CALL safepush


 
 FAR_CALL isprimeinner,parm


 movlw .0

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL parm


 
 FAR_CALL isprimeinner,divis

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J6 
 

 movlw .0

   
 FAR_CALL isprimeinner ,safepush

 
 goto hlllb51J7
 

hlllb51J6:


 movlw .1

   
 HALF_FAR_CALL safepush


 
 FAR_CALL isprimeinner,add

 ;


 KDISCARD 
 goto isprimeinner
hlllb51J7:
hlllb51J9:

 KDISCARD 
 return 

 

hllt4513 CODE
divis:
 movf FSR,w
 

 
 FAR_CALL divis ,kpush


 movlw .1

   
 HALF_FAR_CALL safepush


 
 FAR_CALL divis,parm


 movlw .0

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL parm


 
 FAR_CALL divis,modu

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J11 
 

 movlw .0

   
 FAR_CALL divis ,safepush

 
 goto hlllb51J12
 

hlllb51J11:


 movlw .1

   
 FAR_CALL divis ,safepush


hlllb51J12:


 
 FAR_CALL divis,kpop
 
#ifdef HLLMULTITASK 
 movf in_isr,f ;In shared RAM, no need for BANKSEL
 btfsc STATUS,Z
 goto $+3
 movwf pbase+1 ;in_isr... the "in isr" clause comes first in all of these macros. This
 goto $+2      ; is because isr execution is preemptive, and returns only at the 
 movwf pbase   ; completion of all triggered routines. So, it can starve out the main
#else          ; thread, and speeding up isr execution helps this problem. In most of
 movwf pbase   ; these macros, in-isr execution takes just 4 instruction cycles.
#endif 


 POP
 
 FAR_CALL divis ,kpush
 
#ifdef HLLMULTITASK 
 movf in_isr,f ;In shared RAM, no need for BANKSEL
 btfsc STATUS,Z
 goto $+3
 movf pbase+1,w			;in_isr
 goto $+2
 movf pbase,w	;not in_isr
#else
 movf pbase,w	
#endif  

 
;LOAD POINTER
 movwf FSR
 

 DISCARD


 DISCARD


 
 HALF_FAR_CALL kpop


 
 FAR_CALL divis ,safepush
 

 return
 

hllt4514 CODE
sqrt:
 movf FSR,w
 

 
 FAR_CALL sqrt ,kpush


 movlw .0
 



   
 FAR_CALL sqrt ,safepush


 movlw .255
 


   
 FAR_CALL sqrt ,safepush


 movlw .0
 



   
 FAR_CALL sqrt ,safepush


 movlw .255
 


   
 FAR_CALL sqrt ,safepush


 movlw .0

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL parm


 
 HALF_FAR_CALL utof


 
 HALF_FAR_CALL logf


 
 HALF_FAR_CALL mulf


 
 HALF_FAR_CALL powf


 
 HALF_FAR_CALL nextf


 
 HALF_FAR_CALL addf


 
 HALF_FAR_CALL ftou


 
 FAR_CALL sqrt,kpop
 
#ifdef HLLMULTITASK 
 movf in_isr,f ;In shared RAM, no need for BANKSEL
 btfsc STATUS,Z
 goto $+3
 movwf pbase+1 ;in_isr... the "in isr" clause comes first in all of these macros. This
 goto $+2      ; is because isr execution is preemptive, and returns only at the 
 movwf pbase   ; completion of all triggered routines. So, it can starve out the main
#else          ; thread, and speeding up isr execution helps this problem. In most of
 movwf pbase   ; these macros, in-isr execution takes just 4 instruction cycles.
#endif 


 POP
 
 FAR_CALL sqrt ,kpush
 
#ifdef HLLMULTITASK 
 movf in_isr,f ;In shared RAM, no need for BANKSEL
 btfsc STATUS,Z
 goto $+3
 movf pbase+1,w			;in_isr
 goto $+2
 movf pbase,w	;not in_isr
#else
 movf pbase,w	
#endif  

 
;LOAD POINTER
 movwf FSR
 

 DISCARD


 
 HALF_FAR_CALL kpop


 
 FAR_CALL sqrt ,safepush
 

 return
 
hllprgen2:
 goto hllprgen2
 





 
 

 


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
 
 FAR_CALL printu,printch
 banksel margpi 
 movfw margpi
 PUSH
 movlw .100 
 PUSH
 
 FAR_CALL printu,modu
 movlw .10
 PUSH
 
 FAR_CALL printu,divu
 POP
 addlw '0' 
 PUSH
 
 FAR_CALL printu,printch
 banksel margpi
 movfw margpi
 PUSH
 movlw .10 
 PUSH
 
 FAR_CALL printu,modu
 POP
 addlw '0' 
 PUSH
 
 FAR_CALL printu,printch  
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
 
 FAR_CALL printu,printch
 banksel margpi 
 movfw margpi
 PUSH
 movlw .100 
 PUSH
 
 FAR_CALL printu,modu
 movlw .10
 PUSH
 
 FAR_CALL printu,divu
 POP
 addlw '0' 
 PUSH
 
 FAR_CALL printu,printch
 banksel margpi
 movfw margpi
 PUSH
 movlw .10 
 PUSH
 
 FAR_CALL printu,modu
 POP
 addlw '0' 
 PUSH
 
 FAR_CALL printu,printch  
 return



#undefine margpi






 


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
 goto hllIAAAA
 btfsc STATUS,C
 goto hllJAAAA
hllIAAAA:
 movlw .1
 PUSH
 
 return
hllJAAAA:
 movlw .0
 PUSH
 
 return



#undefine mkarg1







 



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
 
 






 
 
hlog1f CODE

notb: 
 movf HLINDF,f
 btfsc STATUS,Z
 goto nbnb
 clrf HLINDF
 goto ncnc
nbnb: 
 bsf HLINDF,0 
ncnc:
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







  
 

sfp_pow CODE 



#define totest sfploc00


#define neg sfploc01


#define util sfploc02


#define exam sfploc03


#define karg2 sfploc04


#define karg1 sfploc05


powf:  
#ifdef HLLMULTITASK
#ifdef HLLGUARDsfploc 
 movf in_isr,f  
 btfsc STATUS,Z
 


 goto powf0














 POP
 banksel karg1
 movwf karg2 

 xorlw 0x80 
 btfss STATUS,Z 
 goto nonzpow 
 
 
 
 POP

 
 movlw .0
 PUSH
 PUSH
 return
 

nonzpow:


 POP
 banksel karg1
 movwf karg1
 clrf neg
 andlw .128
 btfss STATUS,Z
 bsf neg,0 
 movfw karg1
 andlw .127 
 
 

 addlw .128 
 movwf karg1 
 
 
 
 
 
 
 
 
 
 btfsc karg2,7
 goto gjjm44 
 movf karg2,f
 btfsc STATUS,Z
 goto gjjm44 
 movlw .7    
 subwf karg2,w
 btfss STATUS,C
 goto gjjm44 
 
 
 btfsc neg,0
 goto gjkm44
 
 
 
 movlw .127
 PUSH
 PUSH
 
 
 return

 
gjkm44:

 
 
 movlw .0
 PUSH
 
 movlw .128 
 PUSH
 
 
 return





gjjm44:
 
 
 movlw .8
 addwf karg2,w 
 movwf totest
 btfss totest,7
 goto gjjm45 
 
 
 
 
 
 
 
 
 
 
 movlw .0
 PUSH
 PUSH
 return
 
 
gjjm45:

 
 

























 


 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 bcf STATUS,C
 
 clrf util
 movfw karg2
 sublw .7
 
 
 
 
 movwf exam 

 movlw high FPRollTbl4 
 movwf PCLATH 
 movlw low FPRollTbl4
 addwf exam,w 
 btfsc STATUS,C 
 incf PCLATH,f 
 movwf PCL 

FPRollTbl4:

 goto shift0b
 goto shift1b
 goto shift2b
 goto shift3b
 goto shift4b
 goto shift5b
 goto shift6b
 goto shift7b
 goto shift8b
 goto shift9b
 goto shift10b
 goto shift11b
 goto shift12b
 goto shift13b
 goto shift14b
 


shift15b:
 RSHIFT karg1
 rrf util,f
shift14b:
 RSHIFT karg1
 rrf util,f
shift13b:
 RSHIFT karg1
 rrf util,f
shift12b:
 RSHIFT karg1
 rrf util,f
shift11b:
 RSHIFT karg1
 rrf util,f
shift10b:
 RSHIFT karg1
 rrf util,f
shift9b:
 RSHIFT karg1
 rrf util,f
shift8b:
 RSHIFT karg1
 rrf util,f
shift7b:
 RSHIFT karg1
 rrf util,f
shift6b:
 RSHIFT karg1
 rrf util,f
shift5b:
 RSHIFT karg1
 rrf util,f
shift4b:
 RSHIFT karg1
 rrf util,f
shift3b:
 RSHIFT karg1
 rrf util,f
shift2b:
 RSHIFT karg1
 rrf util,f
shift1b:
 RSHIFT karg1
 rrf util,f
 
 btfsc STATUS,C 
 incf util,f
shift0b:







 call FPCoreLook2 
 banksel karg1
 movwf util

 
 
 
 
 movf neg,f 
 btfsc STATUS,Z 
 goto dontnegate11 
 movlw .0 
 PUSH
 movlw .0
 PUSH 
 
dontnegate11:

 banksel karg1

 movfw util 
 PUSH
 banksel karg1

 movfw karg1 
 PUSH
 banksel karg1
 
 movf neg,f 
 btfsc STATUS,Z 
 goto dontnegate2 
 
 
 
 
 
 
 pagesel divf
 goto divf 
 

dontnegate2:
 
 return

FPCoreLook2:

 movlw high FPCoreTbl2 
 movwf PCLATH 
 movlw low FPCoreTbl2 
 addwf util,w 
 btfsc STATUS,C 
 incf PCLATH,f 
 movwf PCL 



#undefine totest


#undefine neg


#undefine util


#undefine exam


#undefine karg2


#undefine karg1


#define totest sfploc00+1


#define neg sfploc01+1


#define util sfploc02+1


#define exam sfploc03+1


#define karg2 sfploc04+1


#define karg1 sfploc05+1


powf0:
#endif
#endif














 POP
 banksel karg1
 movwf karg2 

 xorlw 0x80 
 btfss STATUS,Z 
 goto hllUCAAA 
 
 
 
 POP

 
 movlw .0
 PUSH
 PUSH
 return
 

hllUCAAA:


 POP
 banksel karg1
 movwf karg1
 clrf neg
 andlw .128
 btfss STATUS,Z
 bsf neg,0 
 movfw karg1
 andlw .127 
 
 

 addlw .128 
 movwf karg1 
 
 
 
 
 
 
 
 
 
 btfsc karg2,7
 goto hllWCAAA 
 movf karg2,f
 btfsc STATUS,Z
 goto hllWCAAA 
 movlw .7    
 subwf karg2,w
 btfss STATUS,C
 goto hllWCAAA 
 
 
 btfsc neg,0
 goto hllVCAAA
 
 
 
 movlw .127
 PUSH
 PUSH
 
 
 return

 
hllVCAAA:

 
 
 movlw .0
 PUSH
 
 movlw .128 
 PUSH
 
 
 return





hllWCAAA:
 
 
 movlw .8
 addwf karg2,w 
 movwf totest
 btfss totest,7
 goto hllXCAAA 
 
 
 
 
 
 
 
 
 
 
 movlw .0
 PUSH
 PUSH
 return
 
 
hllXCAAA:

 
 

























 


 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 bcf STATUS,C
 
 clrf util
 movfw karg2
 sublw .7
 
 
 
 
 movwf exam 

 movlw high hllYCAAA 
 movwf PCLATH 
 movlw low hllYCAAA
 addwf exam,w 
 btfsc STATUS,C 
 incf PCLATH,f 
 movwf PCL 

hllYCAAA:

 goto hllODAAA
 goto hllNDAAA
 goto hllMDAAA
 goto hllLDAAA
 goto hllKDAAA
 goto hllJDAAA
 goto hllIDAAA
 goto hllHDAAA
 goto hllGDAAA
 goto hllFDAAA
 goto hllEDAAA
 goto hllDDAAA
 goto hllCDAAA
 goto hllBDAAA
 goto hllADAAA
 


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
 RSHIFT karg1
 rrf util,f
hllEDAAA:
 RSHIFT karg1
 rrf util,f
hllFDAAA:
 RSHIFT karg1
 rrf util,f
hllGDAAA:
 RSHIFT karg1
 rrf util,f
hllHDAAA:
 RSHIFT karg1
 rrf util,f
hllIDAAA:
 RSHIFT karg1
 rrf util,f
hllJDAAA:
 RSHIFT karg1
 rrf util,f
hllKDAAA:
 RSHIFT karg1
 rrf util,f
hllLDAAA:
 RSHIFT karg1
 rrf util,f
hllMDAAA:
 RSHIFT karg1
 rrf util,f
hllNDAAA:
 RSHIFT karg1
 rrf util,f
 
 btfsc STATUS,C 
 incf util,f
hllODAAA:







 call hllRDAAA 
 banksel karg1
 movwf util

 
 
 
 
 movf neg,f 
 btfsc STATUS,Z 
 goto hllPDAAA 
 movlw .0 
 PUSH
 movlw .0
 PUSH 
 
hllPDAAA:

 banksel karg1

 movfw util 
 PUSH
 banksel karg1

 movfw karg1 
 PUSH
 banksel karg1
 
 movf neg,f 
 btfsc STATUS,Z 
 goto hllQDAAA 
 
 
 
 
 
 
 pagesel divf
 goto divf 
 

hllQDAAA:
 
 return

hllRDAAA:

 movlw high FPCoreTbl2 
 movwf PCLATH 
 movlw low FPCoreTbl2 
 addwf util,w 
 btfsc STATUS,C 
 incf PCLATH,f 
 movwf PCL 



#undefine totest


#undefine neg


#undefine util


#undefine exam


#undefine karg2


#undefine karg1
FPCoreTbl2:
 retlw .0 
 retlw .0 
 retlw .1 
 retlw .1 
 retlw .1 
 retlw .2 
 retlw .2 
 retlw .2 
 retlw .3 
 retlw .3 
 retlw .4 
 retlw .4 
 retlw .4 
 retlw .5 
 retlw .5 
 retlw .5 
 retlw .6 
 retlw .6 
 retlw .6 
 retlw .7 
 retlw .7 
 retlw .7 
 retlw .8 
 retlw .8 
 retlw .9 
 retlw .9 
 retlw .9 
 retlw .10 
 retlw .10 
 retlw .10 
 retlw .11 
 retlw .11 
 retlw .12 
 retlw .12 
 retlw .12 
 retlw .13 
 retlw .13 
 retlw .13 
 retlw .14 
 retlw .14 
 retlw .15 
 retlw .15 
 retlw .15 
 retlw .16 
 retlw .16 
 retlw .17 
 retlw .17 
 retlw .17 
 retlw .18 
 retlw .18 
 retlw .19 
 retlw .19 
 retlw .19 
 retlw .20 
 retlw .20 
 retlw .21 
 retlw .21 
 retlw .21 
 retlw .22 
 retlw .22 
 retlw .23 
 retlw .23 
 retlw .23 
 retlw .24 
 retlw .24 
 retlw .25 
 retlw .25 
 retlw .25 
 retlw .26 
 retlw .26 
 retlw .27 
 retlw .27 
 retlw .28 
 retlw .28 
 retlw .28 
 retlw .29 
 retlw .29 
 retlw .30 
 retlw .30 
 retlw .31 
 retlw .31 
 retlw .31 
 retlw .32 
 retlw .32 
 retlw .33 
 retlw .33 
 retlw .34 
 retlw .34 
 retlw .34 
 retlw .35 
 retlw .35 
 retlw .36 
 retlw .36 
 retlw .37 
 retlw .37 
 retlw .38 
 retlw .38 
 retlw .38 
 retlw .39 
 retlw .39 
 retlw .40 
 retlw .40 
 retlw .41 
 retlw .41 
 retlw .42 
 retlw .42 
 retlw .43 
 retlw .43 
 retlw .43 
 retlw .44 
 retlw .44 
 retlw .45 
 retlw .45 
 retlw .46 
 retlw .46 
 retlw .47 
 retlw .47 
 retlw .48 
 retlw .48 
 retlw .49 
 retlw .49 
 retlw .50 
 retlw .50 
 retlw .51 
 retlw .51 
 retlw .52 
 retlw .52 
 retlw .53 
 retlw .53 
 retlw .54 
 retlw .54 
 retlw .54 
 retlw .55 
 retlw .55 
 retlw .56 
 retlw .56 
 retlw .57 
 retlw .57 
 retlw .58 
 retlw .58 
 retlw .59 
 retlw .60 
 retlw .60 
 retlw .61 
 retlw .61 
 retlw .62 
 retlw .62 
 retlw .63 
 retlw .63 
 retlw .64 
 retlw .64 
 retlw .65 
 retlw .65 
 retlw .66 
 retlw .66 
 retlw .67 
 retlw .67 
 retlw .68 
 retlw .68 
 retlw .69 
 retlw .69 
 retlw .70 
 retlw .70 
 retlw .71 
 retlw .72 
 retlw .72 
 retlw .73 
 retlw .73 
 retlw .74 
 retlw .74 
 retlw .75 
 retlw .75 
 retlw .76 
 retlw .76 
 retlw .77 
 retlw .78 
 retlw .78 
 retlw .79 
 retlw .79 
 retlw .80 
 retlw .80 
 retlw .81 
 retlw .82 
 retlw .82 
 retlw .83 
 retlw .83 
 retlw .84 
 retlw .84 
 retlw .85 
 retlw .86 
 retlw .86 
 retlw .87 
 retlw .87 
 retlw .88 
 retlw .88 
 retlw .89 
 retlw .90 
 retlw .90 
 retlw .91 
 retlw .91 
 retlw .92 
 retlw .93 
 retlw .93 
 retlw .94 
 retlw .94 
 retlw .95 
 retlw .96 
 retlw .96 
 retlw .97 
 retlw .97 
 retlw .98 
 retlw .99 
 retlw .99 
 retlw .100 
 retlw .100 
 retlw .101 
 retlw .102 
 retlw .102 
 retlw .103 
 retlw .104 
 retlw .104 
 retlw .105 
 retlw .105 
 retlw .106 
 retlw .107 
 retlw .107 
 retlw .108 
 retlw .109 
 retlw .109 
 retlw .110 
 retlw .111 
 retlw .111 
 retlw .112 
 retlw .113 
 retlw .113 
 retlw .114 
 retlw .115 
 retlw .115 
 retlw .116 
 retlw .116 
 retlw .117 
 retlw .118 
 retlw .118 
 retlw .119 
 retlw .120 
 retlw .120 
 retlw .121 
 retlw .122 
 retlw .123 
 retlw .123 
 retlw .124 
 retlw .125 
 retlw .125 
 retlw .126 
 retlw .127 
 retlw .127 


 
 





 

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
 goto hllSDAAA
 POP
 goto hllCEAAA 
hllSDAAA:
 
 POP
 addlw .128
 banksel karg1
 movwf karg1 
 
 movfw karg2
 sublw .7
 
 movwf divisor 

 movlw high hllTDAAA 
 movwf PCLATH 
 movlw low hllTDAAA
 addwf divisor,w 
 btfsc STATUS,C 
 incf PCLATH,f 
 movwf PCL 


hllTDAAA:
 goto hllBEAAA
 goto hllAEAAA
 goto hllZDAAA 
 goto hllYDAAA
 goto hllXDAAA
 goto hllWDAAA
 goto hllVDAAA
 goto hllUDAAA
 
hllUDAAA:
 RSHIFT karg1
 rrf util,f
hllVDAAA:
 RSHIFT karg1
 rrf util,f
hllWDAAA:
 RSHIFT karg1
 rrf util,f
hllXDAAA:
 RSHIFT karg1
 rrf util,f
hllYDAAA:
 RSHIFT karg1
 rrf util,f
hllZDAAA:
 RSHIFT karg1
 rrf util,f
hllAEAAA:
 RSHIFT karg1
 rrf util,f
hllBEAAA:

hllCEAAA:
 banksel karg1
 movfw karg1 
 PUSH
 
 
 return




#undefine util


#undefine divisor


#undefine karg2


#undefine karg1





 

sfp_log CODE 



#define moutH sfploc00


#define moutL sfploc01


#define mout sfploc02


#define rev sfploc03


#define neg sfploc04


#define exam sfploc05


#define util sfploc06


#define karg1 sfploc07


#define arg1 sfploc08


logf:  
#ifdef HLLMULTITASK
#ifdef HLLGUARDsfploc 
 movf in_isr,f  
 btfsc STATUS,Z
 


 goto logf0


 
 
 
 
 
 
 
logf: 


 POP
 
 banksel arg1
 movwf util 


 POP
 movwf mout 




 movf mout,f
 btfss STATUS,Z
 goto nzmdss



 movf util,f
 btfss STATUS,Z
 goto nzmdss 




 movlw .128
 PUSH
 PUSH
 


 return 

nzmdss:


 call look_core 
 movwf moutL 


 movf mout,w
 call look_core_hi
 movwf moutH 

 

 
 clrf neg
 
 
 btfss util,7
 goto nonegtlog

 
 bsf neg,0
 
 
 comf util,f 
 
 
 incf util,f 


 
nonegtlog:

 btfsc util,7
 goto fi5tt2
 btfsc util,6
 goto fi5tt3
 btfsc util,5
 goto fi5tt4
 btfsc util,4
 goto fi5tt5
 btfsc util,3
 goto fi5tt6
 btfsc util,2
 goto fi5tt7
 btfsc util,1
 goto fi5tt8
 btfsc util,0
 goto fi5tt9
 goto fi5ttz
 
 
fi5tt2:







 RSHIFT moutH
 
 
 
 


 rrf moutL
fi5tt3:
 
 
 
 
 
 
 RSHIFT moutH
 
 
 
 
 
 
 
 
 rrf moutL
fi5tt4:
 
 
 
 
 
 RSHIFT moutH
 
 
 
 
 
 
 rrf moutL
fi5tt5:
 
 
 
 
 
 
 
 RSHIFT moutH
 
 
 
 
 
 
 
 rrf moutL
fi5tt6:
 
 
 
 
 RSHIFT moutH
  
 
 
 
 
 rrf moutL
fi5tt7:
 
 
 
 
 
 RSHIFT moutH
 
 
 
 
 
 
 rrf moutL
fi5tt8:
 
 
 
 
 
 
 
 RSHIFT moutH
 
 
 
 
 
 
 
 
 
 
 rrf moutL
fi5tt9:
 
 
 
 
 
 
 RSHIFT moutH
 
 
 
 
 
 
 rrf moutL

 
 btfss STATUS,C
 goto fi5ttz
 
 
 incf moutL,f
 
 
 movf moutL,f
 btfsc STATUS,Z
 
 incf moutH,f
fi5ttz:

 
 
  btfss neg,0
  goto m1gd6
 
  comf moutH,f
 
  comf moutL,f
 
  incf moutL,f
 
  btfsc STATUS,Z
 
  incf moutH,f
 m1gd6:
 
 
  btfss util,7
  goto gkbb11
 
  movlw -.1
  movwf rev
 
  movf util,w
  addwf moutH,f
 
  goto kkbbg3
 gkbb11:

  btfss util,6
  goto gkbb22

 
   movlw -.2
   movwf rev

 
  bcf STATUS,C
  rlf util,w
  addwf moutH,f
  goto kkbbg3
 gkbb22:

  btfss util,5
  goto gkbb33

 
   movlw -.3
   movwf rev

 
   
   
   
   
   
   
 
 LSHIFT util
   
   
   
   
   
   bcf STATUS,C
   rlf util,w
   addwf moutH,f

  goto kkbbg3
 gkbb33:

  btfss util,4
  goto gkbb44

 
   movlw -.4
   movwf rev

 




 
 
 
 
 LSHIFT util




   bcf STATUS,C
   rlf util,w
   addwf moutH,f

  goto kkbbg3
 gkbb44:

  btfss util,3
  goto gkbb55

 
   movlw -.5
   movwf rev

 
 





 LSHIFT util
 LSHIFT util
 LSHIFT util
  


   bcf STATUS,C
   rlf util,w
   addwf moutH,f
   goto kkbbg3
 gkbb55:

  btfss util,2
  goto gkbb66

 
   movlw -.6
   movwf rev

 
  




  
  
 LSHIFT util
 LSHIFT util
 LSHIFT util
 LSHIFT util
 

 
 
 



   bcf STATUS,C
   rlf util,w
   addwf moutH,f
   goto kkbbg3

 gkbb66:

  btfss util,1
  goto gkbb77

 
   movlw -.7
   movwf rev







 btfss util,1
  goto ncrre
  movlw .128
  addwf moutH,f
ncrre: 
  btfss util,0
  goto kkbbg3
  movlw .64
  addwf moutH,f
  goto kkbbg3
gkbb77:
 
  btfss util,0
  goto gkbb88

 
   movlw -.8
   movwf rev

 
 
  
  movlw .128
  addwf moutH,f
 
  goto kkbbg3
gkbb88:
 
   movlw -.9
   movwf rev
kkbbg3:

 
 
 
 movf moutH,f
 btfsc STATUS,Z
 goto nrndmg00
 
normaa:
 
 movf moutH,w 
 btfsc STATUS,Z
 goto normaout




 
 
 
 
 
 
 
 
 
 
 
 
 
 
 RSHIFT moutH											
											
											
											
											
											
											
											
											
											
											
 rrf moutL,f 

 
 incf rev,f 
 
 goto normaa
 
 
 
normaout:
 
 btfss STATUS,C 
 goto nrndmg00

  
  incf moutL,f

 
 
  btfss STATUS,Z
  goto nrndmg00
 
  
 
 
 
 
 
  incf moutH,f
 
 
  incf rev,f
 
  movlw .128
  movwf moutL
 
nrndmg00:
 
 
 
 

 
 
 bcf moutL,7
 
 
 btfsc neg,0
 bsf moutL,7
 
 
 movf moutL,w
 PUSH
 
 movf rev,w
 PUSH
 
 return
 
look_core: 
 movlw high FPCoreTbk 
 movwf PCLATH 
 movlw low FPCoreTbk
 addwf mout,w 
 btfsc STATUS,C 
 incf PCLATH,f 
 movwf PCL 
FPCoreTbk: 
 retlw .0
 retlw .224
 retlw .186
 retlw .142
 retlw .93 
 retlw .39
 retlw .235
 retlw .170
 retlw .100
 retlw .25
 retlw .200
 retlw .115
 retlw .25 
 retlw .186
 retlw .86
 retlw .237
 retlw .129
 retlw .15
 retlw .152
 retlw .30
 retlw .159
 retlw .27
 retlw .148
 retlw .8
 retlw .120
 retlw .228
 retlw .76
 retlw .176
 retlw .16
 retlw .108
 retlw .197
 retlw .32
 retlw .106
 retlw .183
 retlw .2
 retlw .70
 retlw .137
 retlw .199
 retlw .32
 retlw .58
 retlw .111
 retlw .160
 retlw .206
 retlw .248
 retlw .32
 retlw .68
 retlw .101
 retlw .131
 retlw .157
 retlw .181
 retlw .202
 retlw .219
 retlw .234
 retlw .246
 retlw .200
 retlw .8
 retlw .8
 retlw .16
 retlw .6
 retlw .8
 retlw .250
 retlw .239
 retlw .226
 retlw .210
 retlw .193
 retlw .171
 retlw .148
 retlw .122
 retlw .94
 retlw .63
 retlw .30
 retlw .250
 retlw .212
 retlw .171
 retlw .129
 retlw .83
 retlw .36
 retlw .242
 retlw .190
 retlw .136
 retlw .80
 retlw .21
 retlw .217
 retlw .154
 retlw .89
 retlw .22
 retlw .209
 retlw .138
 retlw .64
 retlw .245
 retlw .168
 retlw .88
 retlw .16
 retlw .180
 retlw .95
 retlw .8
 retlw .175
 retlw .84
 retlw .247
 retlw .153
 retlw .56
 retlw .214
 retlw .114
 retlw .12
 retlw .165
 retlw .59
 retlw .208
 retlw .99
 retlw .245
 retlw .133
 retlw .19
 retlw .159
 retlw .42
 retlw .179
 retlw .59
 retlw .193
 retlw .69
 retlw .200
 retlw .73
 retlw .201
 retlw .70
 retlw .195
 retlw .62
 retlw .183
 retlw .47
 retlw .165
 retlw .27
 retlw .142 


look_core_hi: 
 movlw high FPCoreTblHi 
 movwf PCLATH 
 movlw low FPCoreTblHi 
 addwf mout,w 
 btfsc STATUS,C 
 incf PCLATH,f 
 movwf PCL 
 


#undefine moutH


#undefine moutL


#undefine mout


#undefine rev


#undefine neg


#undefine exam


#undefine util


#undefine karg1


#undefine arg1


#define moutH sfploc00+1


#define moutL sfploc01+1


#define mout sfploc02+1


#define rev sfploc03+1


#define neg sfploc04+1


#define exam sfploc05+1


#define util sfploc06+1


#define karg1 sfploc07+1


#define arg1 sfploc08+1


logf0:
#endif
#endif


 
 
 
 
 
 
 
hllDEAAA: 


 POP
 
 banksel arg1
 movwf util 


 POP
 movwf mout 




 movf mout,f
 btfss STATUS,Z
 goto hllEEAAA



 movf util,f
 btfss STATUS,Z
 goto hllEEAAA 




 movlw .128
 PUSH
 PUSH
 


 return 

hllEEAAA:


 call hllDFAAA 
 movwf moutL 


 movf mout,w
 call hllDFAAA_hi
 movwf moutH 

 

 
 clrf neg
 
 
 btfss util,7
 goto hllFEAAA

 
 bsf neg,0
 
 
 comf util,f 
 
 
 incf util,f 


 
hllFEAAA:

 btfsc util,7
 goto hllGEAAA
 btfsc util,6
 goto hllHEAAA
 btfsc util,5
 goto hllIEAAA
 btfsc util,4
 goto hllJEAAA
 btfsc util,3
 goto hllKEAAA
 btfsc util,2
 goto hllLEAAA
 btfsc util,1
 goto hllMEAAA
 btfsc util,0
 goto hllNEAAA
 goto hllOEAAA
 
 
hllGEAAA:







 RSHIFT moutH
 
 
 
 


 rrf moutL
hllHEAAA:
 
 
 
 
 
 
 RSHIFT moutH
 
 
 
 
 
 
 
 
 rrf moutL
hllIEAAA:
 
 
 
 
 
 RSHIFT moutH
 
 
 
 
 
 
 rrf moutL
hllJEAAA:
 
 
 
 
 
 
 
 RSHIFT moutH
 
 
 
 
 
 
 
 rrf moutL
hllKEAAA:
 
 
 
 
 RSHIFT moutH
  
 
 
 
 
 rrf moutL
hllLEAAA:
 
 
 
 
 
 RSHIFT moutH
 
 
 
 
 
 
 rrf moutL
hllMEAAA:
 
 
 
 
 
 
 
 RSHIFT moutH
 
 
 
 
 
 
 
 
 
 
 rrf moutL
hllNEAAA:
 
 
 
 
 
 
 RSHIFT moutH
 
 
 
 
 
 
 rrf moutL

 
 btfss STATUS,C
 goto hllOEAAA
 
 
 incf moutL,f
 
 
 movf moutL,f
 btfsc STATUS,Z
 
 incf moutH,f
hllOEAAA:

 
 
  btfss neg,0
  goto hllPEAAA
 
  comf moutH,f
 
  comf moutL,f
 
  incf moutL,f
 
  btfsc STATUS,Z
 
  incf moutH,f
 hllPEAAA:
 
 
  btfss util,7
  goto hllQEAAA
 
  movlw -.1
  movwf rev
 
  movf util,w
  addwf moutH,f
 
  goto hllZEAAA
 hllQEAAA:

  btfss util,6
  goto hllREAAA

 
   movlw -.2
   movwf rev

 
  bcf STATUS,C
  rlf util,w
  addwf moutH,f
  goto hllZEAAA
 hllREAAA:

  btfss util,5
  goto hllSEAAA

 
   movlw -.3
   movwf rev

 
   
   
   
   
   
   
 
 LSHIFT util
   
   
   
   
   
   bcf STATUS,C
   rlf util,w
   addwf moutH,f

  goto hllZEAAA
 hllSEAAA:

  btfss util,4
  goto hllTEAAA

 
   movlw -.4
   movwf rev

 




 
 
 
 
 LSHIFT util




   bcf STATUS,C
   rlf util,w
   addwf moutH,f

  goto hllZEAAA
 hllTEAAA:

  btfss util,3
  goto hllUEAAA

 
   movlw -.5
   movwf rev

 
 





 LSHIFT util
 LSHIFT util
 LSHIFT util
  


   bcf STATUS,C
   rlf util,w
   addwf moutH,f
   goto hllZEAAA
 hllUEAAA:

  btfss util,2
  goto hllVEAAA

 
   movlw -.6
   movwf rev

 
  




  
  
 LSHIFT util
 LSHIFT util
 LSHIFT util
 LSHIFT util
 

 
 
 



   bcf STATUS,C
   rlf util,w
   addwf moutH,f
   goto hllZEAAA

 hllVEAAA:

  btfss util,1
  goto hllXEAAA

 
   movlw -.7
   movwf rev







 btfss util,1
  goto hllWEAAA
  movlw .128
  addwf moutH,f
hllWEAAA: 
  btfss util,0
  goto hllZEAAA
  movlw .64
  addwf moutH,f
  goto hllZEAAA
hllXEAAA:
 
  btfss util,0
  goto hllYEAAA

 
   movlw -.8
   movwf rev

 
 
  
  movlw .128
  addwf moutH,f
 
  goto hllZEAAA
hllYEAAA:
 
   movlw -.9
   movwf rev
hllZEAAA:

 
 
 
 movf moutH,f
 btfsc STATUS,Z
 goto hllCFAAA
 
hllAFAAA:
 
 movf moutH,w 
 btfsc STATUS,Z
 goto hllBFAAA




 
 
 
 
 
 
 
 
 
 
 
 
 
 
 RSHIFT moutH											
											
											
											
											
											
											
											
											
											
											
 rrf moutL,f 

 
 incf rev,f 
 
 goto hllAFAAA
 
 
 
hllBFAAA:
 
 btfss STATUS,C 
 goto hllCFAAA

  
  incf moutL,f

 
 
  btfss STATUS,Z
  goto hllCFAAA
 
  
 
 
 
 
 
  incf moutH,f
 
 
  incf rev,f
 
  movlw .128
  movwf moutL
 
hllCFAAA:
 
 
 
 

 
 
 bcf moutL,7
 
 
 btfsc neg,0
 bsf moutL,7
 
 
 movf moutL,w
 PUSH
 
 movf rev,w
 PUSH
 
 return
 
hllDFAAA: 
 movlw high hllEFAAA 
 movwf PCLATH 
 movlw low hllEFAAA
 addwf mout,w 
 btfsc STATUS,C 
 incf PCLATH,f 
 movwf PCL 
hllEFAAA: 
 retlw .0
 retlw .224
 retlw .186
 retlw .142
 retlw .93 
 retlw .39
 retlw .235
 retlw .170
 retlw .100
 retlw .25
 retlw .200
 retlw .115
 retlw .25 
 retlw .186
 retlw .86
 retlw .237
 retlw .129
 retlw .15
 retlw .152
 retlw .30
 retlw .159
 retlw .27
 retlw .148
 retlw .8
 retlw .120
 retlw .228
 retlw .76
 retlw .176
 retlw .16
 retlw .108
 retlw .197
 retlw .32
 retlw .106
 retlw .183
 retlw .2
 retlw .70
 retlw .137
 retlw .199
 retlw .32
 retlw .58
 retlw .111
 retlw .160
 retlw .206
 retlw .248
 retlw .32
 retlw .68
 retlw .101
 retlw .131
 retlw .157
 retlw .181
 retlw .202
 retlw .219
 retlw .234
 retlw .246
 retlw .200
 retlw .8
 retlw .8
 retlw .16
 retlw .6
 retlw .8
 retlw .250
 retlw .239
 retlw .226
 retlw .210
 retlw .193
 retlw .171
 retlw .148
 retlw .122
 retlw .94
 retlw .63
 retlw .30
 retlw .250
 retlw .212
 retlw .171
 retlw .129
 retlw .83
 retlw .36
 retlw .242
 retlw .190
 retlw .136
 retlw .80
 retlw .21
 retlw .217
 retlw .154
 retlw .89
 retlw .22
 retlw .209
 retlw .138
 retlw .64
 retlw .245
 retlw .168
 retlw .88
 retlw .16
 retlw .180
 retlw .95
 retlw .8
 retlw .175
 retlw .84
 retlw .247
 retlw .153
 retlw .56
 retlw .214
 retlw .114
 retlw .12
 retlw .165
 retlw .59
 retlw .208
 retlw .99
 retlw .245
 retlw .133
 retlw .19
 retlw .159
 retlw .42
 retlw .179
 retlw .59
 retlw .193
 retlw .69
 retlw .200
 retlw .73
 retlw .201
 retlw .70
 retlw .195
 retlw .62
 retlw .183
 retlw .47
 retlw .165
 retlw .27
 retlw .142 


hllDFAAA_hi: 
 movlw high FPCoreTblHi 
 movwf PCLATH 
 movlw low FPCoreTblHi 
 addwf mout,w 
 btfsc STATUS,C 
 incf PCLATH,f 
 movwf PCL 
 


#undefine moutH


#undefine moutL


#undefine mout


#undefine rev


#undefine neg


#undefine exam


#undefine util


#undefine karg1


#undefine arg1
FPCoreTblHi: 
 retlw .0
 retlw .2
 retlw .5
 retlw .8
 retlw .11
 retlw .14
 retlw .16
 retlw .19
 retlw .22
 retlw .25
 retlw .27
 retlw .30
 retlw .33
 retlw .35
 retlw .38
 retlw .40
 retlw .43
 retlw .46
 retlw .48
 retlw .51
 retlw .53
 retlw .56
 retlw .58
 retlw .61
 retlw .63
 retlw .65
 retlw .68
 retlw .70
 retlw .73
 retlw .75
 retlw .77
 retlw .80
 retlw .82
 retlw .84
 retlw .87
 retlw .89
 retlw .91
 retlw .93
 retlw .96
 retlw .98
 retlw .100
 retlw .102
 retlw .104
 retlw .106
 retlw .109
 retlw .111
 retlw .113
 retlw .115
 retlw .117
 retlw .119
 retlw .121
 retlw .123
 retlw .125
 retlw .127
 retlw .129
 retlw .132
 retlw .134
 retlw .136
 retlw .138
 retlw .140
 retlw .141
 retlw .143
 retlw .145
 retlw .147
 retlw .149
 retlw .151
 retlw .153
 retlw .155
 retlw .157
 retlw .159
 retlw .161
 retlw .162
 retlw .164
 retlw .166
 retlw .168
 retlw .170
 retlw .172
 retlw .173
 retlw .175
 retlw .177
 retlw .179
 retlw .181
 retlw .182
 retlw .184
 retlw .186
 retlw .188
 retlw .189
 retlw .191
 retlw .193
 retlw .194
 retlw .196
 retlw .198
 retlw .200
 retlw .201
 retlw .203
 retlw .205
 retlw .206
 retlw .208
 retlw .209
 retlw .211
 retlw .213
 retlw .214
 retlw .216
 retlw .218
 retlw .219
 retlw .221
 retlw .222
 retlw .224
 retlw .225
 retlw .227
 retlw .229
 retlw .230
 retlw .232
 retlw .233
 retlw .235
 retlw .236
 retlw .238
 retlw .239
 retlw .241
 retlw .242
 retlw .244
 retlw .245
 retlw .247
 retlw .248
 retlw .250
 retlw .251
 retlw .253
 retlw .254

 







 
 

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
 goto hllGFAAA
 movlw .127	
 
 andwf HLINDF,w 
 
 btfsc STATUS,Z
 goto hllOFAAA
 
hllGFAAA: 

 
 
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
 goto hllHFAAA
 movlw .127

 andwf HLINDF,w 
 btfsc STATUS,Z
 goto hllPFAAA
hllHFAAA:

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
 goto hllRFAAA 

hllIFAAA:

 
 POP


 banksel mout
 movwf mout 

 
 btfss mout,7 
 goto hllJFAAA 

 
 POP

 
 banksel util
 incf util,f 


 
 andlw .128 
 btfss STATUS,Z
 incf mout,f

 goto hllKFAAA 


hllJFAAA: 

 
 
 
 
 

 
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
 


hllKFAAA: 

 
 movfw mout 

 
 addlw -.128 

 
 movwf mout 

 
 btfsc neg,0
 goto hllLFAAA 
 btfss neg,1
 goto hllNFAAA 
 goto hllMFAAA 
hllLFAAA: 
 btfsc neg,1
 goto hllNFAAA 

hllMFAAA: 

 
 movfw mout 

 
 iorlw .128 

 
 movwf mout 


hllNFAAA: 

 
 movfw mout 

 
 PUSH

 
 banksel util
 movfw util 
 PUSH
 
 goto hllQFAAA 

hllOFAAA: 

 POP
 POP


hllPFAAA:
 POP

 
 movlw .128
 PUSH
 PUSH

 
 
hllQFAAA:
 
 return
 
 
 
 
hllRFAAA: 

 POP
 banksel factor1
 movwf factor1

 POP
 banksel factor2
 movwf factor2


 
 clrf hi_byte
 
 clrf make_mout
 
 clrf iterator

hllSFAAA:

 
 btfss factor1,0
 goto hllTFAAA

 
 
 movfw factor2
 addwf make_mout,f

 
 btfsc STATUS,C
 incf hi_byte,f


hllTFAAA:
 
 
 RSHIFT factor1
 
 
 
 RSHIFT hi_byte
 
 
 
 
 
 
 rrf make_mout,f


 
 
 
 
 
 
 
 
 
 
 
 
 btfsc STATUS,C
 bsf factor1,7 


 incf iterator,f


 movlw .8
 xorwf iterator,w
 btfss STATUS,Z
 goto hllSFAAA

 
 movfw factor1 
 PUSH

 
 banksel make_mout
 movfw make_mout
 PUSH

 goto hllIFAAA 





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

 
sfp_nex CODE 



#define loc001 sfploc00


#define loc000 sfploc01


nextf:  
#ifdef HLLMULTITASK
#ifdef HLLGUARDsfploc 
 movf in_isr,f  
 btfsc STATUS,Z
 


 goto nextf0

 POP 
 banksel loc001 
 movwf loc001
 POP 
 movwf loc000
 andlw .127
 xorlw .127
 btfss STATUS,Z 
 goto m0r33n
 movfw loc000
 andlw .128
 movwf loc000
 incf loc001,f
 goto m0r34d   
m0r33n:
 incf loc000,f
m0r34d:
 movfw loc000
 PUSH
 movfw loc001
 PUSH
 return



#undefine loc001


#undefine loc000


#define loc001 sfploc00+1


#define loc000 sfploc01+1


nextf0:
#endif
#endif

 POP 
 banksel loc001 
 movwf loc001
 POP 
 movwf loc000
 andlw .127
 xorlw .127
 btfss STATUS,Z 
 goto hllUFAAA
 movfw loc000
 andlw .128
 movwf loc000
 incf loc001,f
 goto hllVFAAA   
hllUFAAA:
 incf loc000,f
hllVFAAA:
 movfw loc000
 PUSH
 movfw loc001
 PUSH
 return



#undefine loc001


#undefine loc000





 



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
 goto hllYFAAA 
 
 
 

 bcf arg1,7 
 movfw arg1 
 
 PUSH


 movlw .7
 PUSH
 
 goto hllGGAAA

hllYFAAA: 
 btfss arg1,6
 goto hllZFAAA 


 
 

 
 
 

 banksel arg1
 bcf arg1,6 
 bcf STATUS,C 
 rlf arg1,f
 movfw arg1
 PUSH

 movlw .6
 PUSH
 
 goto hllGGAAA
hllZFAAA: 

 btfss arg1,5
 goto hllAGAAA

 banksel arg1
 bcf arg1,5 
 bcf STATUS,C 
 rlf arg1,f
 rlf arg1,f
 movfw arg1
 PUSH

 movlw .5
 PUSH
 
 goto hllGGAAA
hllAGAAA: 

 btfss arg1,4
 goto hllBGAAA


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
 
 goto hllGGAAA
hllBGAAA: 

 btfss arg1,3
 goto hllCGAAA

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
 
 goto hllGGAAA

hllCGAAA: 

 btfss arg1,2
 goto hllDGAAA


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
 
 goto hllGGAAA

hllDGAAA: 

 btfss arg1,1
 goto hllEGAAA

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

 goto hllGGAAA
hllEGAAA: 
 btfss arg1,0
 goto hllFGAAA
 movlw .0
 PUSH

 movlw .0
 PUSH
 
 goto hllGGAAA
hllFGAAA:
 movlw .0
 PUSH

 movlw -.128
 PUSH
 
hllGGAAA:
 
 return




#undefine arg1

 end
