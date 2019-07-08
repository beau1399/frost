
#include "hloe.inc"


;
; R O B O T
;
; C O N F I G
;


 __config (_EXTRC_OSC_NOCLKOUT& _WDT_OFF  & _MCLRE_OFF & _IESO_OFF & _FCMEN_OFF  & _PWRTE_ON & _BOR_OFF)


hllv2setf UDATA
hllsetfl RES .1

#define setf hllsetfl

hllv2setg UDATA
hllsetgl RES .1

#define setg hllsetgl

hllv2ticked UDATA
hlltickedl RES .1

#define ticked hlltickedl



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
 
 banksel ticked
 movwf ticked
 


 movlw .15
 PUSH 

   banksel setf
   movfw setf
   
   
 PUSH 


 movlw .60
 PUSH 


 movlw .15
 PUSH 


 FAR_CALL ISR,graphx


 movlw .83
 PUSH 


 FAR_CALL ISR,printch


 movlw .15
 PUSH 

   banksel setg
   movfw setg
   
   
 PUSH 


 movlw .60
 PUSH 


 movlw .16
 PUSH 


 FAR_CALL ISR,graphx


 movlw .80
 PUSH 


 FAR_CALL ISR,printch


hllnotisr49:


;
; R O B O T
;
; H E A D E R
;

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
 

 FAR_CALL hlluserprog,main_setup


 movlw TMR1ON

 PUSH 

   banksel T1CON
   movfw T1CON
   
   
 PUSH 


 FAR_CALL hlluserprog,clearbit

 POP
 banksel T1CON
 movwf T1CON
 


 FAR_CALL hlluserprog,wait_button


 movlw .0
 
 banksel TMR1H
 movwf TMR1H
 


 movlw .0
 
 banksel TMR1L
 movwf TMR1L
 


 movlw GIE

 PUSH 

   banksel INTCON
   movfw INTCON
   
   
 PUSH 


 FAR_CALL hlluserprog,setbit

 POP
 banksel INTCON
 movwf INTCON
 


 movlw .0
 
 banksel ticked
 movwf ticked
 


 movlw .8
 
 banksel TMR1H
 movwf TMR1H
 


 movlw TMR1ON

 PUSH 

   banksel T1CON
   movfw T1CON
   
   
 PUSH 


 FAR_CALL hlluserprog,setbit

 POP
 banksel T1CON
 movwf T1CON
 


 movlw .0
 


 PUSH 


 movlw .128
 

 PUSH 


 movlw .0
 


 PUSH 


 movlw .0
 

 PUSH 


 movlw .4
 PUSH 


 FAR_CALL hlluserprog,samplef


 FAR_CALL hlluserprog,addf


 movlw .0
 


 PUSH 


 movlw .128
 

 PUSH 


 movlw .23
 


 PUSH 


 movlw .8
 

 PUSH 


 FAR_CALL hlluserprog,longf

    
hllprogend:
 goto hllprogend
 

hllt450 CODE
ourftou:
 movf FSR,w
 

 FAR_CALL ourftou , kpush


 movlw .1
 PUSH 


 FAR_CALL ourftou,parm


 movlw .0
 PUSH 


 FAR_CALL ourftou,parm


 movlw .112
 


 PUSH 


 movlw .3
 

 PUSH 


 FAR_CALL ourftou,gtf

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J3 
 

 movlw .15
 PUSH 

 
 goto hlllb51J4
 

hlllb51J3:


 movlw .0
 


 PUSH 


 movlw .128
 

 PUSH 


 movlw .1
 PUSH 


 FAR_CALL ourftou,parm


 movlw .0
 PUSH 


 FAR_CALL ourftou,parm


 FAR_CALL ourftou,gtf

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J5 
 

 movlw .0
 PUSH 

 
 goto hlllb51J6
 

hlllb51J5:


 FAR_CALL ourftou,ftou


hlllb51J6:


hlllb51J4:


 FAR_CALL ourftou,kpop
 
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
 FAR_CALL ourftou , kpush
 
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


 FAR_CALL ourftou , kpop

 PUSH 


 return
 

hllt455 CODE
longf:
 movf FSR,w
 

 FAR_CALL longf , kpush


 movlw .249
 


 PUSH 


 movlw .7
 

 PUSH 


 movlw .1
 PUSH 


 FAR_CALL longf,parm


 movlw .0
 PUSH 


 FAR_CALL longf,parm


 FAR_CALL longf,addf


 movlw .26
 


 PUSH 


 movlw .252
 

 PUSH 


 FAR_CALL longf,mulf


 FAR_CALL longf,ourftou

 POP
 banksel setf
 movwf setf
 


 movlw .249
 


 PUSH 


 movlw .7
 

 PUSH 


 movlw .5
 PUSH 


 FAR_CALL longf,parm


 movlw .4
 PUSH 


 FAR_CALL longf,parm


 FAR_CALL longf,addf


 movlw .26
 


 PUSH 


 movlw .252
 

 PUSH 


 FAR_CALL longf,mulf


 FAR_CALL longf,ourftou

 POP
 banksel setg
 movwf setg
 


 movlw .0
 


 PUSH 


 movlw .0
 

 PUSH 


 movlw .4
 PUSH 


 FAR_CALL longf,samplef


 FAR_CALL longf,addf


 FAR_CALL longf,control


 movlw .0
 PUSH 


 FAR_CALL longf,samplef


 FAR_CALL longf,adjust

 ;
 KDISCARD 
 goto longf

 

hllt456 CODE
adjust:
 movf FSR,w
 

 FAR_CALL adjust , kpush


 movlw .1
 PUSH 


 FAR_CALL adjust,parm


 movlw .0
 PUSH 


 FAR_CALL adjust,parm


 movlw .15
 


 PUSH 


 movlw .9
 

 PUSH 


 FAR_CALL adjust,gtf


 movlw .90
 


 PUSH 


 movlw .8
 

 PUSH 


 movlw .3
 PUSH 


 FAR_CALL adjust,parm


 movlw .2
 PUSH 


 FAR_CALL adjust,parm


 FAR_CALL adjust,gtf


 FAR_CALL adjust,andb

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J9 
 

 movlw .0
 


 PUSH 


 movlw .0
 

 PUSH 


 movlw .3
 PUSH 


 FAR_CALL adjust,parm


 movlw .2
 PUSH 


 FAR_CALL adjust,parm


 FAR_CALL adjust,addf

 
 goto hlllb51J10
 

