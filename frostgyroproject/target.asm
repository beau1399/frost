
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
 


 movlw GIE


   
 FAR_CALL hlluserprog ,safepush

   banksel INTCON
   movfw INTCON
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL hlluserprog,clearbit

 POP
 banksel INTCON
 movwf INTCON
 


 movlw SSPEN


   
 FAR_CALL hlluserprog ,safepush

   banksel SSP1CON1
   movfw SSP1CON1
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL hlluserprog,clearbit

 POP
 banksel SSP1CON1
 movwf SSP1CON1
 


 movlw .8 

   
 FAR_CALL hlluserprog ,safepush

 POP
 banksel SSP1CON1
 movwf SSP1CON1
 


 movlw .0 

   
 FAR_CALL hlluserprog ,safepush

 POP
 banksel SSP1CON2
 movwf SSP1CON2
 


 movlw .19 

   
 FAR_CALL hlluserprog ,safepush

 POP
 banksel SSP1ADD
 movwf SSP1ADD
 


 movlw .128 

   
 FAR_CALL hlluserprog ,safepush

 POP
 banksel SSP1STAT
 movwf SSP1STAT
 


 movlw .18 

   
 FAR_CALL hlluserprog ,safepush

 POP
 banksel TRISB
 movwf TRISB
 


 movlw ANSB4


   
 FAR_CALL hlluserprog ,safepush

   banksel ANSELB
   movfw ANSELB
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL hlluserprog,clearbit

 POP
 banksel ANSELB
 movwf ANSELB
 


 movlw ANSB1


   
 FAR_CALL hlluserprog ,safepush

   banksel ANSELB
   movfw ANSELB
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL hlluserprog,clearbit

 POP
 banksel ANSELB
 movwf ANSELB
 


 movlw SCIE


   
 FAR_CALL hlluserprog ,safepush


 movlw PCIE


   
 FAR_CALL hlluserprog ,safepush

   banksel SSP1CON3
   movfw SSP1CON3
   
   

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL setbit


 
 FAR_CALL hlluserprog,setbit

 POP
 banksel SSP1CON3
 movwf SSP1CON3
 


 movlw SSPEN


   
 FAR_CALL hlluserprog ,safepush

   banksel SSP1CON1
   movfw SSP1CON1
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL hlluserprog,setbit

 POP
 banksel SSP1CON1
 movwf SSP1CON1
 


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
 


 movlw .64 

   
 FAR_CALL hlluserprog ,safepush

 POP
 banksel SPBRG
 movwf SPBRG
 


 movlw .3 

   
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
 

 ; char 'O'


 movlw .79


   
 HALF_FAR_CALL safepush


 
 FAR_CALL hlluserprog,printch

 ; char 'K'


 movlw .75


   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL printch


 
 HALF_FAR_CALL iicstart


 
 HALF_FAR_CALL clearinterrupt


 
 FAR_CALL hlluserprog,checkack


 movlw .210 

   
 FAR_CALL hlluserprog ,safepush

 POP
 banksel SSP1BUF
 movwf SSP1BUF
 


 
 HALF_FAR_CALL clearinterrupt


 
 FAR_CALL hlluserprog,checkack


 movlw .107 

   
 FAR_CALL hlluserprog ,safepush

 POP
 banksel SSP1BUF
 movwf SSP1BUF
 


 
 HALF_FAR_CALL clearinterrupt


 
 FAR_CALL hlluserprog,checkack


 movlw .0 

   
 FAR_CALL hlluserprog ,safepush

 POP
 banksel SSP1BUF
 movwf SSP1BUF
 


 
 HALF_FAR_CALL clearinterrupt


 
 HALF_FAR_CALL checkack


 
 HALF_FAR_CALL iicend


 
 HALF_FAR_CALL clearinterrupt


 
 HALF_FAR_CALL delay


 
 FAR_CALL hlluserprog,loop

    
hllprogend:
 goto hllprogend
 

