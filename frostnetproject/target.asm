
#include "hloe.inc"


;
; R O B O T
;
; C O N F I G
;


 __config (_EXTRC_OSC_NOCLKOUT& _WDT_OFF  & _MCLRE_OFF & _IESO_OFF & _FCMEN_OFF  & _PWRTE_ON & _BOR_OFF)


hllv2cnt UDATA
hllcntl RES .1

#define cnt hllcntl

hllv2wasnight UDATA
hllwasnightl RES .1

#define wasnight hllwasnightl



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


 movlw .0
 



   
 FAR_CALL ISR ,safepush


 movlw .0
 


   
 FAR_CALL ISR ,safepush


 movlw .4

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL samplef


 
 HALF_FAR_CALL addf


 
 FAR_CALL ISR,handler


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
 

 movlw .0 

   
 FAR_CALL hlluserprog ,safepush


 movlw .4 

   
 FAR_CALL hlluserprog ,safepush


 movlw .1 

   
 FAR_CALL hlluserprog ,safepush


 movlw .2 

   
 FAR_CALL hlluserprog ,safepush

   banksel TRISA
   movfw TRISA
   
   

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL setbit


 
 HALF_FAR_CALL setbit


 
 HALF_FAR_CALL setbit


 
 FAR_CALL hlluserprog,setbit

 POP
 banksel TRISA
 movwf TRISA
 


 movlw .0 

   
 FAR_CALL hlluserprog ,safepush

   banksel TRISC
   movfw TRISC
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL hlluserprog,setbit

 POP
 banksel TRISC
 movwf TRISC
 


 movlw .5 

   
 FAR_CALL hlluserprog ,safepush

   banksel CM1CON0
   movfw CM1CON0
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL hlluserprog,clearbit

 POP
 banksel CM1CON0
 movwf CM1CON0
 


 movlw .0 

   
 FAR_CALL hlluserprog ,safepush

 POP
 banksel INTCON
 movwf INTCON
 


 movlw .0 

   
 FAR_CALL hlluserprog ,safepush

 POP
 banksel GIE
 movwf GIE
 


 movlw NOT_RABPU


   
 FAR_CALL hlluserprog ,safepush

   banksel OPTION_REG
   movfw OPTION_REG
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL hlluserprog,setbit

 POP
 banksel OPTION_REG
 movwf OPTION_REG
 


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
 


 movlw SYNC


   
 FAR_CALL hlluserprog ,safepush


 movlw BRGH


   
 FAR_CALL hlluserprog ,safepush

   banksel TXSTA
   movfw TXSTA
   
   

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL setbit


 
 FAR_CALL hlluserprog,clearbit

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
 


 movlw .25 

   
 FAR_CALL hlluserprog ,safepush

 POP
 banksel SPBRG
 movwf SPBRG
 


 movlw .0  

   
 FAR_CALL hlluserprog ,safepush

 POP
 banksel SPBRGH
 movwf SPBRGH
 


 movlw TXEN


   
 FAR_CALL hlluserprog ,safepush


 movlw TX9


   
 FAR_CALL hlluserprog ,safepush

   banksel TXSTA
   movfw TXSTA
   
   

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL clearbit


 
 FAR_CALL hlluserprog,setbit

 POP
 banksel TXSTA
 movwf TXSTA
 


 movlw SPEN


   
 FAR_CALL hlluserprog ,safepush

   banksel RCSTA
   movfw RCSTA
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL hlluserprog,setbit

 POP
 banksel RCSTA
 movwf RCSTA
 


 movlw .0 

   
 FAR_CALL hlluserprog ,safepush

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J0 
 
 
 goto hlllb51J1
 

hlllb51J0:


 movlw .1 

   
 FAR_CALL hlluserprog ,safepush

 POP
 banksel wasnight
 movwf wasnight
 


 
 FAR_CALL hlluserprog,night


hlllb51J1:


 movlw TMR1CS


   
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
 


 movlw .0 

   
 FAR_CALL hlluserprog ,safepush

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J2 
 
 
 goto hlllb51J3
 

hlllb51J2:


 
 FAR_CALL hlluserprog,cls


hlllb51J3:


 
 FAR_CALL hlluserprog,wait_button


 movlw TMR1ON


   
 FAR_CALL hlluserprog ,safepush

   banksel T1CON
   movfw T1CON
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL hlluserprog,clearbit

 POP
 banksel T1CON
 movwf T1CON
 


 movlw .0 

   
 FAR_CALL hlluserprog ,safepush

 POP
 banksel TMR1H
 movwf TMR1H
 


 movlw .0 

   
 FAR_CALL hlluserprog ,safepush

 POP
 banksel TMR1L
 movwf TMR1L
 


 movlw GIE


   
 FAR_CALL hlluserprog ,safepush

   banksel INTCON
   movfw INTCON
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL hlluserprog,setbit

 POP
 banksel INTCON
 movwf INTCON
 


 movlw .0 

   
 FAR_CALL hlluserprog ,safepush

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J4 
 

 movlw .128 

   
 FAR_CALL hlluserprog ,safepush

 POP
 banksel TMR1H
 movwf TMR1H
 

 
 goto hlllb51J5
 

hlllb51J4:


hlllb51J5:


 movlw TMR1ON


   
 FAR_CALL hlluserprog ,safepush

   banksel T1CON
   movfw T1CON
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL hlluserprog,setbit

 POP
 banksel T1CON
 movwf T1CON
 

    
hllprogend:
 goto hllprogend
 