hlllb51J9:


 movlw .92
 


 PUSH 


 movlw .6
 

 PUSH 


 movlw .1
 PUSH 


 FAR_CALL adjust,parm


 movlw .0
 PUSH 


 FAR_CALL adjust,parm


 FAR_CALL adjust,gtf


 movlw .3
 PUSH 


 FAR_CALL adjust,parm


 movlw .2
 PUSH 


 FAR_CALL adjust,parm


 movlw .122
 


 PUSH 


 movlw .7
 

 PUSH 


 FAR_CALL adjust,gtf


 FAR_CALL adjust,andb

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J11 
 

 movlw .128
 


 PUSH 


 movlw .0
 

 PUSH 


 movlw .3
 PUSH 


 FAR_CALL adjust,parm


 movlw .2
 PUSH 


 FAR_CALL adjust,parm


 FAR_CALL adjust,addf

 
 goto hlllb51J12
 

hlllb51J11:


 movlw .3
 PUSH 


 FAR_CALL adjust,parm


 movlw .2
 PUSH 


 FAR_CALL adjust,parm


hlllb51J12:


hlllb51J10:


 FAR_CALL adjust,kpop
 
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
 FAR_CALL adjust , kpush
 

 POP
 FAR_CALL adjust , kpush
 
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


 DISCARD


 DISCARD


 FAR_CALL adjust , kpop

 PUSH 


 FAR_CALL adjust , kpop

 PUSH 


 return
 

hllt4511 CODE
usrpwm:
 movf FSR,w
 

 FAR_CALL usrpwm , kpush


 movlw .68
 


 PUSH 


 movlw .5
 

 PUSH 


 movlw .1
 PUSH 


 FAR_CALL usrpwm,parm


 movlw .0
 PUSH 


 FAR_CALL usrpwm,parm


 FAR_CALL usrpwm,mulf


 movlw .32
 


 PUSH 


 movlw .252
 

 PUSH 


 movlw .3
 PUSH 


 FAR_CALL usrpwm,parm


 movlw .2
 PUSH 


 FAR_CALL usrpwm,parm


 FAR_CALL usrpwm,mulf


 movlw .122
 


 PUSH 


 movlw .11
 

 PUSH 


 movlw .5
 PUSH 


 FAR_CALL usrpwm,parm


 movlw .4
 PUSH 


 FAR_CALL usrpwm,parm


 FAR_CALL usrpwm,mulf


 FAR_CALL usrpwm,addf


 FAR_CALL usrpwm,addf


 FAR_CALL usrpwm,copyf


 FAR_CALL usrpwm,copyf


 movlw .0
 


 PUSH 


 movlw .128
 

 PUSH 


 FAR_CALL usrpwm,gtf

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J14 
 

 movlw .0
 


 PUSH 


 movlw .10
 

 PUSH 


 FAR_CALL usrpwm,gtf

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J16 
 

 movlw .0
 


 PUSH 


 movlw .10
 

 PUSH 


 movlw .1
 PUSH 


 FAR_CALL usrpwm,pwmf

 
 goto hlllb51J17
 

hlllb51J16:


 movlw .1
 PUSH 


 FAR_CALL usrpwm,pwmf


hlllb51J17:

 
 goto hlllb51J15
 

hlllb51J14:


 movlw .128
 


 PUSH 


 movlw .10
 

 PUSH 


 FAR_CALL usrpwm,gtf

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J18 
 

 movlw .128
 


 PUSH 


 movlw .0
 

 PUSH 


 FAR_CALL usrpwm,mulf


 movlw .0
 PUSH 


 FAR_CALL usrpwm,pwmf

 
 goto hlllb51J19
 

hlllb51J18:


 movlw .0
 


 PUSH 


 movlw .10
 

 PUSH 


 movlw .0
 PUSH 


 FAR_CALL usrpwm,pwmf


hlllb51J19:


hlllb51J15:


 FAR_CALL usrpwm,kpop

;LOAD POINTER
 movwf FSR
 

 DISCARD


 DISCARD


 DISCARD


 DISCARD


 DISCARD


 DISCARD


 return
 

hllt4518 CODE
conform_i:
 movf FSR,w
 

 FAR_CALL conform_i , kpush


 movlw .1
 PUSH 


 FAR_CALL conform_i,parm


 movlw .0
 PUSH 


 FAR_CALL conform_i,parm


 movlw .0
 


 PUSH 


 movlw .128
 

 PUSH 


 FAR_CALL conform_i,gtf

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J21 
 

 movlw .1
 PUSH 


 FAR_CALL conform_i,parm


 movlw .0
 PUSH 


 FAR_CALL conform_i,parm


 movlw .122
 


 PUSH 


 movlw .11
 

 PUSH 


 FAR_CALL conform_i,gtf

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J23 
 

 movlw .122
 


 PUSH 


 movlw .11
 

 PUSH 

 
 goto hlllb51J24
 

hlllb51J23:


hlllb51J24:

 
 goto hlllb51J22
 

hlllb51J21:


 movlw .250
 


 PUSH 


 movlw .11
 

 PUSH 


 movlw .1
 PUSH 


 FAR_CALL conform_i,parm


 movlw .0
 PUSH 


 FAR_CALL conform_i,parm


 FAR_CALL conform_i,gtf

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J25 
 

 movlw .250
 


 PUSH 


 movlw .11
 

 PUSH 

 
 goto hlllb51J26
 

hlllb51J25:


hlllb51J26:


hlllb51J22:


 FAR_CALL conform_i,kpop
 
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
 FAR_CALL conform_i , kpush
 

 POP
 FAR_CALL conform_i , kpush
 
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


 FAR_CALL conform_i , kpop

 PUSH 


 FAR_CALL conform_i , kpop

 PUSH 


 return
 

hllt4525 CODE
control:
 movf FSR,w
 

 FAR_CALL control , kpush

   banksel TMR1H
   movfw TMR1H
   
   
 PUSH 


 FAR_CALL control,utof


 movlw -.1
 PUSH 


 FAR_CALL control,parm


 movlw -.2
 PUSH 


 FAR_CALL control,parm


 movlw .128
 


 PUSH 


 movlw .0
 

 PUSH 


 movlw .9
 PUSH 


 FAR_CALL control,parm


 movlw .8
 PUSH 


 FAR_CALL control,parm


 FAR_CALL control,mulf


 FAR_CALL control,addf

   banksel ticked
   movfw ticked
   
   
 
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J28 
 

 movlw .1
 PUSH 


 movlw .0
 
 banksel ticked
 movwf ticked
 

 
 goto hlllb51J29
 

