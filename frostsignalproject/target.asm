
#include "hloe.inc"

 __config  _CONFIG1,_WDTE_OFF  & _BOREN_OFF & _FOSC_INTOSC & _PWRTE_OFF & _MCLRE_OFF & _CLKOUTEN_OFF & _IESO_OFF & _FCMEN_OFF
 __config  _CONFIG2,_PLLEN_ON & _STVREN_ON



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
 


 movlw TXCKSEL


   
 FAR_CALL hlluserprog ,safepush

   banksel APFCON1
   movfw APFCON1
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL hlluserprog,setbit

 POP
 banksel APFCON1
 movwf APFCON1
 


 
 HALF_FAR_CALL cls


 
 FAR_CALL hlluserprog,longf

    
hllprogend:
 goto hllprogend
 

hllt450 CODE
longf:


 movlw .8

   
 FAR_CALL longf ,safepush


 movlw .0

   
 HALF_FAR_CALL safepush


 
 FAR_CALL longf,samplef


 movlw .0
 



   
 FAR_CALL longf ,safepush


 movlw .7
 


   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL divf


 
 FAR_CALL longf,ftou


 movlw .10

   
 FAR_CALL longf ,safepush


 movlw .10

   
 HALF_FAR_CALL safepush


 
 FAR_CALL longf,graphx

 ;
 goto longf

 

hllt4511 CODE
samplef:

 movf FSR0L,w
 

 
 FAR_CALL samplef ,kpush


 movlw .0

   
 HALF_FAR_CALL safepush


 
 FAR_CALL samplef,parm


 movlw .0

   
 HALF_FAR_CALL safepush


 
 FAR_CALL samplef,eq

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J9 
 

 movlw .2

   
 FAR_CALL samplef ,safepush


 movlw .3

   
 FAR_CALL samplef ,safepush


 movlw .4

   
 FAR_CALL samplef ,safepush

   banksel ADCON0
   movfw ADCON0
   
   

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL clearbit


 
 HALF_FAR_CALL clearbit


 
 FAR_CALL samplef,clearbit

 
 goto hlllb51J10
 

hlllb51J9:


 movlw .0

   
 HALF_FAR_CALL safepush


 
 FAR_CALL samplef,parm


 movlw .1

   
 HALF_FAR_CALL safepush


 
 FAR_CALL samplef,eq

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J7 
 

 movlw .2

   
 FAR_CALL samplef ,safepush


 movlw .3

   
 FAR_CALL samplef ,safepush


 movlw .4

   
 FAR_CALL samplef ,safepush

   banksel ADCON0
   movfw ADCON0
   
   

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL clearbit


 
 HALF_FAR_CALL clearbit


 
 FAR_CALL samplef,setbit

 
 goto hlllb51J8
 

hlllb51J7:


 movlw .0

   
 HALF_FAR_CALL safepush


 
 FAR_CALL samplef,parm


 movlw .2

   
 HALF_FAR_CALL safepush


 
 FAR_CALL samplef,eq

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J5 
 

 movlw .2

   
 FAR_CALL samplef ,safepush


 movlw .3

   
 FAR_CALL samplef ,safepush


 movlw .4

   
 FAR_CALL samplef ,safepush

   banksel ADCON0
   movfw ADCON0
   
   

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL clearbit


 
 HALF_FAR_CALL setbit


 
 FAR_CALL samplef,clearbit

 
 goto hlllb51J6
 

hlllb51J5:


 movlw .0

   
 HALF_FAR_CALL safepush


 
 FAR_CALL samplef,parm


 movlw .3

   
 HALF_FAR_CALL safepush


 
 FAR_CALL samplef,eq

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J3 
 

 movlw .2

   
 FAR_CALL samplef ,safepush


 movlw .3

   
 FAR_CALL samplef ,safepush


 movlw .4

   
 FAR_CALL samplef ,safepush

   banksel ADCON0
   movfw ADCON0
   
   

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL clearbit


 
 HALF_FAR_CALL setbit


 
 FAR_CALL samplef,setbit

 
 goto hlllb51J4
 