hllt450 CODE
loop:


 movlw ACKSTAT


   
 FAR_CALL loop ,safepush

   banksel SSP1CON2
   movfw SSP1CON2
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL loop,clearbit

 POP
 banksel SSP1CON2
 movwf SSP1CON2
 


 
 HALF_FAR_CALL iicstart


 
 FAR_CALL loop,clearinterrupt


 movlw .210 

   
 FAR_CALL loop ,safepush

 POP
 banksel SSPBUF
 movwf SSPBUF
 


 
 HALF_FAR_CALL clearinterrupt


 
 FAR_CALL loop,checkack


 movlw .61 

   
 FAR_CALL loop ,safepush

 POP
 banksel SSPBUF
 movwf SSPBUF
 


 
 HALF_FAR_CALL clearinterrupt


 
 FAR_CALL loop,checkack


 movlw RSEN


   
 FAR_CALL loop ,safepush

   banksel SSP1CON2
   movfw SSP1CON2
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL loop,setbit

 POP
 banksel SSP1CON2
 movwf SSP1CON2
 


 
 FAR_CALL loop,clearinterrupt


 movlw .211 

   
 FAR_CALL loop ,safepush

 POP
 banksel SSPBUF
 movwf SSPBUF
 


 
 HALF_FAR_CALL clearinterrupt


 
 FAR_CALL loop,checkack


 movlw RCEN


   
 FAR_CALL loop ,safepush

   banksel SSP1CON2
   movfw SSP1CON2
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL loop,setbit

 POP
 banksel SSP1CON2
 movwf SSP1CON2
 


 
 HALF_FAR_CALL clearfill


 
 FAR_CALL loop,clearinterrupt


 movlw SSP1IF


   
 FAR_CALL loop ,safepush

   banksel PIR1
   movfw PIR1
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL loop,clearbit

 POP
 banksel PIR1
 movwf PIR1
 

   banksel SSP1BUF
   movfw SSP1BUF
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL loop,printu


 movlw BF


   
 FAR_CALL loop ,safepush

   banksel SSP1STAT
   movfw SSP1STAT
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL loop,clearbit

 POP
 banksel SSP1STAT
 movwf SSP1STAT
 


 
 HALF_FAR_CALL nack


 
 HALF_FAR_CALL clearinterrupt


 
 HALF_FAR_CALL iicend


 
 FAR_CALL loop,clearinterrupt


 movlw .13

   
 HALF_FAR_CALL safepush


 
 FAR_CALL loop,printch


 movlw .10

   
 HALF_FAR_CALL safepush


 
 FAR_CALL loop,printch

 ;
 goto loop

 

hllt453 CODE
clearinterruptin:


 movlw SSP1IF


   
 FAR_CALL clearinterruptin ,safepush

   banksel PIR1
   movfw PIR1
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL clearinterruptin,getbit

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J1 
 
 
 goto hlllb51J2
 

hlllb51J1:

 ;

 goto clearinterruptin
hlllb51J2:

 return 

 

hllt454 CODE
clearinterrupt:


 
 FAR_CALL clearinterrupt,clearinterruptin


 movlw .3 

   
 FAR_CALL clearinterrupt ,safepush

   banksel PIR1
   movfw PIR1
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL clearinterrupt,clearbit

 POP
 banksel PIR1
 movwf PIR1
 


 return
 

hllt457 CODE
clearfill:


 movlw BF


   
 FAR_CALL clearfill ,safepush

   banksel SSP1STAT
   movfw SSP1STAT
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL clearfill,getbit

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J5 
 
 
 goto hlllb51J6
 

hlllb51J5:

 ;

 goto clearfill
hlllb51J6:

 return 

 

hllt458 CODE
ack:


 movlw ACKDT


   
 FAR_CALL ack ,safepush

   banksel SSP1CON2
   movfw SSP1CON2
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL ack,clearbit

 POP
 banksel SSP1CON2
 movwf SSP1CON2
 


 movlw ACKEN


   
 FAR_CALL ack ,safepush

   banksel SSP1CON2
   movfw SSP1CON2
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL ack,setbit

 POP
 banksel SSP1CON2
 movwf SSP1CON2
 


 return
 

hllt459 CODE
nack:


 movlw ACKDT


   
 FAR_CALL nack ,safepush

   banksel SSP1CON2
   movfw SSP1CON2
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL nack,setbit

 POP
 banksel SSP1CON2
 movwf SSP1CON2
 


 movlw ACKEN


   
 FAR_CALL nack ,safepush

   banksel SSP1CON2
   movfw SSP1CON2
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL nack,setbit

 POP
 banksel SSP1CON2
 movwf SSP1CON2
 


 return
 