hlllb51J28:


 movlw .0
 PUSH 


hlllb51J29:


 movlw -.5
 PUSH 


 FAR_CALL control,parm

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J30 
 

 movlw .8
 


 PUSH 


 movlw .4
 

 PUSH 

 
 goto hlllb51J31
 

hlllb51J30:


 movlw -.3
 PUSH 


 FAR_CALL control,parm


 movlw -.4
 PUSH 


 FAR_CALL control,parm


hlllb51J31:


 movlw -.5
 PUSH 


 FAR_CALL control,parm

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J32 
 

 movlw .0
 


 PUSH 


 movlw .0
 

 PUSH 


 movlw .4
 PUSH 


 FAR_CALL control,samplef


 FAR_CALL control,addf

 
 goto hlllb51J33
 

hlllb51J32:


 movlw .1
 PUSH 


 FAR_CALL control,parm


 movlw .0
 PUSH 


 FAR_CALL control,parm


hlllb51J33:


 movlw .7
 PUSH 


 FAR_CALL control,parm


 movlw .6
 PUSH 


 FAR_CALL control,parm


 movlw .128
 


 PUSH 


 movlw .0
 

 PUSH 


 movlw -.8
 PUSH 


 FAR_CALL control,parm


 movlw -.9
 PUSH 


 FAR_CALL control,parm


 FAR_CALL control,mulf


 FAR_CALL control,addf


 movlw .3
 PUSH 


 FAR_CALL control,parm


 movlw .2
 PUSH 


 FAR_CALL control,parm


 movlw .128
 


 PUSH 


 movlw .0
 

 PUSH 


 movlw -.8
 PUSH 


 FAR_CALL control,parm


 movlw -.9
 PUSH 


 FAR_CALL control,parm


 FAR_CALL control,mulf


 FAR_CALL control,addf


 movlw .5
 PUSH 


 FAR_CALL control,parm


 movlw .4
 PUSH 


 FAR_CALL control,parm


 movlw -.12
 PUSH 


 FAR_CALL control,parm


 movlw -.13
 PUSH 


 FAR_CALL control,parm


 movlw -.6
 PUSH 


 FAR_CALL control,parm


 movlw -.7
 PUSH 


 FAR_CALL control,parm


 FAR_CALL control,mulf


 FAR_CALL control,addf


 FAR_CALL control,conform_i


 movlw -.10
 PUSH 


 FAR_CALL control,parm


 movlw -.11
 PUSH 


 FAR_CALL control,parm


 FAR_CALL control,iszerof

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J34 
 

 movlw .0
 


 PUSH 


 movlw .128
 

 PUSH 

 
 goto hlllb51J35
 

hlllb51J34:


 movlw -.10
 PUSH 


 FAR_CALL control,parm


 movlw -.11
 PUSH 


 FAR_CALL control,parm


 movlw -.6
 PUSH 


 FAR_CALL control,parm


 movlw -.7
 PUSH 


 FAR_CALL control,parm


 FAR_CALL control,divf


hlllb51J35:


 movlw -.14
 PUSH 


 FAR_CALL control,parm


 movlw -.15
 PUSH 


 FAR_CALL control,parm


 movlw -.12
 PUSH 


 FAR_CALL control,parm


 movlw -.13
 PUSH 


 FAR_CALL control,parm


 FAR_CALL control,usrpwm


 movlw -.5
 PUSH 


 FAR_CALL control,parm

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J36 
 

 movlw .96
 


 PUSH 


 movlw .3
 

 PUSH 

 
 goto hlllb51J37
 

hlllb51J36:


 movlw -.1
 PUSH 


 FAR_CALL control,parm


 movlw -.2
 PUSH 


 FAR_CALL control,parm


hlllb51J37:


 movlw -.8
 PUSH 


 FAR_CALL control,parm


 movlw -.9
 PUSH 


 FAR_CALL control,parm


 movlw -.14
 PUSH 


 FAR_CALL control,parm


 movlw -.15
 PUSH 


 FAR_CALL control,parm


 movlw .3
 PUSH 


 FAR_CALL control,parm


 movlw .2
 PUSH 


 FAR_CALL control,parm


 FAR_CALL control,kpop
 
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
 FAR_CALL control , kpush
 

 POP
 FAR_CALL control , kpush
 

 POP
 FAR_CALL control , kpush
 

 POP
 FAR_CALL control , kpush
 

 POP
 FAR_CALL control , kpush
 

 POP
 FAR_CALL control , kpush
 

 POP
 FAR_CALL control , kpush
 

 POP
 FAR_CALL control , kpush
 
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


 DISCARD


 DISCARD


 DISCARD


 DISCARD


 DISCARD


 DISCARD


 DISCARD


 DISCARD


 FAR_CALL control , kpop

 PUSH 


 FAR_CALL control , kpop

 PUSH 


 FAR_CALL control , kpop

 PUSH 


 FAR_CALL control , kpop

 PUSH 


 FAR_CALL control , kpop

 PUSH 


 FAR_CALL control , kpop

 PUSH 


 FAR_CALL control , kpop

 PUSH 


 FAR_CALL control , kpop

 PUSH 


 return
 

hllt4536 CODE
wait_button:

   banksel PORTA
   movfw PORTA
   
   
 PUSH 


 movlw .16
 PUSH 


 FAR_CALL wait_button,andu

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J39 
 
 ;


 goto wait_button
hlllb51J39:
hlllb51J40:

 