hlllb51J3:


 movlw .0

   
 HALF_FAR_CALL safepush


 
 FAR_CALL samplef,parm


 movlw .4

   
 HALF_FAR_CALL safepush


 
 FAR_CALL samplef,eq

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J1 
 

 movlw .2

   
 FAR_CALL samplef ,safepush


 movlw .3

   
 FAR_CALL samplef ,safepush


 movlw .4

   
 FAR_CALL samplef ,safepush

   banksel ADCON0
   movfw ADCON0
   
   

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL setbit


 
 HALF_FAR_CALL clearbit


 
 FAR_CALL samplef,clearbit

 
 goto hlllb51J2
 

hlllb51J1:


hlllb51J2:


hlllb51J4:


hlllb51J6:


hlllb51J8:


hlllb51J10:

 POP
 banksel ADCON0
 movwf ADCON0
 


 movlw .0

   
 FAR_CALL samplef ,safepush

   banksel ADCON0
   movfw ADCON0
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL samplef,setbit

 POP
 banksel ADCON0
 movwf ADCON0
 


 
 FAR_CALL samplef,dispose


 movlw .1

   
 FAR_CALL samplef ,safepush


 movlw .2

   
 FAR_CALL samplef ,safepush


 movlw .0

   
 FAR_CALL samplef ,safepush


 movlw .7

   
 FAR_CALL samplef ,safepush


 movlw .6

   
 FAR_CALL samplef ,safepush


 movlw .5

   
 FAR_CALL samplef ,safepush


 movlw .4

   
 FAR_CALL samplef ,safepush

   banksel ADCON1
   movfw ADCON1
   
   

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL clearbit


 
 HALF_FAR_CALL setbit


 
 HALF_FAR_CALL setbit


 
 HALF_FAR_CALL setbit


 
 HALF_FAR_CALL clearbit


 
 HALF_FAR_CALL clearbit


 
 FAR_CALL samplef,clearbit

 POP
 banksel ADCON1
 movwf ADCON1
 


 movlw .0

   
 FAR_CALL samplef ,safepush

   banksel ANSELA
   movfw ANSELA
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL samplef,setbit

 POP
 banksel ANSELA
 movwf ANSELA
 


 movlw .1

   
 FAR_CALL samplef ,safepush

   banksel ADCON0
   movfw ADCON0
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL samplef,setbit

 POP
 banksel ADCON0
 movwf ADCON0
 


 
 FAR_CALL samplef,ourwait


 movlw .0
 



   
 FAR_CALL samplef ,safepush


 movlw .8
 


   
 FAR_CALL samplef ,safepush


 movlw .3

   
 FAR_CALL samplef ,safepush

   banksel ADRESH
   movfw ADRESH
   
   

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL andu


 
 HALF_FAR_CALL utof


 
 FAR_CALL samplef,mulf

   banksel ADRESL
   movfw ADRESL
   
   

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL utof


 
 HALF_FAR_CALL addf


 
 FAR_CALL samplef,kpop
 
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
 
 FAR_CALL samplef ,kpush
 

 POP
 
 FAR_CALL samplef ,kpush
 
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

 ; LOAD POINTER

 movwf FSR0L
 

 DISCARD


 
 HALF_FAR_CALL kpop


 
 HALF_FAR_CALL safepush
 

 
 HALF_FAR_CALL kpop


 
 FAR_CALL samplef ,safepush
 

 return
 

hllt4514 CODE
ourwait:


 movlw .2

   
 FAR_CALL ourwait ,safepush

   banksel ADCON0
   movfw ADCON0
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL ourwait,andu

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J12 
 
 ;


 goto ourwait
