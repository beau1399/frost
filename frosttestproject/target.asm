
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
 PUSH 


 movlw .247 
 PUSH 

   banksel OSCCON
   movfw OSCCON
   
   
 PUSH 


 
 HALF_FAR_CALL andu


 
 FAR_CALL hlluserprog,oru

 POP
 banksel OSCCON
 movwf OSCCON
 


 movlw CREN

 PUSH 

   banksel RCSTA
   movfw RCSTA
   
   
 PUSH 


 
 FAR_CALL hlluserprog,setbit

 POP
 banksel RCSTA
 movwf RCSTA
 


 movlw BRGH

 PUSH 

   banksel TXSTA
   movfw TXSTA
   
   
 PUSH 


 
 FAR_CALL hlluserprog,setbit

 POP
 banksel TXSTA
 movwf TXSTA
 


 movlw BRG16

 PUSH 

   banksel BAUDCON
   movfw BAUDCON
   
   
 PUSH 


 
 FAR_CALL hlluserprog,setbit

 POP
 banksel BAUDCON
 movwf BAUDCON
 


 movlw .68 
 
 banksel SPBRG
 movwf SPBRG
 


 movlw .0 
 
 banksel SPBRGH
 movwf SPBRGH
 


 movlw TX9

 PUSH 


 movlw TXEN

 PUSH 


 movlw SYNC

 PUSH 

   banksel TXSTA
   movfw TXSTA
   
   
 PUSH 


 
 HALF_FAR_CALL clearbit


 
 HALF_FAR_CALL setbit


 
 FAR_CALL hlluserprog,clearbit

 POP
 banksel TXSTA
 movwf TXSTA
 


 movlw SCKP

 PUSH 

   banksel BAUDCON
   movfw BAUDCON
   
   
 PUSH 


 
 FAR_CALL hlluserprog,setbit

 POP
 banksel BAUDCON
 movwf BAUDCON
 


 movlw SPEN

 PUSH 

   banksel RCSTA
   movfw RCSTA
   
   
 PUSH 


 
 FAR_CALL hlluserprog,setbit

 POP
 banksel RCSTA
 movwf RCSTA
 


 movlw .5 
 PUSH 

   banksel TRISB
   movfw TRISB
   
   
 PUSH 


 
 FAR_CALL hlluserprog,clearbit

 POP
 banksel TRISB
 movwf TRISB
 


 movlw .5 
 PUSH 

   banksel ANSELB
   movfw ANSELB
   
   
 PUSH 


 
 FAR_CALL hlluserprog,clearbit

 POP
 banksel ANSELB
 movwf ANSELB
 


 movlw TXCKSEL

 PUSH 

   banksel APFCON1
   movfw APFCON1
   
   
 PUSH 


 
 FAR_CALL hlluserprog,setbit

 POP
 banksel APFCON1
 movwf APFCON1
 


 movlw .13
 PUSH 


 
 FAR_CALL hlluserprog,printch


 movlw .10
 PUSH 


 
 FAR_CALL hlluserprog,printch


 movlw .244
 


 PUSH 


 movlw .19
 

 PUSH 


 movlw .16
 


 PUSH 


 movlw .3
 

 PUSH 


 
 HALF_FAR_CALL divf


 
 FAR_CALL hlluserprog,printf

    
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

hllQAAAA:

 movf loop_count,w
 xorlw .16
 btfsc STATUS,Z
 goto hllVAAAA


 movf min,w
 andlw .128
 movwf a_hi_msb
 

 LSHIFT min2_lower



 LSHIFT run_total


 btfss STATUS,C
 goto hllRAAAA


 incf min2_lower,f

hllRAAAA:


 LSHIFT min



 LSHIFT quotient_lo


 btfsc STATUS,C



 incf min,f


 movf a_hi_msb,f
 btfsc STATUS,Z
 goto hllSAAAA


 incf run_total,f


 btfsc STATUS,Z
 incf min2_lower,f

hllSAAAA:


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
 goto hllTAAAA



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


 goto hllUAAAA
hllTAAAA:


 movlw .1
 iorwf quotient_lo,f
hllUAAAA:



 incf loop_count,f


 goto hllQAAAA

hllVAAAA:


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
 goto hllWAAAA   
 incf mout,f 
 bsf rounded,0 
 
hllWAAAA:
 


 movf multiplier,f
 btfsc STATUS,Z
 goto hllZAAAA
 




 
 btfss mout,0
 goto hllXAAAA

 
 btfsc rounded,0
 goto hllXAAAA
 
 

 RSHIFT mout
 

 incf mout,f


 goto hllYAAAA

hllXAAAA:


 RSHIFT mout
 
hllYAAAA:


 bsf mout,7

 goto hllABAAA
hllZAAAA:
 decf util,f 
hllABAAA:
 movfw mout 

hllBBAAA: 

  addlw -.128 
  movwf exam 
  btfss exam,7 
  goto hllCBAAA 
  addlw .128    

 
 decf util,f 

 
 LSHIFT mout
 movfw mout 
 goto hllBBAAA 

hllCBAAA: 


 movwf mout



 
 
 btfsc neg,0
 goto hllDBAAA 
 btfss neg,1
 goto hllFBAAA 
 goto hllEBAAA 
hllDBAAA: 
 btfsc neg,1
 goto hllFBAAA 

hllEBAAA: 

 
 
 
 
 movfw mout 
 iorlw .128 
 movwf mout 
 

hllFBAAA: 
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
 goto hllGBAAA
 
 movfw thk000
 andlw .127 
 movwf thk000 
 movlw '-' 
hllGBAAA: 
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
 goto hllGBAAA2 
 movfw thk001 
 xorlw .255 
 addlw .1
 movwf thk001 
 movlw '-' 
hllGBAAA2: 
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

 
 
 end