hllt4539 CODE
main_setup:


 movlw .0
 
 banksel setf
 movwf setf
 


 movlw .0
 
 banksel setg
 movwf setg
 


 movlw .0
 
 banksel INTCON
 movwf INTCON
 


 movlw .0
 
 banksel ANSELH
 movwf ANSELH
 


 movlw .0
 
 banksel ANSEL
 movwf ANSEL
 


 FAR_CALL main_setup,pwmon


 movlw SYNC

 PUSH 


 movlw BRGH

 PUSH 

   banksel TXSTA
   movfw TXSTA
   
   
 PUSH 


 FAR_CALL main_setup,setbit


 FAR_CALL main_setup,clearbit

 POP
 banksel TXSTA
 movwf TXSTA
 


 movlw BRG16

 PUSH 


 movlw SCKP

 PUSH 

   banksel BAUDCTL
   movfw BAUDCTL
   
   
 PUSH 


 FAR_CALL main_setup,setbit


 FAR_CALL main_setup,setbit

 POP
 banksel BAUDCTL
 movwf BAUDCTL
 


 movlw CREN

 PUSH 

   banksel RCSTA
   movfw RCSTA
   
   
 PUSH 


 FAR_CALL main_setup,clearbit

 POP
 banksel RCSTA
 movwf RCSTA
 


 movlw CREN

 PUSH 

   banksel RCSTA
   movfw RCSTA
   
   
 PUSH 


 FAR_CALL main_setup,setbit

 POP
 banksel RCSTA
 movwf RCSTA
 


 movlw .25
 
 banksel SPBRG
 movwf SPBRG
 


 movlw .0
 
 banksel SPBRGH
 movwf SPBRGH
 


 movlw TXEN

 PUSH 


 movlw TX9

 PUSH 

   banksel TXSTA
   movfw TXSTA
   
   
 PUSH 


 FAR_CALL main_setup,clearbit


 FAR_CALL main_setup,setbit

 POP
 banksel TXSTA
 movwf TXSTA
 


 movlw SPEN

 PUSH 

   banksel RCSTA
   movfw RCSTA
   
   
 PUSH 


 FAR_CALL main_setup,setbit

 POP
 banksel RCSTA
 movwf RCSTA
 


 movlw TMR1CS

 PUSH 


 movlw TMR1GE

 PUSH 


 movlw T1CKPS1

 PUSH 


 movlw T1CKPS0

 PUSH 


 movlw NOT_T1SYNC

 PUSH 


 movlw T1OSCEN

 PUSH 

   banksel T1CON
   movfw T1CON
   
   
 PUSH 


 FAR_CALL main_setup,clearbit


 FAR_CALL main_setup,clearbit


 FAR_CALL main_setup,setbit


 FAR_CALL main_setup,setbit


 FAR_CALL main_setup,clearbit


 FAR_CALL main_setup,clearbit

 POP
 banksel T1CON
 movwf T1CON
 


 movlw TMR1IE

 PUSH 

   banksel PIE1
   movfw PIE1
   
   
 PUSH 


 FAR_CALL main_setup,setbit

 POP
 banksel PIE1
 movwf PIE1
 


 movlw PEIE

 PUSH 

   banksel INTCON
   movfw INTCON
   
   
 PUSH 


 FAR_CALL main_setup,setbit

 POP
 banksel INTCON
 movwf INTCON
 


 return
 

hllt4540 CODE
samplef:
 movf FSR,w
 

 FAR_CALL samplef , kpush


 movlw .6
 PUSH 


 movlw .5
 PUSH 


 movlw .4
 PUSH 

   banksel ADCON1
   movfw ADCON1
   
   
 PUSH 


 FAR_CALL samplef,setbit


 FAR_CALL samplef,clearbit


 FAR_CALL samplef,setbit

 POP
 banksel ADCON1
 movwf ADCON1
 


 movlw .0
 PUSH 


 FAR_CALL samplef,parm


 movlw .0
 PUSH 


 FAR_CALL samplef,eq

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J43 
 

 movlw .2
 PUSH 


 movlw .3
 PUSH 


 movlw .4
 PUSH 

   banksel ADCON0
   movfw ADCON0
   
   
 PUSH 


 FAR_CALL samplef,clearbit


 FAR_CALL samplef,clearbit


 FAR_CALL samplef,clearbit

 
 goto hlllb51J44
 

hlllb51J43:


 movlw .2
 PUSH 


 movlw .3
 PUSH 


 movlw .4
 PUSH 

   banksel ADCON0
   movfw ADCON0
   
   
 PUSH 


 FAR_CALL samplef,setbit


 FAR_CALL samplef,clearbit


 FAR_CALL samplef,clearbit


hlllb51J44:

 POP
 banksel ADCON0
 movwf ADCON0
 


 FAR_CALL samplef,dispose


 movlw .1
 PUSH 


 movlw .7
 PUSH 


 movlw .0
 PUSH 

   banksel ADCON0
   movfw ADCON0
   
   
 PUSH 


 FAR_CALL samplef,setbit


 FAR_CALL samplef,setbit


 FAR_CALL samplef,clearbit

 POP
 banksel ADCON0
 movwf ADCON0
 


 movlw .0
 PUSH 

   banksel ANSEL
   movfw ANSEL
   
   
 PUSH 


 FAR_CALL samplef,setbit

 POP
 banksel ANSEL
 movwf ANSEL
 


 movlw .1
 PUSH 

   banksel ADCON0
   movfw ADCON0
   
   
 PUSH 


 FAR_CALL samplef,setbit

 POP
 banksel ADCON0
 movwf ADCON0
 


 FAR_CALL samplef,ourwait


 movlw .0
 


 PUSH 


 movlw .8
 

 PUSH 


 movlw .3
 PUSH 

   banksel ADRESH
   movfw ADRESH
   
   
 PUSH 


 FAR_CALL samplef,andu


 FAR_CALL samplef,utof


 FAR_CALL samplef,mulf

   banksel ADRESL
   movfw ADRESL
   
   
 PUSH 


 FAR_CALL samplef,utof


 FAR_CALL samplef,addf


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
 FAR_CALL samplef , kpush
 

 POP
 FAR_CALL samplef , kpush
 
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


 FAR_CALL samplef , kpop

 PUSH 


 FAR_CALL samplef , kpop

 PUSH 


 return
 

hllt4543 CODE
ourwait:


 movlw .2
 PUSH 

   banksel ADCON0
   movfw ADCON0
   
   
 PUSH 


 FAR_CALL ourwait,andu

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J46 
 
 ;


 goto ourwait
hlllb51J46:
hlllb51J47:

 