hlllb51J12:
hlllb51J13:

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
 
 HALF_FAR_CALL printch
 
 FAR_CALL graphx,printu
 movlw ';'
 PUSH
 
 HALF_FAR_CALL printch
 
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
 
 HALF_FAR_CALL printch
 
 FAR_CALL graphx,printu
 movlw ';'
 PUSH
 
 HALF_FAR_CALL printch
 
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
 goto hllEAAAA
 
 movfw margp2
 andlw .255-.1
 goto hllLAAAA
hllEAAAA: 
 
 xorlw .1
 btfss STATUS,Z
 goto hllFAAAA
 
 movfw margp2
 andlw .255-.2
 goto hllLAAAA
hllFAAAA: 
 xorlw .1
 xorlw .2
 btfss STATUS,Z
 goto hllGAAAA
 
 movfw margp2
 andlw .255-.4
 goto hllLAAAA
hllGAAAA: 
 xorlw .2
 xorlw .3
 btfss STATUS,Z
 goto hllHAAAA
 
 movfw margp2
 andlw .255-.8
 goto hllLAAAA
hllHAAAA: 
 xorlw .3
 xorlw .4
 btfss STATUS,Z
 goto hllIAAAA
 
 movfw margp2
 andlw .255-.16
 goto hllLAAAA
hllIAAAA: 
 xorlw .4
 xorlw .5
 btfss STATUS,Z
 goto hllJAAAA
 
 movfw margp2
 andlw .255-.32
 goto hllLAAAA
hllJAAAA: 
 xorlw .5
 xorlw .6
 btfss STATUS,Z
 goto hllKAAAA
 
 movfw margp2
 andlw .255-.64
 goto hllLAAAA
hllKAAAA: 
 
 movfw margp2
 andlw .255-.128
hllLAAAA:  
 PUSH
 return




#undefine margp2






 

 
ansiarb CODE
 
 
cls:
 
 movlw 0x1b
 PUSH
 
 FAR_CALL cls,printch
 movlw '['
 PUSH
 
 FAR_CALL cls,printch
 movlw '2'
 PUSH
 
 FAR_CALL cls,printch
 movlw 'K'
 PUSH
 
 FAR_CALL cls,printch


 movlw 0x1b
 PUSH
 
 FAR_CALL cls,printch
 movlw '['
 PUSH
 
 FAR_CALL cls,printch
 movlw 'J'
 PUSH
 
 FAR_CALL cls,printch
 
 
 
 movlw 0x1b
 PUSH
 
 FAR_CALL cls,printch
 movlw '['
 PUSH
 
 FAR_CALL cls,printch
 movlw '1'
 PUSH
 
 FAR_CALL cls,printch
 movlw 'J'
 PUSH
 
 FAR_CALL cls,printch


 movlw 0x1b
 PUSH
 
 FAR_CALL cls,printch
 movlw '['
 PUSH
 
 FAR_CALL cls,printch
 movlw '2'
 PUSH
 
 FAR_CALL cls,printch
 movlw 'K'
 PUSH
 
 FAR_CALL cls,printch


 movlw 0x1b
 PUSH
 
 FAR_CALL cls,printch
 movlw '['
 PUSH
 
 FAR_CALL cls,printch
 movlw 'J'
 PUSH
 
 FAR_CALL cls,printch
 
 
 
 movlw 0x1b
 PUSH
 
 FAR_CALL cls,printch
 movlw '['
 PUSH
 
 FAR_CALL cls,printch
 movlw '1'
 PUSH
 
 FAR_CALL cls,printch
 movlw 'J'
 PUSH
 
 FAR_CALL cls,printch

 return

 







 



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
 goto hllMAAAA
 
 movfw  margp2
 iorlw .1
 goto hllTAAAA
hllMAAAA: 
 
 xorlw .1
 btfss STATUS,Z
 goto hllNAAAA
 
 movfw  margp2
 iorlw .2
 goto hllTAAAA