hllt458 CODE
wait_button:

   banksel PORTA
   movfw PORTA
   
   

   
 FAR_CALL wait_button ,safepush


 movlw .16

   
 HALF_FAR_CALL safepush


 
 FAR_CALL wait_button,andu

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J6 
 
 ;


 goto wait_button
hlllb51J6:
hlllb51J7:

 return 

 

hllt459 CODE
bigbar:
 movf FSR,w
 

 
 FAR_CALL bigbar ,kpush


 movlw .15 

   
 FAR_CALL bigbar ,safepush


 movlw .0

   
 HALF_FAR_CALL safepush


 
 FAR_CALL bigbar,parm


 movlw .1

   
 HALF_FAR_CALL safepush


 
 FAR_CALL bigbar,parm


 movlw .11 

   
 HALF_FAR_CALL safepush


 
 FAR_CALL bigbar,graphx


 movlw .15 

   
 FAR_CALL bigbar ,safepush


 movlw .0

   
 HALF_FAR_CALL safepush


 
 FAR_CALL bigbar,parm


 movlw .1

   
 HALF_FAR_CALL safepush


 
 FAR_CALL bigbar,parm


 movlw .12 

   
 HALF_FAR_CALL safepush


 
 FAR_CALL bigbar,graphx


 movlw .15 

   
 FAR_CALL bigbar ,safepush


 movlw .0

   
 HALF_FAR_CALL safepush


 
 FAR_CALL bigbar,parm


 movlw .1

   
 HALF_FAR_CALL safepush


 
 FAR_CALL bigbar,parm


 movlw .13 

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL graphx


 
 FAR_CALL bigbar,kpop

;LOAD POINTER
 movwf FSR
 

 DISCARD


 DISCARD


 return
 

hllt4510 CODE
 HLTABLE  TextA


 retlw .13

 retlw .10

 retlw .79
 

 retlw .83
 

 retlw .45
 

 retlw .57
 

 retlw .32
 

 retlw .54
 

 retlw .56
 

 retlw .48
 

 retlw .57
 

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
 

 retlw .45
 

 retlw .53
 

 retlw .48
 

 retlw .32
 

 retlw .0

 retlw .0

hllt4511 CODE
putTextA:
 movf FSR,w
 

 
 FAR_CALL putTextA ,kpush


 movlw .0

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL putiTextA


 
 FAR_CALL putTextA,kpop

;LOAD POINTER
 movwf FSR
 

 return
 

hllt4514 CODE
putiTextA:
 movf FSR,w
 

 
 FAR_CALL putiTextA ,kpush


 movlw .0

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL parm


 
 HALF_FAR_CALL TextA


   
 FAR_CALL putiTextA ,safepush


 movlw .0 

   
 HALF_FAR_CALL safepush


 
 FAR_CALL putiTextA,eq

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J12 
 
 
 goto hlllb51J13
 

hlllb51J12:


 movlw .0

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL parm


 
 HALF_FAR_CALL TextA


   
 HALF_FAR_CALL safepush


 
 FAR_CALL putiTextA,printch


 movlw .1

   
 HALF_FAR_CALL safepush


 
 FAR_CALL putiTextA,add

 ;

 KDISCARD 
 goto putiTextA
hlllb51J13:

 KDISCARD 
 return 

 

hllt4515 CODE
 HLTABLE  TextB


 retlw .13

 retlw .10

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
 

 retlw .108
 

 retlw .105
 

 retlw .107
 

 retlw .101
 

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
 

 retlw .32
 

 retlw .97
 

 retlw .110
 

 retlw .100
 

 retlw .32
 

 retlw .0

 retlw .0

hllt4516 CODE
putTextB:
 movf FSR,w
 

 
 FAR_CALL putTextB ,kpush


 movlw .0

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL putiTextB


 
 FAR_CALL putTextB,kpop

;LOAD POINTER
 movwf FSR
 

 return
 

hllt4519 CODE
putiTextB:
 movf FSR,w
 

 
 FAR_CALL putiTextB ,kpush


 movlw .0

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL parm


 
 HALF_FAR_CALL TextB


   
 FAR_CALL putiTextB ,safepush


 movlw .0 

   
 HALF_FAR_CALL safepush


 
 FAR_CALL putiTextB,eq

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J17 
 
 
 goto hlllb51J18
 

hlllb51J17:


 movlw .0

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL parm


 
 HALF_FAR_CALL TextB


   
 HALF_FAR_CALL safepush


 
 FAR_CALL putiTextB,printch


 movlw .1

   
 HALF_FAR_CALL safepush


 
 FAR_CALL putiTextB,add

 ;

 KDISCARD 
 goto putiTextB
hlllb51J18:

 KDISCARD 
 return 

 

hllt4520 CODE
 HLTABLE  TextC


 retlw .13

 retlw .10

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
 

 retlw .46
 

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
 

 retlw .99
 

 retlw .97
 

 retlw .108
 

 retlw .108
 

 retlw .101
 

 retlw .100
 

 retlw .32
 

 retlw .105
 

 retlw .116
 

 retlw .32
 

 retlw .97
 

 retlw .110
 

 retlw .32
 

 retlw .39
 

 retlw .56
 

 retlw .45
 

 retlw .98
 

 retlw .105
 

 retlw .116
 

 retlw .32
 

 retlw .80
 

 retlw .108
 

 retlw .117
 

 retlw .115
 

 retlw .39
 

 retlw .32
 

 retlw .100
 

 retlw .101
 

 retlw .115
 

 retlw .105
 

 retlw .103
 

 retlw .110
 

 retlw .46
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .0

 retlw .0