hllt4546 CODE
pwmon:


 movlw .255
 
 banksel PR2
 movwf PR2
 


 movlw .2
 PUSH 


 movlw .3
 PUSH 


 movlw .0
 PUSH 


 FAR_CALL pwmon,setbit


 FAR_CALL pwmon,setbit

 POP
 banksel CCP1CON
 movwf CCP1CON
 


 movlw .0
 
 banksel CCPR1L
 movwf CCPR1L
 


 movlw .1
 PUSH 

   banksel PIR1
   movfw PIR1
   
   
 PUSH 


 FAR_CALL pwmon,clearbit

 POP
 banksel PIR1
 movwf PIR1
 


 movlw .0
 PUSH 


 movlw .1
 PUSH 

   banksel T2CON
   movfw T2CON
   
   
 PUSH 


 FAR_CALL pwmon,clearbit


 FAR_CALL pwmon,clearbit

 POP
 banksel T2CON
 movwf T2CON
 


 movlw .2
 PUSH 

   banksel T2CON
   movfw T2CON
   
   
 PUSH 


 FAR_CALL pwmon,setbit

 POP
 banksel T2CON
 movwf T2CON
 


 movlw .1
 PUSH 

   banksel PIR1
   movfw PIR1
   
   
 PUSH 


 FAR_CALL pwmon,clearbit

 POP
 banksel PIR1
 movwf PIR1
 


 FAR_CALL pwmon,pwmin


 movlw .5
 PUSH 


 movlw .4
 PUSH 

   banksel TRISC
   movfw TRISC
   
   
 PUSH 


 FAR_CALL pwmon,clearbit


 FAR_CALL pwmon,clearbit

 POP
 banksel TRISC
 movwf TRISC
 


 movlw .0
 
 banksel PORTC
 movwf PORTC
 


 return
 

hllt4547 CODE
pwmf:
 movf FSR,w
 

 FAR_CALL pwmf , kpush


 movlw .0
 PUSH 


 FAR_CALL pwmf,parm

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J50 
 

 movlw .0
 PUSH 


 movlw .1
 PUSH 

   banksel PSTRCON
   movfw PSTRCON
   
   
 PUSH 


 FAR_CALL pwmf,clearbit


 FAR_CALL pwmf,setbit

 POP
 banksel PSTRCON
 movwf PSTRCON
 

 
 goto hlllb51J51
 

hlllb51J50:


 movlw .1
 PUSH 


 movlw .0
 PUSH 

   banksel PSTRCON
   movfw PSTRCON
   
   
 PUSH 


 FAR_CALL pwmf,clearbit


 FAR_CALL pwmf,setbit

 POP
 banksel PSTRCON
 movwf PSTRCON
 


hlllb51J51:


 movlw .2
 PUSH 


 FAR_CALL pwmf,parm


 movlw .1
 PUSH 


 FAR_CALL pwmf,parm


 FAR_CALL pwmf,iszerof

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J52 
 

 movlw .0
 PUSH 

 
 goto hlllb51J53
 

hlllb51J52:


 movlw .2
 PUSH 


 FAR_CALL pwmf,parm


 movlw .1
 PUSH 


 FAR_CALL pwmf,parm


 movlw .122
 


 PUSH 


 movlw .9
 

 PUSH 


 FAR_CALL pwmf,gtf

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J54 
 

 movlw .255
 PUSH 

 
 goto hlllb51J55
 

hlllb51J54:


 movlw .2
 PUSH 


 FAR_CALL pwmf,parm


 movlw .1
 PUSH 


 FAR_CALL pwmf,parm


 movlw .0
 


 PUSH 


 movlw .2
 

 PUSH 


 FAR_CALL pwmf,divf


 FAR_CALL pwmf,ftou


hlllb51J55:


hlllb51J53:

 POP
 banksel CCPR1L
 movwf CCPR1L
 


 movlw .2
 PUSH 


 FAR_CALL pwmf,parm


 movlw .1
 PUSH 


 FAR_CALL pwmf,parm


 movlw .128
 


 PUSH 


 movlw .0
 

 PUSH 


 movlw .0
 


 PUSH 


 movlw .2
 

 PUSH 

   banksel CCPR1L
   movfw CCPR1L
   
   
 PUSH 


 FAR_CALL pwmf,utof


 FAR_CALL pwmf,mulf


 FAR_CALL pwmf,mulf


 FAR_CALL pwmf,addf


 FAR_CALL pwmf,copyf


 movlw .32
 


 PUSH 


 movlw .1
 

 PUSH 


 FAR_CALL pwmf,gtf

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J56 
 

 movlw DC1B1

 PUSH 


 movlw DC1B0

 PUSH 

   banksel CCP1CON
   movfw CCP1CON
   
   
 PUSH 


 FAR_CALL pwmf,setbit


 FAR_CALL pwmf,setbit

 POP
 banksel CCP1CON
 movwf CCP1CON
 

 
 goto hlllb51J57
 

hlllb51J56:


 FAR_CALL pwmf,copyf


 movlw .64
 


 PUSH 


 movlw .0
 

 PUSH 


 FAR_CALL pwmf,gtf

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J58 
 

 movlw DC1B1

 PUSH 

   banksel CCP1CON
   movfw CCP1CON
   
   
 PUSH 


 FAR_CALL pwmf,setbit

 POP
 banksel CCP1CON
 movwf CCP1CON
 

 
 goto hlllb51J59
 

hlllb51J58:


 FAR_CALL pwmf,copyf


 movlw .0
 


 PUSH 


 movlw .255
 

 PUSH 


 FAR_CALL pwmf,gtf

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J60 
 

 movlw DC1B0

 PUSH 

   banksel CCP1CON
   movfw CCP1CON
   
   
 PUSH 


 FAR_CALL pwmf,setbit

 POP
 banksel CCP1CON
 movwf CCP1CON
 

 
 goto hlllb51J61
 

hlllb51J60:


hlllb51J61:


hlllb51J59:


hlllb51J57:


 FAR_CALL pwmf,kpop

;LOAD POINTER
 movwf FSR
 

 DISCARD


 DISCARD


 DISCARD


 return
 

hllt4560 CODE
pwmin:

   banksel PIR1
   movfw PIR1
   
   
 PUSH 


 movlw .2
 PUSH 


 FAR_CALL pwmin,andu

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J63 
 
 
 goto hlllb51J64
 

hlllb51J63:

 ;

 goto pwmin
hlllb51J64:

 
hllprgen2:
 goto hllprgen2
 





 


 
hlog1g CODE
 
andb: 
 pagesel mul
 goto mul

 





 

 
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
 goto hllLAAAA
 
 movfw margp2
 andlw .255-.1
 goto hllSAAAA
hllLAAAA: 
 
 xorlw .1
 btfss STATUS,Z
 goto hllMAAAA
 
 movfw margp2
 andlw .255-.2
 goto hllSAAAA
hllMAAAA: 
 xorlw .1
 xorlw .2
 btfss STATUS,Z
 goto hllNAAAA
 
 movfw margp2
 andlw .255-.4
 goto hllSAAAA
hllNAAAA: 
 xorlw .2
 xorlw .3
 btfss STATUS,Z
 goto hllOAAAA
 
 movfw margp2
 andlw .255-.8
 goto hllSAAAA