hllNAAAA: 
 xorlw .1
 xorlw .2
 btfss STATUS,Z
 goto hllOAAAA
 
 movfw margp2
 iorlw .4
 goto hllTAAAA
hllOAAAA: 
 xorlw .2
 xorlw .3
 btfss STATUS,Z
 goto hllPAAAA
 
 movfw margp2
 iorlw .8
 goto hllTAAAA
hllPAAAA: 
 xorlw .3
 xorlw .4
 btfss STATUS,Z
 goto hllQAAAA
 
 movfw margp2
 iorlw .16
 goto hllTAAAA
hllQAAAA: 
 xorlw .4
 xorlw .5
 btfss STATUS,Z
 goto hllRAAAA
 
 movfw margp2
 iorlw .32
 goto hllTAAAA
hllRAAAA: 
 xorlw .5
 xorlw .6
 btfss STATUS,Z
 goto hllSAAAA
 
 movfw margp2
 iorlw .64
 goto hllTAAAA
hllSAAAA: 
 
 movfw margp2
 iorlw .128 
hllTAAAA:  
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
 


 bcf STATUS,C
 rrf min_lower,f



 bcf STATUS,C
 rrf fulmin,f


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
	
	
    
 bcf STATUS,C
 rlf mout,f
	
	
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

   
 bcf STATUS,C
 rlf min_lower,f 

	
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
	
	
	
	
 bcf STATUS,C
 rlf mout,f

	
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
 
 	
	
    
 bcf STATUS,C
 rlf mout,f 
	
	
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

 
 bcf STATUS,C
 rlf min2_lower,f
 

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
		
	
	
	
 bcf STATUS,C
 rlf mout,f 

	
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
 bcf STATUS,C
 rrf fulmin,f
 btfsc STATUS,C
 bsf big_c,0
	
	
 bcf STATUS,C
 rrf min_lower,f

	
	
 btfss big_c,0
 goto ddnyy
	
	
	
 bsf min_lower,7	
	
ddnyy:

	
	
 clrf big_c
 bcf STATUS,C
 rrf fulmin2,f
 btfsc STATUS,C
 bsf big_c,0
	
	
	
	
 bcf STATUS,C
 rrf min2_lower,f
	
	
	
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
 goto hllWAAAA
 
 btfss ein1,7
 goto hllUAAAA
 
 goto hllYAAAA
hllUAAAA: 
 
 movfw ein1
 subwf ein2,w    
 btfss STATUS,C 
 goto hllXAAAA  
hllVAAAA:
 goto hllYAAAA  
hllWAAAA:   
 
 
 btfsc ein1,7
 goto hllUAAAA  
hllXAAAA:  
 
 


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
 
 
 
 goto hllYAAAA_done 
hllYAAAA: 
 
 
 
 clrf rev 
hllYAAAA_done: 
 
 
 
 
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
 
hllABAAA:


 movfw ein1 
 xorwf ein2,w 
 btfsc STATUS,Z 
 goto hllCBAAA  
 


 bcf STATUS,C
 rrf min_lower,f



 bcf STATUS,C
 rrf fulmin,f


 btfss STATUS,C
 goto hllBBAAA
 

 bsf min_lower,7
hllBBAAA:




 incf ein1,f


 goto hllABAAA
 

hllCBAAA:	

 
 
 
 
 
 btfss rev,0 
 goto hllDBAAA 



 movf fulmin2,w
 xorwf fulmin,f

 movf fulmin,w
 xorwf fulmin2,f

 movf fulmin2,w
 xorwf fulmin,f 
 
 
 movfw min_lower 
 movwf min2_lower 
 
 clrf min_lower
 
 
 
 
 
hllDBAAA: 

 banksel min_lower

 
 

hllEBAAA:	

 btfss neg,0
 goto hllFBAAA
 

 btfss neg,1
 goto hllFBAAA




 bsf minres,0

 goto hllWBAAA

 
 
 
 
