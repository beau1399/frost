
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
 PUSH 

   banksel OSCCON
   movfw OSCCON
   
   
 PUSH 


 
 FAR_CALL hlluserprog,oru

 POP
 banksel OSCCON
 movwf OSCCON
 


 movlw .17 
 
 banksel SPBRG
 movwf SPBRG
 


 movlw .0 
 
 banksel SPBRGH
 movwf SPBRGH
 


 movlw SYNC

 PUSH 

   banksel TXSTA
   movfw TXSTA
   
   
 PUSH 


 
 FAR_CALL hlluserprog,clearbit

 POP
 banksel TXSTA
 movwf TXSTA
 


 movlw CREN

 PUSH 

   banksel RCSTA
   movfw RCSTA
   
   
 PUSH 


 
 FAR_CALL hlluserprog,clearbit

 POP
 banksel RCSTA
 movwf RCSTA
 


 movlw CREN

 PUSH 

   banksel RCSTA
   movfw RCSTA
   
   
 PUSH 


 
 FAR_CALL hlluserprog,setbit

 POP
 banksel RCSTA
 movwf RCSTA
 


 movlw SPEN

 PUSH 

   banksel RCSTA
   movfw RCSTA
   
   
 PUSH 


 
 FAR_CALL hlluserprog,setbit

 POP
 banksel RCSTA
 movwf RCSTA
 


 movlw TXEN

 PUSH 


 movlw TX9

 PUSH 


 movlw BRGH

 PUSH 

   banksel TXSTA
   movfw TXSTA
   
   
 PUSH 


 
 HALF_FAR_CALL setbit


 
 HALF_FAR_CALL clearbit


 
 FAR_CALL hlluserprog,setbit

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


 
 HALF_FAR_CALL setbit


 
 FAR_CALL hlluserprog,setbit

 POP
 banksel BAUDCTL
 movwf BAUDCTL
 


 movlw .0 
 
 banksel ANSELH
 movwf ANSELH
 


 movlw .0 
 
 banksel ANSEL
 movwf ANSEL
 


 movlw RCIE

 PUSH 


 movlw TXIE

 PUSH 

   banksel PIE1
   movfw PIE1
   
   
 PUSH 


 
 HALF_FAR_CALL clearbit


 
 FAR_CALL hlluserprog,clearbit

 POP
 banksel PIE1
 movwf PIE1
 


 movlw TXIE

 PUSH 


 movlw RCIE

 PUSH 

   banksel PIE1
   movfw PIE1
   
   
 PUSH 


 
 HALF_FAR_CALL clearbit


 
 FAR_CALL hlluserprog,clearbit

 POP
 banksel PIE1
 movwf PIE1
 


 movlw .0 
 
 banksel INTCON
 movwf INTCON
 


 
 HALF_FAR_CALL cls


 
 FAR_CALL hlluserprog,longf

    
hllprogend:
 goto hllprogend
 

hllt450 CODE
longf:
 movf FSR,w
 

 
 FAR_CALL longf ,kpush


 movlw .10 
 PUSH 


 movlw .10 
 PUSH 


 movlw .65
 PUSH 


 
 FAR_CALL longf,wrapstringA

 ;
 KDISCARD 
 goto longf

 

hllt451 CODE
makespaces:
 movf FSR,w
 

 
 FAR_CALL makespaces ,kpush


 movlw -.1
 PUSH 


 
 HALF_FAR_CALL add


 
 HALF_FAR_CALL makespacesi


 
 FAR_CALL makespaces,kpop

;LOAD POINTER
 movwf FSR
 

 DISCARD


 return
 

hllt454 CODE
makespacesi:
 movf FSR,w
 

 
 FAR_CALL makespacesi ,kpush


 movlw .0
 PUSH 


 
 FAR_CALL makespacesi,parm

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J2 
 

 movlw .32
 PUSH 


 
 FAR_CALL makespacesi,printch


 movlw -.1
 PUSH 


 
 FAR_CALL makespacesi,add

 ;


 KDISCARD 
 goto makespacesi