hllOAAAA: 
 xorlw .3
 xorlw .4
 btfss STATUS,Z
 goto hllPAAAA
 
 movfw margp2
 andlw .255-.16
 goto hllSAAAA
hllPAAAA: 
 xorlw .4
 xorlw .5
 btfss STATUS,Z
 goto hllQAAAA
 
 movfw margp2
 andlw .255-.32
 goto hllSAAAA
hllQAAAA: 
 xorlw .5
 xorlw .6
 btfss STATUS,Z
 goto hllRAAAA
 
 movfw margp2
 andlw .255-.64
 goto hllSAAAA
hllRAAAA: 
 
 movfw margp2
 andlw .255-.128
hllSAAAA:  
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
 goto hllTAAAA
 
 movfw  margp2
 iorlw .1
 goto hllABAAA
hllTAAAA: 
 
 xorlw .1
 btfss STATUS,Z
 goto hllUAAAA
 
 movfw  margp2
 iorlw .2
 goto hllABAAA
hllUAAAA: 
 xorlw .1
 xorlw .2
 btfss STATUS,Z
 goto hllVAAAA
 
 movfw margp2
 iorlw .4
 goto hllABAAA
hllVAAAA: 
 xorlw .2
 xorlw .3
 btfss STATUS,Z
 goto hllWAAAA
 
 movfw margp2
 iorlw .8
 goto hllABAAA
hllWAAAA: 
 xorlw .3
 xorlw .4
 btfss STATUS,Z
 goto hllXAAAA
 
 movfw margp2
 iorlw .16
 goto hllABAAA
hllXAAAA: 
 xorlw .4
 xorlw .5
 btfss STATUS,Z
 goto hllYAAAA
 
 movfw margp2
 iorlw .32
 goto hllABAAA
hllYAAAA: 
 xorlw .5
 xorlw .6
 btfss STATUS,Z
 goto hllZAAAA
 
 movfw margp2
 iorlw .64
 goto hllABAAA
hllZAAAA: 
 
 movfw margp2
 iorlw .128 
hllABAAA:  
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
 goto hllDBAAA
 
 btfss ein1,7
 goto hllBBAAA
 
 goto hllFBAAA
hllBBAAA: 
 
 movfw ein1
 subwf ein2,w    
 btfss STATUS,C 
 goto hllEBAAA  
hllCBAAA:
 goto hllFBAAA  
hllDBAAA:   
 
 
 btfsc ein1,7
 goto hllBBAAA  
hllEBAAA:  
 
 


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
 
 
 
 goto hllFBAAA_done 
hllFBAAA: 
 
 
 
 clrf rev 
hllFBAAA_done: 
 
 
 
 
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
 
hllHBAAA:


 movfw ein1 
 xorwf ein2,w 
 btfsc STATUS,Z 
 goto hllJBAAA  
 


 bcf STATUS,C
 rrf min_lower,f



 bcf STATUS,C
 rrf fulmin,f


 btfss STATUS,C
 goto hllIBAAA
 

 bsf min_lower,7
hllIBAAA:




 incf ein1,f


 goto hllHBAAA
 

hllJBAAA:	

 
 
 
 
 
 btfss rev,0 
 goto hllKBAAA 



 movf fulmin2,w
 xorwf fulmin,f

 movf fulmin,w
 xorwf fulmin2,f

 movf fulmin2,w
 xorwf fulmin,f 
 
 
 movfw min_lower 
 movwf min2_lower 
 
 clrf min_lower
 
 
 
 
 
hllKBAAA: 

 banksel min_lower

 
 

hllLBAAA:	

 btfss neg,0
 goto hllMBAAA
 

 btfss neg,1
 goto hllMBAAA




 bsf minres,0

 goto hllDCAAA

 
 
 
 
hllMBAAA:
 

 btfss neg,0
 goto hllUBAAA 

 
hllNBAAA:

	
	
	
 movfw fulmin 
 subwf fulmin2,w 
 movwf mout 
 
 
 btfsc STATUS,C
 goto hllOBAAA		
		
	
 bsf minres,0	
	
	
 goto hllVBAAA	
	
hllOBAAA:

	
 movf mout,f
 btfsc STATUS,Z
 goto hllJCAAA	
hllPBAAA:

	
 btfsc mout,7	
 goto hllRBAAA   
	
	
    
 bcf STATUS,C
 rlf mout,f
	
	
 btfss min_lower,7	
 goto hllQBAAA   

 
 decf mout,f	

	
 movlw .255
 xorwf mout,w
 btfss STATUS,Z
 goto hllQBAAA	
	
     
 bsf minres,0
 
	 
 goto hllVBAAA
	 

hllQBAAA:

   
 bcf STATUS,C
 rlf min_lower,f 

	
 decf ein1,f	

	
 goto hllPBAAA

hllRBAAA:
	
 btfss min_lower,7	
 goto hllTBAAA   
		
	
 decf mout,f

	
 movlw .255
 xorwf mout,w
 btfss STATUS,Z
 goto hllSBAAA	
		
     
 bsf minres,0	 
	 
	 
 goto hllVBAAA	 
	 
	 
hllSBAAA:
	
 movlw .127
 xorwf mout,w
 btfss STATUS,Z
 goto hllTBAAA	
	
	
	
	
 bcf STATUS,C
 rlf mout,f

	
 decf ein1,f	
	
	
 btfsc min_lower,6
 goto hllTBAAA 
	
	
 incf mout,f	
	
hllTBAAA:
	
 goto hllJCAAA
hllUBAAA:
 

	
 btfss neg,1
 goto hllDCAAA 
 
	
hllVBAAA:

	
 movfw fulmin2
 subwf fulmin,w 
 movwf mout 

 
 btfsc STATUS,C
 goto hllWBAAA		
	
	
	
	
 bsf minres,0
	
	
 goto hllNBAAA	

hllWBAAA:

	
 movf mout,f 
 btfsc STATUS,Z 
 goto hllJCAAA 
	
hllXBAAA:

	
 btfsc mout,7
 goto hllRBAAAb
 
 	
	
    
 bcf STATUS,C
 rlf mout,f 
	
	
 btfss min2_lower,7
 goto hllYBAAA

	
	
 decf mout,f	
	
	
 movlw .255
 xorwf mout,w
 btfss STATUS,Z
 goto hllYBAAA	
	

 bsf minres,0
	

 goto hllNBAAA
	
hllYBAAA:

 
 bcf STATUS,C
 rlf min2_lower,f
 

 decf ein1,f
   
	
 goto hllXBAAA	