hllt4521 CODE
putTextC:
 movf FSR,w
 

 
 FAR_CALL putTextC ,kpush


 movlw .0

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL putiTextC


 
 FAR_CALL putTextC,kpop

;LOAD POINTER
 movwf FSR
 

 return
 

hllt4524 CODE
putiTextC:
 movf FSR,w
 

 
 FAR_CALL putiTextC ,kpush


 movlw .0

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL parm


 
 HALF_FAR_CALL TextC


   
 FAR_CALL putiTextC ,safepush


 movlw .0 

   
 HALF_FAR_CALL safepush


 
 FAR_CALL putiTextC,eq

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J22 
 
 
 goto hlllb51J23
 

hlllb51J22:


 movlw .0

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL parm


 
 HALF_FAR_CALL TextC


   
 HALF_FAR_CALL safepush


 
 FAR_CALL putiTextC,printch


 movlw .1

   
 HALF_FAR_CALL safepush


 
 FAR_CALL putiTextC,add

 ;

 KDISCARD 
 goto putiTextC
hlllb51J23:

 KDISCARD 
 return 

 

hllt4525 CODE
 HLTABLE  TextE


 retlw .13

 retlw .10

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .32
 

 retlw .0

 retlw .0

hllt4526 CODE
putTextE:
 movf FSR,w
 

 
 FAR_CALL putTextE ,kpush


 movlw .0

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL putiTextE


 
 FAR_CALL putTextE,kpop

;LOAD POINTER
 movwf FSR
 

 return
 

hllt4529 CODE
putiTextE:
 movf FSR,w
 

 
 FAR_CALL putiTextE ,kpush


 movlw .0

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL parm


 
 HALF_FAR_CALL TextE


   
 FAR_CALL putiTextE ,safepush


 movlw .0 

   
 HALF_FAR_CALL safepush


 
 FAR_CALL putiTextE,eq

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J27 
 
 
 goto hlllb51J28
 

hlllb51J27:


 movlw .0

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL parm


 
 HALF_FAR_CALL TextE


   
 HALF_FAR_CALL safepush


 
 FAR_CALL putiTextE,printch


 movlw .1

   
 HALF_FAR_CALL safepush


 
 FAR_CALL putiTextE,add

 ;

 KDISCARD 
 goto putiTextE
hlllb51J28:

 KDISCARD 
 return 

 

hllt4546 CODE
handler:
 movf FSR,w
 

 
 FAR_CALL handler ,kpush


 movlw .0 

   
 FAR_CALL handler ,safepush

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J44 
 

 movlw .65 

   
 FAR_CALL handler ,safepush


 movlw .1

   
 HALF_FAR_CALL safepush


 
 FAR_CALL handler,parm


 movlw .0

   
 HALF_FAR_CALL safepush


 
 FAR_CALL handler,parm


 movlw .0
 



   
 FAR_CALL handler ,safepush


 movlw .6
 


   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL divf


 
 HALF_FAR_CALL ftou


 
 FAR_CALL handler,plotat


 movlw .1 

   
 FAR_CALL handler ,safepush

   banksel cnt
   movfw cnt
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL handler,add

 POP
 banksel cnt
 movwf cnt
 


 movlw .8 

   
 FAR_CALL handler ,safepush

   banksel cnt
   movfw cnt
   
   

   
 FAR_CALL handler ,safepush


 movlw .32

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL modu


 
 FAR_CALL handler,geu

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J30 
 

 
 FAR_CALL handler,putTextA

 
 goto hlllb51J31
 

hlllb51J30:


hlllb51J31:


 movlw .16 

   
 FAR_CALL handler ,safepush

   banksel cnt
   movfw cnt
   
   

   
 FAR_CALL handler ,safepush


 movlw .32

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL modu


 
 FAR_CALL handler,geu

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J32 
 

 
 FAR_CALL handler,putTextB

 
 goto hlllb51J33
 

hlllb51J32:


hlllb51J33:


 movlw .24 

   
 FAR_CALL handler ,safepush

   banksel cnt
   movfw cnt
   
   

   
 FAR_CALL handler ,safepush


 movlw .32

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL modu


 
 FAR_CALL handler,geu

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J34 
 

 
 FAR_CALL handler,putTextC

 
 goto hlllb51J35
 

hlllb51J34:


hlllb51J35:


 movlw .8 

   
 FAR_CALL handler ,safepush

   banksel cnt
   movfw cnt
   
   

   
 FAR_CALL handler ,safepush


 movlw .32

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL modu


 
 FAR_CALL handler,geu

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J36 
 
 
 goto hlllb51J37
 

hlllb51J36:


 
 FAR_CALL handler,putTextE


hlllb51J37:

 
 goto hlllb51J45
 

hlllb51J44:


 movlw .5 

   
 FAR_CALL handler ,safepush


 movlw .1

   
 HALF_FAR_CALL safepush


 
 FAR_CALL handler,parm


 movlw .0

   
 HALF_FAR_CALL safepush


 
 FAR_CALL handler,parm


 movlw .0
 



   
 FAR_CALL handler ,safepush


 movlw .6
 


   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL divf


 
 HALF_FAR_CALL ftou


 
 FAR_CALL handler,plotat

   banksel wasnight
   movfw wasnight
   
   

   
 FAR_CALL handler ,safepush

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J42 
 

 movlw .1

   
 HALF_FAR_CALL safepush


 
 FAR_CALL handler,parm


 movlw .0

   
 HALF_FAR_CALL safepush


 
 FAR_CALL handler,parm


 movlw .0
 



   
 FAR_CALL handler ,safepush


 movlw .9
 


   
 HALF_FAR_CALL safepush


 
 FAR_CALL handler,gtf

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J38 
 

 
 HALF_FAR_CALL day


 
 FAR_CALL handler,cls


 movlw .0

   
 FAR_CALL handler ,safepush

 POP
 banksel wasnight
 movwf wasnight
 

 
 goto hlllb51J39
 