hlllb51J2:
hlllb51J3:

 KDISCARD 
 return 

 

hllt455 CODE
wrapstringA:
 movf FSR,w
 

 
 FAR_CALL wrapstringA ,kpush


 movlw .0
 PUSH 


 
 FAR_CALL wrapstringA,stringA

 PUSH 


 movlw .2
 PUSH 


 
 FAR_CALL wrapstringA,parm


 movlw .1
 PUSH 


 
 HALF_FAR_CALL parm


 
 FAR_CALL wrapstringA,printchxy


 movlw .2
 PUSH 


 
 FAR_CALL wrapstringA,parm


 movlw .0
 PUSH 


 
 FAR_CALL wrapstringA,parm


 movlw .1 
 PUSH 


 movlw -.1
 PUSH 


 movlw .0
 PUSH 


 
 HALF_FAR_CALL parm


 
 HALF_FAR_CALL add


 
 HALF_FAR_CALL wrapstringAi


 
 FAR_CALL wrapstringA,kpop

;LOAD POINTER
 movwf FSR
 

 DISCARD


 DISCARD


 DISCARD


 return
 

hllt456 CODE
copy:
 movf FSR,w
 

 
 FAR_CALL copy ,kpush


 movlw .0
 PUSH 


 
 FAR_CALL copy,parm


 movlw .0
 PUSH 


 
 HALF_FAR_CALL parm


 
 FAR_CALL copy,kpop
 
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
 
 FAR_CALL copy ,kpush
 

 POP
 
 FAR_CALL copy ,kpush
 
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


 
 FAR_CALL copy ,kpop

 PUSH 


 
 FAR_CALL copy ,kpop

 PUSH 


 return
 

hllt4519 CODE
wrapstringAi:
 movf FSR,w
 

 
 FAR_CALL wrapstringAi ,kpush


 movlw .3
 PUSH 


 
 FAR_CALL wrapstringAi,parm


 movlw .2
 PUSH 


 
 FAR_CALL wrapstringAi,parm


 movlw .1
 PUSH 


 
 FAR_CALL wrapstringAi,parm


 movlw .0
 PUSH 


 
 HALF_FAR_CALL parm


 
 FAR_CALL wrapstringAi,wrapstringAif

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J7 
 

 
 FAR_CALL wrapstringAi,eat


 movlw .2
 PUSH 


 
 FAR_CALL wrapstringAi,parm

 
 goto hlllb51J8
 

hlllb51J7:


hlllb51J8:


 movlw .0
 PUSH 


 
 FAR_CALL wrapstringAi,parm


 movlw .1
 PUSH 


 
 FAR_CALL wrapstringAi,eq

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J15 
 

 movlw .1
 PUSH 


 
 HALF_FAR_CALL parm


 
 FAR_CALL wrapstringAi,stringA

 PUSH 


 movlw .47
 PUSH 


 
 FAR_CALL wrapstringAi,geu


 movlw .58 
 PUSH 


 movlw .1
 PUSH 


 
 HALF_FAR_CALL parm


 
 FAR_CALL wrapstringAi,stringA

 PUSH 


 
 HALF_FAR_CALL geu


 
 FAR_CALL wrapstringAi,andb


 movlw .1
 PUSH 


 
 HALF_FAR_CALL parm


 
 FAR_CALL wrapstringAi,stringA

 PUSH 


 movlw .64
 PUSH 


 
 FAR_CALL wrapstringAi,geu


 movlw .156 
 PUSH 


 movlw .1
 PUSH 


 
 HALF_FAR_CALL parm


 
 FAR_CALL wrapstringAi,stringA

 PUSH 


 
 HALF_FAR_CALL geu


 
 HALF_FAR_CALL andb


 
 FAR_CALL wrapstringAi,orb

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J13 
 

 movlw .45
 PUSH 


 
 FAR_CALL wrapstringAi,printch


 movlw .13
 PUSH 


 
 FAR_CALL wrapstringAi,printch


 movlw .10
 PUSH 


 
 FAR_CALL wrapstringAi,printch


 movlw .1
 PUSH 


 
 HALF_FAR_CALL parm


 
 FAR_CALL wrapstringAi,stringA

 PUSH 


 movlw .32
 PUSH 


 
 FAR_CALL wrapstringAi,eq

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J9 
 

 movlw -.1
 PUSH 


 movlw .3
 PUSH 


 
 HALF_FAR_CALL parm


 
 HALF_FAR_CALL add


 
 FAR_CALL wrapstringAi,makespaces

 
 goto hlllb51J10
 