hllFBAAA:
 

 btfss neg,0
 goto hllNBAAA 

 
hllGBAAA:

	
	
	
 movfw fulmin 
 subwf fulmin2,w 
 movwf mout 
 
 
 btfsc STATUS,C
 goto hllHBAAA		
		
	
 bsf minres,0	
	
	
 goto hllOBAAA	
	
hllHBAAA:

	
 movf mout,f
 btfsc STATUS,Z
 goto hllCCAAA	
hllIBAAA:

	
 btfsc mout,7	
 goto hllKBAAA   
	
	
    
 bcf STATUS,C
 rlf mout,f
	
	
 btfss min_lower,7	
 goto hllJBAAA   

 
 decf mout,f	

	
 movlw .255
 xorwf mout,w
 btfss STATUS,Z
 goto hllJBAAA	
	
     
 bsf minres,0
 
	 
 goto hllOBAAA
	 

hllJBAAA:

   
 bcf STATUS,C
 rlf min_lower,f 

	
 decf ein1,f	

	
 goto hllIBAAA

hllKBAAA:
	
 btfss min_lower,7	
 goto hllMBAAA   
		
	
 decf mout,f

	
 movlw .255
 xorwf mout,w
 btfss STATUS,Z
 goto hllLBAAA	
		
     
 bsf minres,0	 
	 
	 
 goto hllOBAAA	 
	 
	 
hllLBAAA:
	
 movlw .127
 xorwf mout,w
 btfss STATUS,Z
 goto hllMBAAA	
	
	
	
	
 bcf STATUS,C
 rlf mout,f

	
 decf ein1,f	
	
	
 btfsc min_lower,6
 goto hllMBAAA 
	
	
 incf mout,f	
	
hllMBAAA:
	
 goto hllCCAAA
hllNBAAA:
 

	
 btfss neg,1
 goto hllWBAAA 
 
	
hllOBAAA:

	
 movfw fulmin2
 subwf fulmin,w 
 movwf mout 

 
 btfsc STATUS,C
 goto hllPBAAA		
	
	
	
	
 bsf minres,0
	
	
 goto hllGBAAA	

hllPBAAA:

	
 movf mout,f 
 btfsc STATUS,Z 
 goto hllCCAAA 
	
hllQBAAA:

	
 btfsc mout,7
 goto hllKBAAAb
 
 	
	
    
 bcf STATUS,C
 rlf mout,f 
	
	
 btfss min2_lower,7
 goto hllRBAAA

	
	
 decf mout,f	
	
	
 movlw .255
 xorwf mout,w
 btfss STATUS,Z
 goto hllRBAAA	
	

 bsf minres,0
	

 goto hllGBAAA
	
hllRBAAA:

 
 bcf STATUS,C
 rlf min2_lower,f
 

 decf ein1,f
   
	
 goto hllQBAAA	
hllKBAAAb:

	
 btfss min2_lower,7
 goto hllUBAAA

	
 decf mout,f	
	
	
 movlw .255
 xorwf mout,w
 btfss STATUS,Z
 goto hllTBAAA	
		
	
 bsf minres,0
 
	
 goto hllGBAAA
hllTBAAA:


	
 movlw .127
 xorwf mout,w
 btfss STATUS,Z
 goto hllUBAAA	
		
	
	
	
 bcf STATUS,C
 rlf mout,f 

	
 decf ein1,f	

	
 btfsc min2_lower,6
 goto hllUBAAA 
 
	
	
 incf mout,f	
	
hllUBAAA:

	
 goto hllCCAAA

hllVBAAA:
	 
 movfw fulmin
 subwf fulmin2,w 
 movwf mout 
	 
	 
	 
     
 bsf minres,0	 
	
 goto hllCCAAA

	