hlllb51J38:


hlllb51J39:

 
 goto hlllb51J43
 

hlllb51J42:


 movlw .0
 



   
 FAR_CALL handler ,safepush


 movlw .9
 


   
 FAR_CALL handler ,safepush


 movlw .1

   
 HALF_FAR_CALL safepush


 
 FAR_CALL handler,parm


 movlw .0

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL parm


 
 FAR_CALL handler,gtf

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J40 
 

 
 HALF_FAR_CALL night


 
 FAR_CALL handler,cls


 movlw .1

   
 FAR_CALL handler ,safepush

 POP
 banksel wasnight
 movwf wasnight
 

 
 goto hlllb51J41
 

hlllb51J40:


hlllb51J41:


hlllb51J43:


hlllb51J45:


 
 FAR_CALL handler,kpop

;LOAD POINTER
 movwf FSR
 

 DISCARD


 DISCARD


 return
 

hllt4547 CODE
plotat:
 movf FSR,w
 

 
 FAR_CALL plotat ,kpush


 movlw .15 

   
 FAR_CALL plotat ,safepush


 movlw .0

   
 HALF_FAR_CALL safepush


 
 FAR_CALL plotat,parm


 movlw .1

   
 HALF_FAR_CALL safepush


 
 FAR_CALL plotat,parm


 movlw .7 

   
 HALF_FAR_CALL safepush


 
 FAR_CALL plotat,graphx


 movlw .15 

   
 FAR_CALL plotat ,safepush


 movlw .0

   
 HALF_FAR_CALL safepush


 
 FAR_CALL plotat,parm


 movlw .1

   
 HALF_FAR_CALL safepush


 
 FAR_CALL plotat,parm


 movlw .8 

   
 HALF_FAR_CALL safepush


 
 FAR_CALL plotat,graphx


 movlw .15 

   
 FAR_CALL plotat ,safepush


 movlw .0

   
 HALF_FAR_CALL safepush


 
 FAR_CALL plotat,parm


 movlw .1

   
 HALF_FAR_CALL safepush


 
 FAR_CALL plotat,parm


 movlw .9 

   
 HALF_FAR_CALL safepush


 
 FAR_CALL plotat,graphx


 movlw .15 

   
 FAR_CALL plotat ,safepush


 movlw .0

   
 HALF_FAR_CALL safepush


 
 FAR_CALL plotat,parm


 movlw .1

   
 HALF_FAR_CALL safepush


 
 FAR_CALL plotat,parm


 movlw .11 

   
 HALF_FAR_CALL safepush


 
 FAR_CALL plotat,graphx


 movlw .15 

   
 FAR_CALL plotat ,safepush


 movlw .0

   
 HALF_FAR_CALL safepush


 
 FAR_CALL plotat,parm


 movlw .1

   
 HALF_FAR_CALL safepush


 
 FAR_CALL plotat,parm


 movlw .12 

   
 HALF_FAR_CALL safepush


 
 FAR_CALL plotat,graphx


 movlw .15 

   
 FAR_CALL plotat ,safepush


 movlw .0

   
 HALF_FAR_CALL safepush


 
 FAR_CALL plotat,parm


 movlw .1

   
 HALF_FAR_CALL safepush


 
 FAR_CALL plotat,parm


 movlw .13 

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL graphx


 
 FAR_CALL plotat,kpop

;LOAD POINTER
 movwf FSR
 

 DISCARD


 DISCARD


 return
 

hllt4558 CODE
samplef:
 movf FSR,w
 

 
 FAR_CALL samplef ,kpush


 movlw .6 

   
 FAR_CALL samplef ,safepush


 movlw .5 

   
 FAR_CALL samplef ,safepush


 movlw .4 

   
 FAR_CALL samplef ,safepush

   banksel ADCON1
   movfw ADCON1
   
   

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL setbit


 
 HALF_FAR_CALL clearbit


 
 FAR_CALL samplef,setbit

 POP
 banksel ADCON1
 movwf ADCON1
 


 movlw .0

   
 HALF_FAR_CALL safepush


 
 FAR_CALL samplef,parm


 movlw .0

   
 HALF_FAR_CALL safepush


 
 FAR_CALL samplef,eq

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J56 
 

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

 
 goto hlllb51J57
 

hlllb51J56:


 movlw .0

   
 HALF_FAR_CALL safepush


 
 FAR_CALL samplef,parm


 movlw .1

   
 HALF_FAR_CALL safepush


 
 FAR_CALL samplef,eq

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J54 
 

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

 
 goto hlllb51J55
 

hlllb51J54:


 movlw .0

   
 HALF_FAR_CALL safepush


 
 FAR_CALL samplef,parm


 movlw .2

   
 HALF_FAR_CALL safepush


 
 FAR_CALL samplef,eq

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J52 
 

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

 
 goto hlllb51J53
 