hllRBAAAb:

	
 btfss min2_lower,7
 goto hllBCAAA

	
 decf mout,f	
	
	
 movlw .255
 xorwf mout,w
 btfss STATUS,Z
 goto hllACAAA	
		
	
 bsf minres,0
 
	
 goto hllNBAAA
hllACAAA:


	
 movlw .127
 xorwf mout,w
 btfss STATUS,Z
 goto hllBCAAA	
		
	
	
	
 bcf STATUS,C
 rlf mout,f 

	
 decf ein1,f	

	
 btfsc min2_lower,6
 goto hllBCAAA 
 
	
	
 incf mout,f	
	
hllBCAAA:

	
 goto hllJCAAA

hllCCAAA:
	 
 movfw fulmin
 subwf fulmin2,w 
 movwf mout 
	 
	 
	 
     
 bsf minres,0	 
	
 goto hllJCAAA

	
hllDCAAA:


 

	
 clrf mout_hi
	
	
	
 movf fulmin,w
 addwf fulmin2,w
 movwf mout
	
	

	
 btfss STATUS,C	
 goto hllECAAA			
	
	
 incf mout_hi,f	
	
hllECAAA:



	
 movf min_lower,w
 addwf min2_lower,w
 btfsc STATUS,C
 goto hllFCAAA   
 

	
	
 andlw .128	
 btfss STATUS,Z
 goto hllFCAAA	  
	
	
 goto hllGCAAA	
	
hllFCAAA:


	
 incf mout,f	
	
	
 movf mout,f
 btfss STATUS,Z
 goto hllGCAAA 

	
 incf mout_hi,f

hllGCAAA:
	
 movf mout_hi,f
 btfsc STATUS,Z
 goto hllJCAAA 

	
	
	
	
 clrf big_c
 bcf STATUS,C
 rrf fulmin,f
 btfsc STATUS,C
 bsf big_c,0
	
	
 bcf STATUS,C
 rrf min_lower,f

	
	
 btfss big_c,0
 goto hllHCAAA
	
	
	
 bsf min_lower,7	
	
hllHCAAA:

	
	
 clrf big_c
 bcf STATUS,C
 rrf fulmin2,f
 btfsc STATUS,C
 bsf big_c,0
	
	
	
	
 bcf STATUS,C
 rrf min2_lower,f
	
	
	
 btfss big_c,0
 goto hllICAAA

	
	
	
 bsf min_lower,7		
	
hllICAAA:

	
 incf ein1,f	
	
	
 goto hllDCAAA


hllJCAAA:

 movfw mout 
 
 
 btfss STATUS,Z 
 goto hllKCAAA 
 
 
 
 movlw .0 

 PUSH
 
 
 
 movlw 0x80 
 PUSH
 
 
 
 goto hllLCAAA
 
 
 
hllKCAAA: 
 
 
 
 
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
 
hllLCAAA:
 
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

hllMCAAA:

 movf loop_count,w
 xorlw .16
 btfsc STATUS,Z
 goto hllRCAAA


 movf min,w
 andlw .128
 movwf a_hi_msb
 

 bcf STATUS,C
 rlf min2_lower,f



 bcf STATUS,C
 rlf run_total,f


 btfss STATUS,C
 goto hllNCAAA


 incf min2_lower,f

hllNCAAA:


 bcf STATUS,C
 rlf min,f 



 bcf STATUS,C
 rlf quotient_lo,f


 btfsc STATUS,C



 incf min,f


 movf a_hi_msb,f
 btfsc STATUS,Z
 goto hllOCAAA


 incf run_total,f


 btfsc STATUS,Z
 incf min2_lower,f

hllOCAAA:


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
 goto hllPCAAA



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


 goto hllQCAAA
hllPCAAA:


 movlw .1
 iorwf quotient_lo,f
hllQCAAA:



 incf loop_count,f


 goto hllMCAAA

hllRCAAA:


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
 goto hllSCAAA   
 incf mout,f 
 bsf rounded,0 
 
hllSCAAA:
 


 movf multiplier,f
 btfsc STATUS,Z
 goto hllVCAAA
 




 
 btfss mout,0
 goto hllTCAAA

 
 btfsc rounded,0
 goto hllTCAAA
 
 

 bcf STATUS,C
 rrf mout,f


 incf mout,f


 goto hllUCAAA

hllTCAAA:


 bcf STATUS,C 
 rrf mout,f

hllUCAAA:


 bsf mout,7

 goto hllWCAAA
hllVCAAA:
 decf util,f 
hllWCAAA:
 movfw mout 

hllXCAAA: 

  addlw -.128 
  movwf exam 
  btfss exam,7 
  goto hllYCAAA 
  addlw .128    

 
 decf util,f 
 bcf STATUS,C 
 
 
 
 rlf mout,f 
 movfw mout 
 goto hllXCAAA 

hllYCAAA: 


 movwf mout



 
 
 btfsc neg,0
 goto hllZCAAA 
 btfss neg,1
 goto hllBDAAA 
 goto hllADAAA 
hllZCAAA: 
 btfsc neg,1
 goto hllBDAAA 

hllADAAA: 

 
 
 
 
 movfw mout 
 iorlw .128 
 movwf mout 
 

hllBDAAA: 
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
 goto hllCDAAA
 POP
 goto hllMDAAA 
hllCDAAA:
 
 POP
 addlw .128
 banksel karg1
 movwf karg1 
 
 movfw karg2
 sublw .7
 
 movwf divisor 

 movlw high hllDDAAA 
 movwf PCLATH 
 movlw low hllDDAAA
 addwf divisor,w 
 btfsc STATUS,C 
 incf PCLATH,f 
 movwf PCL 


hllDDAAA:
 goto hllLDAAA
 goto hllKDAAA
 goto hllJDAAA 
 goto hllIDAAA
 goto hllHDAAA
 goto hllGDAAA
 goto hllFDAAA
 goto hllEDAAA
 
hllEDAAA:
 bcf STATUS,C 
 rrf karg1,f
 rrf util,f
hllFDAAA:
 bcf STATUS,C 
 rrf karg1,f
 rrf util,f
hllGDAAA:
 bcf STATUS,C 
 rrf karg1,f
 rrf util,f
hllHDAAA:
 bcf STATUS,C 
 rrf karg1,f
 rrf util,f
hllIDAAA:
 bcf STATUS,C 
 rrf karg1,f
 rrf util,f