hllt4512 CODE
checkack:

 movf FSR0L,w
 

 
 FAR_CALL checkack ,kpush


 movlw .6 

   
 FAR_CALL checkack ,safepush

   banksel SSP1CON2
   movfw SSP1CON2
   
   

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL getbit


 
 FAR_CALL checkack,notb

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J10 
 
 
 goto hlllb51J11
 

hlllb51J10:

 ; char 'E'


 movlw .69


   
 HALF_FAR_CALL safepush


 
 FAR_CALL checkack,printch

 ; char 'R'


 movlw .82


   
 HALF_FAR_CALL safepush


 
 FAR_CALL checkack,printch

 ; char 'R'


 movlw .82


   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL printch


 
 FAR_CALL checkack,checkack


hlllb51J11:


 
 FAR_CALL checkack,kpop
; LOAD POINTER

 movwf FSR0L
 

 return
 

hllt4513 CODE
delay:

 ; char ' '


 movlw .32


   
 HALF_FAR_CALL safepush


 
 FAR_CALL delay,printch

 ; char ' '


 movlw .32


   
 HALF_FAR_CALL safepush


 
 FAR_CALL delay,printch

 ; char ' '


 movlw .32


   
 HALF_FAR_CALL safepush


 
 FAR_CALL delay,printch

 ; char ' '


 movlw .32


   
 HALF_FAR_CALL safepush


 
 FAR_CALL delay,printch

 ; char ' '


 movlw .32


   
 HALF_FAR_CALL safepush


 
 FAR_CALL delay,printch

 ; char ' '


 movlw .32


   
 HALF_FAR_CALL safepush


 
 FAR_CALL delay,printch

 ; char ' '


 movlw .32


   
 HALF_FAR_CALL safepush


 
 FAR_CALL delay,printch

 ; char ' '


 movlw .32


   
 HALF_FAR_CALL safepush


 
 FAR_CALL delay,printch

 ; char ' '


 movlw .32


   
 HALF_FAR_CALL safepush


 
 FAR_CALL delay,printch

 ; char ' '


 movlw .32


   
 HALF_FAR_CALL safepush


 
 FAR_CALL delay,printch

 ; char ' '


 movlw .32


   
 HALF_FAR_CALL safepush


 
 FAR_CALL delay,printch

 ; char ' '


 movlw .32


   
 HALF_FAR_CALL safepush


 
 FAR_CALL delay,printch

 ; char ' '


 movlw .32


   
 HALF_FAR_CALL safepush


 
 FAR_CALL delay,printch

 ; char ' '


 movlw .32


   
 HALF_FAR_CALL safepush


 
 FAR_CALL delay,printch

 ; char ' '


 movlw .32


   
 HALF_FAR_CALL safepush


 
 FAR_CALL delay,printch

 ; char ' '


 movlw .32


   
 HALF_FAR_CALL safepush


 
 FAR_CALL delay,printch

 ; char ' '


 movlw .32


   
 HALF_FAR_CALL safepush


 
 FAR_CALL delay,printch

 ; char ' '


 movlw .32


   
 HALF_FAR_CALL safepush


 
 FAR_CALL delay,printch

 ; char ' '


 movlw .32


   
 HALF_FAR_CALL safepush


 
 FAR_CALL delay,printch

 ; char ' '


 movlw .32


   
 HALF_FAR_CALL safepush


 
 FAR_CALL delay,printch


 return
 

hllt4514 CODE
iicstart:


 movlw SEN


   
 FAR_CALL iicstart ,safepush

   banksel SSP1CON2
   movfw SSP1CON2
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL iicstart,setbit

 POP
 banksel SSP1CON2
 movwf SSP1CON2
 


 return
 

hllt4515 CODE
iicend:


 movlw PEN


   
 FAR_CALL iicend ,safepush

   banksel SSP1CON2
   movfw SSP1CON2
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL iicend,setbit

 POP
 banksel SSP1CON2
 movwf SSP1CON2
 


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

 end