hlllb51J9:


 movlw .3
 PUSH 


 
 HALF_FAR_CALL parm


 
 FAR_CALL wrapstringAi,makespaces


hlllb51J10:


 movlw .1
 PUSH 


 
 HALF_FAR_CALL parm


 
 FAR_CALL wrapstringAi,stringA

 PUSH 


 
 HALF_FAR_CALL printch


 
 FAR_CALL wrapstringAi,eat


 movlw -.1
 PUSH 


 movlw .2
 PUSH 


 
 HALF_FAR_CALL parm


 
 FAR_CALL wrapstringAi,add

 
 goto hlllb51J14
 

hlllb51J13:


 movlw .1
 PUSH 


 
 HALF_FAR_CALL parm


 
 FAR_CALL wrapstringAi,stringA

 PUSH 


 
 FAR_CALL wrapstringAi,printch


 movlw .13
 PUSH 


 
 FAR_CALL wrapstringAi,printch


 movlw .10
 PUSH 


 
 FAR_CALL wrapstringAi,printch


 movlw .1 
 PUSH 


 movlw .1
 PUSH 


 
 HALF_FAR_CALL parm


 
 HALF_FAR_CALL add


 
 FAR_CALL wrapstringAi,stringA

 PUSH 


 movlw .32
 PUSH 


 
 FAR_CALL wrapstringAi,eq

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J11 
 

 movlw -.1
 PUSH 


 movlw .3
 PUSH 


 
 HALF_FAR_CALL parm


 
 HALF_FAR_CALL add


 
 FAR_CALL wrapstringAi,makespaces

 
 goto hlllb51J12
 

hlllb51J11:


 movlw .3
 PUSH 


 
 HALF_FAR_CALL parm


 
 FAR_CALL wrapstringAi,makespaces


hlllb51J12:


 
 FAR_CALL wrapstringAi,eat


 movlw .2
 PUSH 


 
 FAR_CALL wrapstringAi,parm


hlllb51J14:

 
 goto hlllb51J16
 

hlllb51J15:


 movlw .1
 PUSH 


 
 HALF_FAR_CALL parm


 
 FAR_CALL wrapstringAi,stringA

 PUSH 


 
 FAR_CALL wrapstringAi,printch


 movlw -.1
 PUSH 


 
 FAR_CALL wrapstringAi,add


hlllb51J16:


 movlw .1 
 PUSH 


 movlw .1
 PUSH 


 
 HALF_FAR_CALL parm


 
 HALF_FAR_CALL add


 
 FAR_CALL wrapstringAi,stringA

 
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J17 
 

 
 FAR_CALL wrapstringAi,remove


 movlw .1
 PUSH 


 
 HALF_FAR_CALL add


 
 FAR_CALL wrapstringAi,restore

 ;


 KDISCARD 
 goto wrapstringAi
hlllb51J17:
hlllb51J18:

 KDISCARD 
 return 

 

hllt4520 CODE
eat:
 movf FSR,w
 

 
 HALF_FAR_CALL kpush


 
 FAR_CALL eat,kpop

;LOAD POINTER
 movwf FSR
 

 DISCARD


 return
 