hllWBAAA:


 

	
 clrf mout_hi
	
	
	
 movf fulmin,w
 addwf fulmin2,w
 movwf mout
	
	

	
 btfss STATUS,C	
 goto hllXBAAA			
	
	
 incf mout_hi,f	
	
hllXBAAA:



	
 movf min_lower,w
 addwf min2_lower,w
 btfsc STATUS,C
 goto hllYBAAA   
 

	
	
 andlw .128	
 btfss STATUS,Z
 goto hllYBAAA	  
	
	
 goto hllZBAAA	
	
hllYBAAA:


	
 incf mout,f	
	
	
 movf mout,f
 btfss STATUS,Z
 goto hllZBAAA 

	
 incf mout_hi,f

hllZBAAA:
	
 movf mout_hi,f
 btfsc STATUS,Z
 goto hllCCAAA 

	
	
	
	
 clrf big_c
 bcf STATUS,C
 rrf fulmin,f
 btfsc STATUS,C
 bsf big_c,0
	
	
 bcf STATUS,C
 rrf min_lower,f

	
	
 btfss big_c,0
 goto hllACAAA
	
	
	
 bsf min_lower,7	
	
hllACAAA:

	
	
 clrf big_c
 bcf STATUS,C
 rrf fulmin2,f
 btfsc STATUS,C
 bsf big_c,0
	
	
	
	
 bcf STATUS,C
 rrf min2_lower,f
	
	
	
 btfss big_c,0
 goto hllBCAAA

	
	
	
 bsf min_lower,7		
	
hllBCAAA:

	
 incf ein1,f	
	
	
 goto hllWBAAA


hllCCAAA:

 movfw mout 
 
 
 btfss STATUS,Z 
 goto hllDCAAA 
 
 
 
 movlw .0 

 PUSH
 
 
 
 movlw 0x80 
 PUSH
 
 
 
 goto hllECAAA
 
 
 
hllDCAAA: 
 
 
 
 
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
 
hllECAAA:
 
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
 

 bcf STATUS,C
 rlf min2_lower,f



 bcf STATUS,C
 rlf run_total,f


 btfss STATUS,C
 goto que4


 incf min2_lower,f

que4:


 bcf STATUS,C
 rlf min,f 



 bcf STATUS,C
 rlf quotient_lo,f


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

 
 bcf STATUS,C
 rrf term,f

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
 
 

 bcf STATUS,C
 rrf mout,f


 incf mout,f


 goto prpgm

prpg1:


 bcf STATUS,C 
 rrf mout,f

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
 bcf STATUS,C 
 
 
 
 rlf mout,f 
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

hllFCAAA:

 movf loop_count,w
 xorlw .16
 btfsc STATUS,Z
 goto hllKCAAA


 movf min,w
 andlw .128
 movwf a_hi_msb
 

 bcf STATUS,C
 rlf min2_lower,f



 bcf STATUS,C
 rlf run_total,f


 btfss STATUS,C
 goto hllGCAAA


 incf min2_lower,f

hllGCAAA:


 bcf STATUS,C
 rlf min,f 



 bcf STATUS,C
 rlf quotient_lo,f


 btfsc STATUS,C



 incf min,f


 movf a_hi_msb,f
 btfsc STATUS,Z
 goto hllHCAAA


 incf run_total,f


 btfsc STATUS,Z
 incf min2_lower,f

hllHCAAA:


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
 goto hllICAAA



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


 goto hllJCAAA
hllICAAA:


 movlw .1
 iorwf quotient_lo,f
hllJCAAA:



 incf loop_count,f


 goto hllFCAAA

hllKCAAA:


 movf quotient_lo,w
 movwf mout


 clrf multiplier
 btfsc min,0
 bsf multiplier,0

 
 bcf STATUS,C
 rrf term,f

 clrf rounded
 movfw run_total
 subwf term,w    
 btfsc STATUS,C 
 goto hllLCAAA   
 incf mout,f 
 bsf rounded,0 
 