hlllb51J52:


 movlw .0

   
 HALF_FAR_CALL safepush


 
 FAR_CALL samplef,parm


 movlw .3

   
 HALF_FAR_CALL safepush


 
 FAR_CALL samplef,eq

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J50 
 

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

 
 goto hlllb51J51
 

hlllb51J50:


 movlw .0

   
 HALF_FAR_CALL safepush


 
 FAR_CALL samplef,parm


 movlw .4

   
 HALF_FAR_CALL safepush


 
 FAR_CALL samplef,eq

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J48 
 

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

 
 goto hlllb51J49
 

hlllb51J48:


hlllb51J49:


hlllb51J51:


hlllb51J53:


hlllb51J55:


hlllb51J57:

 POP
 banksel ADCON0
 movwf ADCON0
 


 
 FAR_CALL samplef,dispose


 movlw .1 

   
 FAR_CALL samplef ,safepush


 movlw .7 

   
 FAR_CALL samplef ,safepush


 movlw .0 

   
 FAR_CALL samplef ,safepush

   banksel ADCON0
   movfw ADCON0
   
   

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL setbit


 
 HALF_FAR_CALL setbit


 
 FAR_CALL samplef,clearbit

 POP
 banksel ADCON0
 movwf ADCON0
 


 movlw .0 

   
 FAR_CALL samplef ,safepush

   banksel ANSEL
   movfw ANSEL
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL samplef,setbit

 POP
 banksel ANSEL
 movwf ANSEL
 


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

 
;LOAD POINTER
 movwf FSR
 

 DISCARD


 
 HALF_FAR_CALL kpop


 
 HALF_FAR_CALL safepush
 

 
 HALF_FAR_CALL kpop


 
 FAR_CALL samplef ,safepush
 

 return
 

hllt4561 CODE
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
 goto hlllb51J59 
 
 ;


 goto ourwait
hlllb51J59:
hlllb51J60:

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

 







 
 

hlpa22 CODE


day:
 
 
 movlw 0x1b
 PUSH
 
 FAR_CALL day,printch
 movlw '['
 PUSH
 
 FAR_CALL day,printch

 movlw '0'
 PUSH
 
 FAR_CALL day,printch
 movlw ';'
 PUSH
 
 FAR_CALL day,printch

 movlw '4'
 PUSH
 
 FAR_CALL day,printch
 movlw '7'
 PUSH
 
 FAR_CALL day,printch
 movlw ';'
 PUSH
 
 FAR_CALL day,printch
 movlw '3'
 PUSH
 
 FAR_CALL day,printch
 movlw '4'
 PUSH
 
 FAR_CALL day,printch
 movlw 'm'
 PUSH
 
 FAR_CALL day,printch
 
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
 goto hllMAAAA
 btfsc STATUS,C
 goto hllNAAAA
hllMAAAA:
 movlw .1
 PUSH
 
 return
hllNAAAA:
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
 
 







 

hlpal1 CODE

night:
 
 
 movlw 0x1b
 PUSH
 
 FAR_CALL night,printch
 movlw '['
 PUSH
 
 FAR_CALL night,printch

 movlw '0'
 PUSH
 
 FAR_CALL night,printch
 movlw ';'
 PUSH
 
 FAR_CALL night,printch

 movlw '3'
 PUSH
 
 FAR_CALL night,printch
 movlw '2'
 PUSH
 
 FAR_CALL night,printch
 movlw ';'
 PUSH
 
 FAR_CALL night,printch
 movlw '4'
 PUSH
 
 FAR_CALL night,printch
 movlw '0'
 PUSH
 
 FAR_CALL night,printch
 movlw 'm'
 PUSH
 
 FAR_CALL night,printch
 
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
 goto hllOAAAA
 
 movfw  margp2
 iorlw .1
 goto hllVAAAA
hllOAAAA: 
 
 xorlw .1
 btfss STATUS,Z
 goto hllPAAAA
 
 movfw  margp2
 iorlw .2
 goto hllVAAAA
hllPAAAA: 
 xorlw .1
 xorlw .2
 btfss STATUS,Z
 goto hllQAAAA
 
 movfw margp2
 iorlw .4
 goto hllVAAAA
hllQAAAA: 
 xorlw .2
 xorlw .3
 btfss STATUS,Z
 goto hllRAAAA
 
 movfw margp2
 iorlw .8
 goto hllVAAAA
hllRAAAA: 
 xorlw .3
 xorlw .4
 btfss STATUS,Z
 goto hllSAAAA
 
 movfw margp2
 iorlw .16
 goto hllVAAAA
hllSAAAA: 
 xorlw .4
 xorlw .5
 btfss STATUS,Z
 goto hllTAAAA
 
 movfw margp2
 iorlw .32
 goto hllVAAAA
hllTAAAA: 
 xorlw .5
 xorlw .6
 btfss STATUS,Z
 goto hllUAAAA
 
 movfw margp2
 iorlw .64
 goto hllVAAAA
hllUAAAA: 
 
 movfw margp2
 iorlw .128 
hllVAAAA:  
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
 goto hllYAAAA
 
 btfss ein1,7
 goto hllWAAAA
 
 goto hllABAAA
hllWAAAA: 
 
 movfw ein1
 subwf ein2,w    
 btfss STATUS,C 
 goto hllZAAAA  
hllXAAAA:
 goto hllABAAA  
hllYAAAA:   
 
 
 btfsc ein1,7
 goto hllWAAAA  
hllZAAAA:  
 
 


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
 
 
 
 goto hllABAAA_done 
hllABAAA: 
 
 
 
 clrf rev 