hllJDAAA:
 bcf STATUS,C 
 rrf karg1,f
 rrf util,f
hllKDAAA:
 bcf STATUS,C 
 rrf karg1,f
 rrf util,f
hllLDAAA:

hllMDAAA:
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
 goto hllNDAAA
 btfsc neg2,0
 goto hllNDAAA
 movlw .0

 PUSH
 
 goto hllXDAAA
hllNDAAA:






 
 btfsc neg,0
 goto hllODAAA
 btfss neg2,0
 goto hllODAAA
 movlw .1 
 PUSH
 
 goto hllXDAAA
hllODAAA:



 
 
 bcf karg1,7
 bcf karg3,7


 
 
 
 

 
 
 
 
 
 

 btfsc karg4,7 
 goto hllPDAAA
 movf karg4,f
 btfsc STATUS,Z 
 goto hllPDAAA 
 

 movf karg2,f
 btfsc STATUS,Z
 goto hllRDAAA
 btfsc karg2,7
 goto hllRDAAA
 goto hllQDAAA
 
hllPDAAA: 

 btfsc karg2,7 
 goto hllRDAAA
 movf karg2,f
 btfsc STATUS,Z 
 goto hllRDAAA 
 goto hllWDAAA
hllQDAAA: 
 movfw 	karg2			
 subwf karg4,w    
 btfsc STATUS,C    
 goto hllRDAAA
 goto hllWDAAA



hllRDAAA: 



 





 btfsc karg2,7 
 goto hllSDAAA
 movf karg2,f
 btfsc STATUS,Z 
 goto hllSDAAA 
 

 movf karg4,f
 btfsc STATUS,Z
 goto hllUDAAA
 btfsc karg4,7
 goto hllUDAAA
 goto hllTDAAA
 
hllSDAAA: 

 btfsc karg4,7 
 goto hllUDAAA
 movf karg4,f
 btfsc STATUS,Z 
 goto hllUDAAA 
 goto hllVDAAA
hllTDAAA: 
 movfw 	karg4			
 subwf karg2,w    
 btfsc STATUS,C    
 goto hllUDAAA
 goto hllVDAAA
hllUDAAA: 








 
 
 
 
 movfw karg1
 subwf karg3,w
 btfss STATUS,C 
 goto hllWDAAA 
 
 movfw karg3
 subwf karg1,w
 btfss STATUS,C 
 goto hllVDAAA

 
 movlw .0 
 PUSH
 
 goto hllXDAAA 

 
hllVDAAA:
 banksel neg
 movlw .0 
 btfsc neg,0
 movlw .1 
 PUSH
 
 goto hllXDAAA 
hllWDAAA:
 banksel neg
 movlw .0 
 btfss neg,0
 movlw .1
 PUSH
 
hllXDAAA:
 
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
 goto hllYDAAA
 movlw .127	
 
 andwf HLINDF,w 
 
 btfsc STATUS,Z
 goto hllGEAAA
 
hllYDAAA: 

 
 
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
 goto hllZDAAA
 movlw .127

 andwf HLINDF,w 
 btfsc STATUS,Z
 goto hllHEAAA
hllZDAAA:

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
 goto hllJEAAA 

hllAEAAA:

 
 POP


 banksel mout
 movwf mout 

 
 btfss mout,7 
 goto hllBEAAA 

 
 POP

 
 banksel util
 incf util,f 


 
 andlw .128 
 btfss STATUS,Z
 incf mout,f

 goto hllCEAAA 


hllBEAAA: 

 
 
 
 
 

 
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
 


hllCEAAA: 

 
 movfw mout 

 
 addlw -.128 

 
 movwf mout 

 
 btfsc neg,0
 goto hllDEAAA 
 btfss neg,1
 goto hllFEAAA 
 goto hllEEAAA 
hllDEAAA: 
 btfsc neg,1
 goto hllFEAAA 

hllEEAAA: 

 
 movfw mout 

 
 iorlw .128 

 
 movwf mout 


hllFEAAA: 

 
 movfw mout 

 
 PUSH

 
 banksel util
 movfw util 
 PUSH
 
 goto hllIEAAA 

hllGEAAA: 

 POP
 POP


hllHEAAA:
 POP

 
 movlw .128
 PUSH
 PUSH

 
 
hllIEAAA:
 
 return
 
 
 
 
hllJEAAA: 

 POP
 banksel factor1
 movwf factor1

 POP
 banksel factor2
 movwf factor2


 
 clrf hi_byte
 
 clrf make_mout
 
 clrf iterator

hllKEAAA:

 
 btfss factor1,0
 goto hllLEAAA

 
 
 movfw factor2
 addwf make_mout,f

 
 btfsc STATUS,C
 incf hi_byte,f


hllLEAAA:
 
 
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
 goto hllKEAAA

 
 movfw factor1 
 PUSH

 
 banksel make_mout
 movfw make_mout
 PUSH

 goto hllAEAAA 





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
 goto hllMEAAA 
 
 
 

 bcf arg1,7 
 movfw arg1 
 
 PUSH


 movlw .7
 PUSH
 
 goto hllUEAAA

hllMEAAA: 
 btfss arg1,6
 goto hllNEAAA 


 
 

 
 
 

 banksel arg1
 bcf arg1,6 
 bcf STATUS,C 
 rlf arg1,f
 movfw arg1
 PUSH

 movlw .6
 PUSH
 
 goto hllUEAAA
hllNEAAA: 

 btfss arg1,5
 goto hllOEAAA

 banksel arg1
 bcf arg1,5 
 bcf STATUS,C 
 rlf arg1,f
 rlf arg1,f
 movfw arg1
 PUSH

 movlw .5
 PUSH
 
 goto hllUEAAA
hllOEAAA: 

 btfss arg1,4
 goto hllPEAAA


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
 
 goto hllUEAAA
hllPEAAA: 

 btfss arg1,3
 goto hllQEAAA

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
 
 goto hllUEAAA

hllQEAAA: 

 btfss arg1,2
 goto hllREAAA


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
 
 goto hllUEAAA

hllREAAA: 

 btfss arg1,1
 goto hllSEAAA

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

 goto hllUEAAA
hllSEAAA: 
 btfss arg1,0
 goto hllTEAAA
 movlw .0
 PUSH

 movlw .0
 PUSH
 
 goto hllUEAAA
hllTEAAA:
 movlw .0
 PUSH

 movlw -.128
 PUSH
 
hllUEAAA:
 
 return




#undefine arg1

 end