hllLCAAA:
 


 movf multiplier,f
 btfsc STATUS,Z
 goto hllOCAAA
 




 
 btfss mout,0
 goto hllMCAAA

 
 btfsc rounded,0
 goto hllMCAAA
 
 

 bcf STATUS,C
 rrf mout,f


 incf mout,f


 goto hllNCAAA

hllMCAAA:


 bcf STATUS,C 
 rrf mout,f

hllNCAAA:


 bsf mout,7

 goto hllPCAAA
hllOCAAA:
 decf util,f 
hllPCAAA:
 movfw mout 

hllQCAAA: 

  addlw -.128 
  movwf exam 
  btfss exam,7 
  goto hllRCAAA 
  addlw .128    

 
 decf util,f 
 bcf STATUS,C 
 
 
 
 rlf mout,f 
 movfw mout 
 goto hllQCAAA 

hllRCAAA: 


 movwf mout



 
 
 btfsc neg,0
 goto hllSCAAA 
 btfss neg,1
 goto hllUCAAA 
 goto hllTCAAA 
hllSCAAA: 
 btfsc neg,1
 goto hllUCAAA 

hllTCAAA: 

 
 
 
 
 movfw mout 
 iorlw .128 
 movwf mout 
 

hllUCAAA: 
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
 bcf STATUS,C 
 rrf karg1,f
 rrf util,f
shift6:
 bcf STATUS,C 
 rrf karg1,f
 rrf util,f
shift5:
 bcf STATUS,C 
 rrf karg1,f
 rrf util,f
shift4:
 bcf STATUS,C 
 rrf karg1,f
 rrf util,f
shift3:
 bcf STATUS,C 
 rrf karg1,f
 rrf util,f
shift2:
 bcf STATUS,C 
 rrf karg1,f
 rrf util,f
shift1:
 bcf STATUS,C 
 rrf karg1,f
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
 goto hllVCAAA
 POP
 goto hllFDAAA 
hllVCAAA:
 
 POP
 addlw .128
 banksel karg1
 movwf karg1 
 
 movfw karg2
 sublw .7
 
 movwf divisor 

 movlw high hllWCAAA 
 movwf PCLATH 
 movlw low hllWCAAA
 addwf divisor,w 
 btfsc STATUS,C 
 incf PCLATH,f 
 movwf PCL 


hllWCAAA:
 goto hllEDAAA
 goto hllDDAAA
 goto hllCDAAA 
 goto hllBDAAA
 goto hllADAAA
 goto hllZCAAA
 goto hllYCAAA
 goto hllXCAAA
 
hllXCAAA:
 bcf STATUS,C 
 rrf karg1,f
 rrf util,f
hllYCAAA:
 bcf STATUS,C 
 rrf karg1,f
 rrf util,f
hllZCAAA:
 bcf STATUS,C 
 rrf karg1,f
 rrf util,f
hllADAAA:
 bcf STATUS,C 
 rrf karg1,f
 rrf util,f
hllBDAAA:
 bcf STATUS,C 
 rrf karg1,f
 rrf util,f
hllCDAAA:
 bcf STATUS,C 
 rrf karg1,f
 rrf util,f
hllDDAAA:
 bcf STATUS,C 
 rrf karg1,f
 rrf util,f
hllEDAAA:

hllFDAAA:
 banksel karg1
 movfw karg1 
 PUSH
 
 
 return




#undefine util


#undefine divisor


#undefine karg2


#undefine karg1








 
 

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
 
 
 bcf STATUS,C
 rrf factor1,f
 
 
 
 bcf STATUS,C
 rrf hi_byte,f

 
 
 
 
 
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
 goto hllGDAAA
 movlw .127	
 
 andwf HLINDF,w 
 
 btfsc STATUS,Z
 goto hllODAAA
 
hllGDAAA: 

 
 
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
 goto hllHDAAA
 movlw .127

 andwf HLINDF,w 
 btfsc STATUS,Z
 goto hllPDAAA