hllABAAA_done: 
 
 
 
 
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
 
hllCBAAA:


 movfw ein1 
 xorwf ein2,w 
 btfsc STATUS,Z 
 goto hllEBAAA  
 


 bcf STATUS,C
 rrf min_lower,f



 bcf STATUS,C
 rrf fulmin,f


 btfss STATUS,C
 goto hllDBAAA
 

 bsf min_lower,7
hllDBAAA:




 incf ein1,f


 goto hllCBAAA
 

hllEBAAA:	

 
 
 
 
 
 btfss rev,0 
 goto hllFBAAA 



 movf fulmin2,w
 xorwf fulmin,f

 movf fulmin,w
 xorwf fulmin2,f

 movf fulmin2,w
 xorwf fulmin,f 
 
 
 movfw min_lower 
 movwf min2_lower 
 
 clrf min_lower
 
 
 
 
 
hllFBAAA: 

 banksel min_lower

 
 

hllGBAAA:	

 btfss neg,0
 goto hllHBAAA
 

 btfss neg,1
 goto hllHBAAA




 bsf minres,0

 goto hllYBAAA

 
 
 
 
hllHBAAA:
 

 btfss neg,0
 goto hllPBAAA 

 
hllIBAAA:

	
	
	
 movfw fulmin 
 subwf fulmin2,w 
 movwf mout 
 
 
 btfsc STATUS,C
 goto hllJBAAA		
		
	
 bsf minres,0	
	
	
 goto hllQBAAA	
	
hllJBAAA:

	
 movf mout,f
 btfsc STATUS,Z
 goto hllECAAA	
hllKBAAA:

	
 btfsc mout,7	
 goto hllMBAAA   
	
	
    
 bcf STATUS,C
 rlf mout,f
	
	
 btfss min_lower,7	
 goto hllLBAAA   

 
 decf mout,f	

	
 movlw .255
 xorwf mout,w
 btfss STATUS,Z
 goto hllLBAAA	
	
     
 bsf minres,0
 
	 
 goto hllQBAAA
	 

hllLBAAA:

   
 bcf STATUS,C
 rlf min_lower,f 

	
 decf ein1,f	

	
 goto hllKBAAA

hllMBAAA:
	
 btfss min_lower,7	
 goto hllOBAAA   
		
	
 decf mout,f

	
 movlw .255
 xorwf mout,w
 btfss STATUS,Z
 goto hllNBAAA	
		
     
 bsf minres,0	 
	 
	 
 goto hllQBAAA	 
	 
	 
hllNBAAA:
	
 movlw .127
 xorwf mout,w
 btfss STATUS,Z
 goto hllOBAAA	
	
	
	
	
 bcf STATUS,C
 rlf mout,f

	
 decf ein1,f	
	
	
 btfsc min_lower,6
 goto hllOBAAA 
	
	
 incf mout,f	
	
hllOBAAA:
	
 goto hllECAAA
hllPBAAA:
 

	
 btfss neg,1
 goto hllYBAAA 
 
	
hllQBAAA:

	
 movfw fulmin2
 subwf fulmin,w 
 movwf mout 

 
 btfsc STATUS,C
 goto hllRBAAA		
	
	
	
	
 bsf minres,0
	
	
 goto hllIBAAA	

hllRBAAA:

	
 movf mout,f 
 btfsc STATUS,Z 
 goto hllECAAA 
	
hllSBAAA:

	
 btfsc mout,7
 goto hllMBAAAb
 
 	
	
    
 bcf STATUS,C
 rlf mout,f 
	
	
 btfss min2_lower,7
 goto hllTBAAA

	
	
 decf mout,f	
	
	
 movlw .255
 xorwf mout,w
 btfss STATUS,Z
 goto hllTBAAA	
	

 bsf minres,0
	

 goto hllIBAAA
	
hllTBAAA:

 
 bcf STATUS,C
 rlf min2_lower,f
 

 decf ein1,f
   
	
 goto hllSBAAA	
hllMBAAAb:

	
 btfss min2_lower,7
 goto hllWBAAA

	
 decf mout,f	
	
	
 movlw .255
 xorwf mout,w
 btfss STATUS,Z
 goto hllVBAAA	
		
	
 bsf minres,0
 
	
 goto hllIBAAA
hllVBAAA:


	
 movlw .127
 xorwf mout,w
 btfss STATUS,Z
 goto hllWBAAA	
		
	
	
	
 bcf STATUS,C
 rlf mout,f 

	
 decf ein1,f	

	
 btfsc min2_lower,6
 goto hllWBAAA 
 
	
	
 incf mout,f	
	
hllWBAAA:

	
 goto hllECAAA

hllXBAAA:
	 
 movfw fulmin
 subwf fulmin2,w 
 movwf mout 
	 
	 
	 
     
 bsf minres,0	 
	
 goto hllECAAA

	
hllYBAAA:


 

	
 clrf mout_hi
	
	
	
 movf fulmin,w
 addwf fulmin2,w
 movwf mout
	
	

	
 btfss STATUS,C	
 goto hllZBAAA			
	
	
 incf mout_hi,f	
	
hllZBAAA:



	
 movf min_lower,w
 addwf min2_lower,w
 btfsc STATUS,C
 goto hllACAAA   
 

	
	
 andlw .128	
 btfss STATUS,Z
 goto hllACAAA	  
	
	
 goto hllBCAAA	
	
hllACAAA:


	
 incf mout,f	
	
	
 movf mout,f
 btfss STATUS,Z
 goto hllBCAAA 

	
 incf mout_hi,f