hllt4525 CODE
wrapstringAif:
 movf FSR,w
 

 
 FAR_CALL wrapstringAif ,kpush


 movlw .2
 PUSH 


 
 FAR_CALL wrapstringAif,parm


 movlw .1
 PUSH 


 
 FAR_CALL wrapstringAif,parm


 movlw .0
 PUSH 


 
 FAR_CALL wrapstringAif,wrapstringAifin


 movlw .1 
 PUSH 


 movlw .0
 PUSH 


 
 HALF_FAR_CALL parm


 
 HALF_FAR_CALL add


 
 FAR_CALL wrapstringAif,geu


 movlw .0 
 PUSH 


 movlw .1
 PUSH 


 
 HALF_FAR_CALL parm


 
 FAR_CALL wrapstringAif,eq

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J21 
 

 movlw .0
 PUSH 

 
 goto hlllb51J22
 

hlllb51J21:


 movlw -.1
 PUSH 


 movlw .1
 PUSH 


 
 HALF_FAR_CALL parm


 
 FAR_CALL wrapstringAif,add


hlllb51J22:


 
 FAR_CALL wrapstringAif,stringA

 PUSH 


 movlw .32
 PUSH 


 
 HALF_FAR_CALL eq


 
 FAR_CALL wrapstringAif,mul

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J23 
 

 movlw .13
 PUSH 


 
 FAR_CALL wrapstringAif,printch


 movlw .10
 PUSH 


 
 FAR_CALL wrapstringAif,printch


 movlw .3
 PUSH 


 
 HALF_FAR_CALL parm


 
 FAR_CALL wrapstringAif,makespaces


 movlw .1
	  
 PUSH 

 
 goto hlllb51J24
 

hlllb51J23:


 movlw .0
 PUSH 


hlllb51J24:


 
 FAR_CALL wrapstringAif,kpop
 
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
 
 FAR_CALL wrapstringAif ,kpush
 
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


 
 FAR_CALL wrapstringAif ,kpop

 PUSH 


 return
 

hllt4528 CODE
wrapstringAifin:
 movf FSR,w
 

 
 FAR_CALL wrapstringAifin ,kpush


 movlw .0
 PUSH 


 
 FAR_CALL wrapstringAifin,parm


 movlw .1
 PUSH 


 
 HALF_FAR_CALL parm


 
 HALF_FAR_CALL add


 
 FAR_CALL wrapstringAifin,stringA

 PUSH 


 movlw .32
 PUSH 


 
 FAR_CALL wrapstringAifin,eq


 movlw .0
 PUSH 


 
 FAR_CALL wrapstringAifin,parm


 movlw .1
 PUSH 


 
 HALF_FAR_CALL parm


 
 HALF_FAR_CALL add


 
 FAR_CALL wrapstringAifin,stringA

 PUSH 


 movlw .0
 PUSH 


 
 HALF_FAR_CALL eq


 
 FAR_CALL wrapstringAifin,add

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J26 
 

 movlw .0
 PUSH 


 
 FAR_CALL wrapstringAifin,parm

 
 goto hlllb51J27
 

hlllb51J26:


 movlw .1
 PUSH 


 
 FAR_CALL wrapstringAifin,add

 ;

 KDISCARD 
 goto wrapstringAifin
hlllb51J27:

 KDISCARD 
 return 

 

hllt4529 CODE
eqresult:
 movf FSR,w
 

 
 FAR_CALL eqresult ,kpush


 movlw .0
 PUSH 


 
 FAR_CALL eqresult,parm


 movlw .2
 PUSH 


 
 FAR_CALL eqresult,geu


 movlw .1
 PUSH 


 
 FAR_CALL eqresult,parm


 movlw .2
 PUSH 


 
 HALF_FAR_CALL geu


 
 HALF_FAR_CALL eq


 
 FAR_CALL eqresult,kpop
 
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
 
 FAR_CALL eqresult ,kpush
 
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


 
 FAR_CALL eqresult ,kpop

 PUSH 


 return
 