hllHDAAA:

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
 goto hllRDAAA 

hllIDAAA:

 
 POP


 banksel mout
 movwf mout 

 
 btfss mout,7 
 goto hllJDAAA 

 
 POP

 
 banksel util
 incf util,f 


 
 andlw .128 
 btfss STATUS,Z
 incf mout,f

 goto hllKDAAA 


hllJDAAA: 

 
 
 
 
 

 
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
 


hllKDAAA: 

 
 movfw mout 

 
 addlw -.128 

 
 movwf mout 

 
 btfsc neg,0
 goto hllLDAAA 
 btfss neg,1
 goto hllNDAAA 
 goto hllMDAAA 
hllLDAAA: 
 btfsc neg,1
 goto hllNDAAA 

hllMDAAA: 

 
 movfw mout 

 
 iorlw .128 

 
 movwf mout 


hllNDAAA: 

 
 movfw mout 

 
 PUSH

 
 banksel util
 movfw util 
 PUSH
 
 goto hllQDAAA 

hllODAAA: 

 POP
 POP


hllPDAAA:
 POP

 
 movlw .128
 PUSH
 PUSH

 
 
hllQDAAA:
 
 return
 
 
 
 
hllRDAAA: 

 POP
 banksel factor1
 movwf factor1

 POP
 banksel factor2
 movwf factor2


 
 clrf hi_byte
 
 clrf make_mout
 
 clrf iterator

hllSDAAA:

 
 btfss factor1,0
 goto hllTDAAA

 
 
 movfw factor2
 addwf make_mout,f

 
 btfsc STATUS,C
 incf hi_byte,f


hllTDAAA:
 
 
 bcf STATUS,C
 rrf factor1,f
 
 
 
 bcf STATUS,C
 rrf hi_byte,f

 
 
 
 
 
 rrf make_mout,f


 
 
 
 
 
 
 
 
 
 
 
 
 btfsc STATUS,C
 bsf factor1,7 


 incf iterator,f


 movlw .8
 xorwf iterator,w
 btfss STATUS,Z
 goto hllSDAAA

 
 movfw factor1 
 PUSH

 
 banksel make_mout
 movfw make_mout
 PUSH

 goto hllIDAAA 





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
 goto hllWDAAA 
 
 
 

 bcf arg1,7 
 movfw arg1 
 
 PUSH


 movlw .7
 PUSH
 
 goto hllEEAAA

hllWDAAA: 
 btfss arg1,6
 goto hllXDAAA 


 
 

 
 
 

 banksel arg1
 bcf arg1,6 
 bcf STATUS,C 
 rlf arg1,f
 movfw arg1
 PUSH

 movlw .6
 PUSH
 
 goto hllEEAAA
hllXDAAA: 

 btfss arg1,5
 goto hllYDAAA

 banksel arg1
 bcf arg1,5 
 bcf STATUS,C 
 rlf arg1,f
 rlf arg1,f
 movfw arg1
 PUSH

 movlw .5
 PUSH
 
 goto hllEEAAA
hllYDAAA: 

 btfss arg1,4
 goto hllZDAAA


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
 
 goto hllEEAAA
hllZDAAA: 

 btfss arg1,3
 goto hllAEAAA

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
 
 goto hllEEAAA

hllAEAAA: 

 btfss arg1,2
 goto hllBEAAA


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
 
 goto hllEEAAA

hllBEAAA: 

 btfss arg1,1
 goto hllCEAAA

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

 goto hllEEAAA
hllCEAAA: 
 btfss arg1,0
 goto hllDEAAA
 movlw .0
 PUSH

 movlw .0
 PUSH
 
 goto hllEEAAA
hllDEAAA:
 movlw .0
 PUSH

 movlw -.128
 PUSH
 
hllEEAAA:
 
 return




#undefine arg1

 end