hllBCAAA:
	
 movf mout_hi,f
 btfsc STATUS,Z
 goto hllECAAA 

	
	
	
	
 clrf big_c
 bcf STATUS,C
 rrf fulmin,f
 btfsc STATUS,C
 bsf big_c,0
	
	
 bcf STATUS,C
 rrf min_lower,f

	
	
 btfss big_c,0
 goto hllCCAAA
	
	
	
 bsf min_lower,7	
	
hllCCAAA:

	
	
 clrf big_c
 bcf STATUS,C
 rrf fulmin2,f
 btfsc STATUS,C
 bsf big_c,0
	
	
	
	
 bcf STATUS,C
 rrf min2_lower,f
	
	
	
 btfss big_c,0
 goto hllDCAAA

	
	
	
 bsf min_lower,7		
	
hllDCAAA:

	
 incf ein1,f	
	
	
 goto hllYBAAA


hllECAAA:

 movfw mout 
 
 
 btfss STATUS,Z 
 goto hllFCAAA 
 
 
 
 movlw .0 

 PUSH
 
 
 
 movlw 0x80 
 PUSH
 
 
 
 goto hllGCAAA
 
 
 
hllFCAAA: 
 
 
 
 
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
 
hllGCAAA:
 
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

hllHCAAA:

 movf loop_count,w
 xorlw .16
 btfsc STATUS,Z
 goto hllMCAAA


 movf min,w
 andlw .128
 movwf a_hi_msb
 

 bcf STATUS,C
 rlf min2_lower,f



 bcf STATUS,C
 rlf run_total,f


 btfss STATUS,C
 goto hllICAAA


 incf min2_lower,f

hllICAAA:


 bcf STATUS,C
 rlf min,f 



 bcf STATUS,C
 rlf quotient_lo,f


 btfsc STATUS,C



 incf min,f


 movf a_hi_msb,f
 btfsc STATUS,Z
 goto hllJCAAA


 incf run_total,f


 btfsc STATUS,Z
 incf min2_lower,f

hllJCAAA:


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
 goto hllKCAAA



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


 goto hllLCAAA
hllKCAAA:


 movlw .1
 iorwf quotient_lo,f
hllLCAAA:



 incf loop_count,f


 goto hllHCAAA

hllMCAAA:


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
 goto hllNCAAA   
 incf mout,f 
 bsf rounded,0 
 
hllNCAAA:
 


 movf multiplier,f
 btfsc STATUS,Z
 goto hllQCAAA
 




 
 btfss mout,0
 goto hllOCAAA

 
 btfsc rounded,0
 goto hllOCAAA
 
 

 bcf STATUS,C
 rrf mout,f


 incf mout,f


 goto hllPCAAA

hllOCAAA:


 bcf STATUS,C 
 rrf mout,f

hllPCAAA:


 bsf mout,7

 goto hllRCAAA
hllQCAAA:
 decf util,f 
hllRCAAA:
 movfw mout 

hllSCAAA: 

  addlw -.128 
  movwf exam 
  btfss exam,7 
  goto hllTCAAA 
  addlw .128    

 
 decf util,f 
 bcf STATUS,C 
 
 
 
 rlf mout,f 
 movfw mout 
 goto hllSCAAA 

hllTCAAA: 


 movwf mout



 
 
 btfsc neg,0
 goto hllUCAAA 
 btfss neg,1
 goto hllWCAAA 
 goto hllVCAAA 
hllUCAAA: 
 btfsc neg,1
 goto hllWCAAA 

hllVCAAA: 

 
 
 
 
 movfw mout 
 iorlw .128 
 movwf mout 
 

hllWCAAA: 
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
 goto hllXCAAA
 POP
 goto hllHDAAA 
hllXCAAA:
 
 POP
 addlw .128
 banksel karg1
 movwf karg1 
 
 movfw karg2
 sublw .7
 
 movwf divisor 

 movlw high hllYCAAA 
 movwf PCLATH 
 movlw low hllYCAAA
 addwf divisor,w 
 btfsc STATUS,C 
 incf PCLATH,f 
 movwf PCL 


hllYCAAA:
 goto hllGDAAA
 goto hllFDAAA
 goto hllEDAAA 
 goto hllDDAAA
 goto hllCDAAA
 goto hllBDAAA
 goto hllADAAA
 goto hllZCAAA
 
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
 bcf STATUS,C 
 rrf karg1,f
 rrf util,f
hllFDAAA:
 bcf STATUS,C 
 rrf karg1,f
 rrf util,f
hllGDAAA:

hllHDAAA:
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
 goto hllIDAAA
 btfsc neg2,0
 goto hllIDAAA
 movlw .0

 PUSH
 
 goto hllSDAAA
hllIDAAA:






 
 btfsc neg,0
 goto hllJDAAA
 btfss neg2,0
 goto hllJDAAA
 movlw .1 
 PUSH
 
 goto hllSDAAA
hllJDAAA:



 
 
 bcf karg1,7
 bcf karg3,7


 
 
 
 

 
 
 
 
 
 

 btfsc karg4,7 
 goto hllKDAAA
 movf karg4,f
 btfsc STATUS,Z 
 goto hllKDAAA 
 

 movf karg2,f
 btfsc STATUS,Z
 goto hllMDAAA
 btfsc karg2,7
 goto hllMDAAA
 goto hllLDAAA
 
hllKDAAA: 

 btfsc karg2,7 
 goto hllMDAAA
 movf karg2,f
 btfsc STATUS,Z 
 goto hllMDAAA 
 goto hllRDAAA