hllt4530 CODE
 HLTABLE  stringA


 retlw .79
 

 retlw .83
 

 retlw .57
 

 retlw .32
 

 retlw .39
 

 retlw .39
 

 retlw .54
 

 retlw .56
 

 retlw .48
 

 retlw .57
 

 retlw .39
 

 retlw .39
 

 retlw .32
 

 retlw .114
 

 retlw .97
 

 retlw .110
 

 retlw .32
 

 retlw .111
 

 retlw .110
 

 retlw .32
 

 retlw .77
 

 retlw .111
 

 retlw .116
 

 retlw .111
 

 retlw .114
 

 retlw .111
 

 retlw .108
 

 retlw .97
 

 retlw .32
 

 retlw .69
 

 retlw .88
 

 retlw .79
 

 retlw .82
 

 retlw .98
 

 retlw .117
 

 retlw .115
 

 retlw .32
 

 retlw .115
 

 retlw .121
 

 retlw .115
 

 retlw .116
 

 retlw .101
 

 retlw .109
 

 retlw .115
 

 retlw .32
 

 retlw .117
 

 retlw .115
 

 retlw .105
 

 retlw .110
 

 retlw .103
 

 retlw .32
 

 retlw .116
 

 retlw .104
 

 retlw .101
 

 retlw .32
 

 retlw .77
 

 retlw .111
 

 retlw .116
 

 retlw .111
 

 retlw .114
 

 retlw .111
 

 retlw .108
 

 retlw .97
 

 retlw .32
 

 retlw .54
 

 retlw .56
 

 retlw .48
 

 retlw .57
 

 retlw .44
 

 retlw .32
 

 retlw .83
 

 retlw .83
 

 retlw .53
 

 retlw .48
 

 retlw .32
 

 retlw .66
 

 retlw .117
 

 retlw .115
 

 retlw .32
 

 retlw .97
 

 retlw .110
 

 retlw .100
 

 retlw .32
 

 retlw .83
 

 retlw .83
 

 retlw .45
 

 retlw .53
 

 retlw .48
 

 retlw .67
 

 retlw .32
 

 retlw .98
 

 retlw .117
 

 retlw .115
 

 retlw .32
 

 retlw .115
 

 retlw .121
 

 retlw .115
 

 retlw .116
 

 retlw .101
 

 retlw .109
 

 retlw .115
 

 retlw .32
 

 retlw .102
 

 retlw .114
 

 retlw .111
 

 retlw .109
 

 retlw .32
 

 retlw .99
 

 retlw .111
 

 retlw .109
 

 retlw .112
 

 retlw .97
 

 retlw .110
 

 retlw .105
 

 retlw .101
 

 retlw .115
 

 retlw .32
 

 retlw .115
 

 retlw .117
 

 retlw .99
 

 retlw .104
 

 retlw .32
 

 retlw .97
 

 retlw .115
 

 retlw .32
 

 retlw .83
 

 retlw .87
 

 retlw .84
 

 retlw .80
 

 retlw .67
 

 retlw .44
 

 retlw .32
 

 retlw .84
 

 retlw .97
 

 retlw .110
 

 retlw .111
 

 retlw .44
 

 retlw .32
 

 retlw .71
 

 retlw .105
 

 retlw .109
 

 retlw .105
 

 retlw .120
 

 retlw .44
 

 retlw .32
 

 retlw .77
 

 retlw .105
 

 retlw .100
 

 retlw .119
 

 retlw .101
 

 retlw .115
 

 retlw .116
 

 retlw .32
 

 retlw .83
 

 retlw .99
 

 retlw .105
 

 retlw .101
 

 retlw .110
 

 retlw .116
 

 retlw .105
 

 retlw .102
 

 retlw .105
 

 retlw .99
 

 retlw .44
 

 retlw .32
 

 retlw .97
 

 retlw .110
 

 retlw .100
 

 retlw .32
 

 retlw .83
 

 retlw .109
 

 retlw .111
 

 retlw .107
 

 retlw .101
 

 retlw .32
 

 retlw .83
 

 retlw .105
 

 retlw .103
 

 retlw .110
 

 retlw .97
 

 retlw .108
 

 retlw .32
 

 retlw .66
 

 retlw .114
 

 retlw .111
 

 retlw .97
 

 retlw .100
 

 retlw .99
 

 retlw .97
 

 retlw .115
 

 retlw .116
 

 retlw .105
 

 retlw .110
 

 retlw .103
 

 retlw .44
 

 retlw .32
 

 retlw .97
 

 retlw .110
 

 retlw .100
 

 retlw .32
 

 retlw .83
 

 retlw .84
 

 retlw .68
 

 retlw .45
 

 retlw .98
 

 retlw .117
 

 retlw .115
 

 retlw .32
 

 retlw .54
 

 retlw .56
 

 retlw .48
 

 retlw .57
 

 retlw .32
 

 retlw .115
 

 retlw .121
 

 retlw .115
 

 retlw .116
 

 retlw .101
 

 retlw .109
 

 retlw .115
 

 retlw .32
 

 retlw .102
 

 retlw .114
 

 retlw .111
 

 retlw .109
 

 retlw .32
 

 retlw .115
 

 retlw .101
 

 retlw .118
 

 retlw .101
 

 retlw .114
 

 retlw .97
 

 retlw .108
 

 retlw .32
 

 retlw .115
 

 retlw .117
 

 retlw .112
 

 retlw .112
 

 retlw .108
 

 retlw .105
 

 retlw .101
 

 retlw .114
 

 retlw .115
 

 retlw .46
 

 retlw .0
hllprgen2:
 goto hllprgen2
 





 


 
hlog1g CODE
 
andb: 
 pagesel mul
 goto mul

 





 
 

 


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




 
 
ansiarh CODE
 
printchxy: 
 
 movlw 0x1b
 PUSH
 
 FAR_CALL printchxy,printch
 movlw '['
 PUSH
 
 HALF_FAR_CALL printch
 
 FAR_CALL printchxy,printu
 movlw ';'
 PUSH
 
 HALF_FAR_CALL printch
 
 FAR_CALL printchxy,printu
 movlw 'H'
 PUSH
 
 HALF_FAR_CALL printch
 
 FAR_CALL printchxy,printch
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
 
 






 


 
hlog1e CODE
 

orb: 
 POP
 xorlw .0
 btfsc STATUS,Z
 goto zzorz1
 movlw .1
 movwf HLINDF
 return
zzorz1: 
 POP
 xorlw .0
 btfsc STATUS,Z
 goto zzorz2
 movlw .1
 PUSH
 return
zzorz2: 
 movlw .0
 PUSH
 return

 





 
 

 
hlog1d CODE

oru: 
 POP
 iorwf HLINDF,w
 decf HLFSR,f 
 PUSH
 return

 









 


a1tsssck CODE

remove:
 POP 
 KPUSH 
 return


 








 


altstall CODE

restore:
 KPOP 
 PUSH 
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
 goto hllKAAAA
 
 movfw  margp2
 iorlw .1
 goto hllRAAAA
hllKAAAA: 
 
 xorlw .1
 btfss STATUS,Z
 goto hllLAAAA
 
 movfw  margp2
 iorlw .2
 goto hllRAAAA
hllLAAAA: 
 xorlw .1
 xorlw .2
 btfss STATUS,Z
 goto hllMAAAA
 
 movfw margp2
 iorlw .4
 goto hllRAAAA
hllMAAAA: 
 xorlw .2
 xorlw .3
 btfss STATUS,Z
 goto hllNAAAA
 
 movfw margp2
 iorlw .8
 goto hllRAAAA
hllNAAAA: 
 xorlw .3
 xorlw .4
 btfss STATUS,Z
 goto hllOAAAA
 
 movfw margp2
 iorlw .16
 goto hllRAAAA
hllOAAAA: 
 xorlw .4
 xorlw .5
 btfss STATUS,Z
 goto hllPAAAA
 
 movfw margp2
 iorlw .32
 goto hllRAAAA
hllPAAAA: 
 xorlw .5
 xorlw .6
 btfss STATUS,Z
 goto hllQAAAA
 
 movfw margp2
 iorlw .64
 goto hllRAAAA
hllQAAAA: 
 
 movfw margp2
 iorlw .128 
hllRAAAA:  
 PUSH 
 return




#undefine margp2

 end