hllLDAAA: 
 movfw 	karg2			
 subwf karg4,w    
 btfsc STATUS,C    
 goto hllMDAAA
 goto hllRDAAA



hllMDAAA: 



 





 btfsc karg2,7 
 goto hllNDAAA
 movf karg2,f
 btfsc STATUS,Z 
 goto hllNDAAA 
 

 movf karg4,f
 btfsc STATUS,Z
 goto hllPDAAA
 btfsc karg4,7
 goto hllPDAAA
 goto hllODAAA
 
hllNDAAA: 

 btfsc karg4,7 
 goto hllPDAAA
 movf karg4,f
 btfsc STATUS,Z 
 goto hllPDAAA 
 goto hllQDAAA
hllODAAA: 
 movfw 	karg4			
 subwf karg2,w    
 btfsc STATUS,C    
 goto hllPDAAA
 goto hllQDAAA
hllPDAAA: 








 
 
 
 
 movfw karg1
 subwf karg3,w
 btfss STATUS,C 
 goto hllRDAAA 
 
 movfw karg3
 subwf karg1,w
 btfss STATUS,C 
 goto hllQDAAA

 
 movlw .0 
 PUSH
 
 goto hllSDAAA 

 
hllQDAAA:
 banksel neg
 movlw .0 
 btfsc neg,0
 movlw .1 
 PUSH
 
 goto hllSDAAA 
hllRDAAA:
 banksel neg
 movlw .0 
 btfss neg,0
 movlw .1
 PUSH
 
hllSDAAA:
 
 return 
 



#undefine karg4


#undefine karg3


#undefine karg2


#undefine karg1


#undefine neg2


#undefine neg








 
 

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
 goto hllTDAAA
 movlw .127	
 
 andwf HLINDF,w 
 
 btfsc STATUS,Z
 goto hllBEAAA
 
hllTDAAA: 

 
 
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
 goto hllUDAAA
 movlw .127

 andwf HLINDF,w 
 btfsc STATUS,Z
 goto hllCEAAA
hllUDAAA:

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
 goto hllEEAAA 

hllVDAAA:

 
 POP


 banksel mout
 movwf mout 

 
 btfss mout,7 
 goto hllWDAAA 

 
 POP

 
 banksel util
 incf util,f 


 
 andlw .128 
 btfss STATUS,Z
 incf mout,f

 goto hllXDAAA 


hllWDAAA: 

 
 
 
 
 

 
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
 


hllXDAAA: 

 
 movfw mout 

 
 addlw -.128 

 
 movwf mout 

 
 btfsc neg,0
 goto hllYDAAA 
 btfss neg,1
 goto hllAEAAA 
 goto hllZDAAA 
hllYDAAA: 
 btfsc neg,1
 goto hllAEAAA 

hllZDAAA: 

 
 movfw mout 

 
 iorlw .128 

 
 movwf mout 


hllAEAAA: 

 
 movfw mout 

 
 PUSH

 
 banksel util
 movfw util 
 PUSH
 
 goto hllDEAAA 

hllBEAAA: 

 POP
 POP


hllCEAAA:
 POP

 
 movlw .128
 PUSH
 PUSH

 
 
hllDEAAA:
 
 return
 
 
 
 
hllEEAAA: 

 POP
 banksel factor1
 movwf factor1

 POP
 banksel factor2
 movwf factor2


 
 clrf hi_byte
 
 clrf make_mout
 
 clrf iterator

hllFEAAA:

 
 btfss factor1,0
 goto hllGEAAA

 
 
 movfw factor2
 addwf make_mout,f

 
 btfsc STATUS,C
 incf hi_byte,f


hllGEAAA:
 
 
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
 goto hllFEAAA

 
 movfw factor1 
 PUSH

 
 banksel make_mout
 movfw make_mout
 PUSH

 goto hllVDAAA 





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
 goto hllHEAAA 
 
 
 

 bcf arg1,7 
 movfw arg1 
 
 PUSH


 movlw .7
 PUSH
 
 goto hllPEAAA

hllHEAAA: 
 btfss arg1,6
 goto hllIEAAA 


 
 

 
 
 

 banksel arg1
 bcf arg1,6 
 bcf STATUS,C 
 rlf arg1,f
 movfw arg1
 PUSH

 movlw .6
 PUSH
 
 goto hllPEAAA
hllIEAAA: 

 btfss arg1,5
 goto hllJEAAA

 banksel arg1
 bcf arg1,5 
 bcf STATUS,C 
 rlf arg1,f
 rlf arg1,f
 movfw arg1
 PUSH

 movlw .5
 PUSH
 
 goto hllPEAAA
hllJEAAA: 

 btfss arg1,4
 goto hllKEAAA


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
 
 goto hllPEAAA
hllKEAAA: 

 btfss arg1,3
 goto hllLEAAA

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
 
 goto hllPEAAA

hllLEAAA: 

 btfss arg1,2
 goto hllMEAAA


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
 
 goto hllPEAAA

hllMEAAA: 

 btfss arg1,1
 goto hllNEAAA

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

 goto hllPEAAA
hllNEAAA: 
 btfss arg1,0
 goto hllOEAAA
 movlw .0
 PUSH

 movlw .0
 PUSH
 
 goto hllPEAAA
hllOEAAA:
 movlw .0
 PUSH

 movlw -.128
 PUSH
 
hllPEAAA:
 
 return




#undefine arg1

 end
