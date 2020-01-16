
#include "hloe.inc"

 __config  _CONFIG1,_WDTE_OFF  & _BOREN_OFF & _FOSC_INTOSC & _PWRTE_OFF & _MCLRE_OFF & _CLKOUTEN_OFF & _IESO_OFF & _FCMEN_OFF
 __config  _CONFIG2,_PLLEN_ON & _STVREN_ON & _LVP_OFF

hllv2filtervalid UDATA
hllfiltervalidl RES .1

#define filtervalid hllfiltervalidl

hllv2fix UDATA
hllfixl RES .1

#define fix hllfixl

hllv2isgll UDATA
hllisglll RES .1

#define isgll hllisglll

hllv2latdeg UDATA
hlllatdegl RES .1

#define latdeg hlllatdegl

hllv2latdegb UDATA
hlllatdegbl RES .1

#define latdegb hlllatdegbl

hllv2latmin UDATA
hlllatminl RES .1

#define latmin hlllatminl

hllv2latminb UDATA
hlllatminbl RES .1

#define latminb hlllatminbl

hllv2latsubmin UDATA
hlllatsubminl RES .1

#define latsubmin hlllatsubminl

hllv2latsubminb UDATA
hlllatsubminbl RES .1

#define latsubminb hlllatsubminbl

hllv2londeg UDATA
hlllondegl RES .1

#define londeg hlllondegl

hllv2londegb UDATA
hlllondegbl RES .1

#define londegb hlllondegbl

hllv2lonmin UDATA
hlllonminl RES .1

#define lonmin hlllonminl

hllv2lonminb UDATA
hlllonminbl RES .1

#define lonminb hlllonminbl

hllv2lonsubmin UDATA
hlllonsubminl RES .1

#define lonsubmin hlllonsubminl

hllv2lonsubminb UDATA
hlllonsubminbl RES .1

#define lonsubminb hlllonsubminbl

hllv2scaler UDATA
hllscalerl RES .1

#define scaler hllscalerl

hllv2temp UDATA
hlltempl RES .1

#define temp hlltempl

hllv2tempb UDATA
hlltempbl RES .1

#define tempb hlltempbl



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

   banksel scaler
   movfw scaler
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL ISR,add

 POP
 banksel scaler
 movwf scaler
 

   banksel fix
   movfw fix
   
   

   
 FAR_CALL ISR ,safepush


 movlw .20 

   
 FAR_CALL ISR ,safepush

   banksel scaler
   movfw scaler
   
   

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL eq


 
 FAR_CALL ISR,andb

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J0 
 

 movlw .0 

   
 FAR_CALL ISR ,safepush

 POP
 banksel scaler
 movwf scaler
 

   banksel latdeg
   movfw latdeg
   
   

   
 FAR_CALL ISR ,safepush

   banksel latdegb
   movfw latdegb
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL ISR,printf

 ; char ' '


 movlw .32


   
 HALF_FAR_CALL safepush


 
 FAR_CALL ISR,printch

   banksel latmin
   movfw latmin
   
   

   
 FAR_CALL ISR ,safepush

   banksel latminb
   movfw latminb
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL ISR,printf

 ; char ' '


 movlw .32


   
 HALF_FAR_CALL safepush


 
 FAR_CALL ISR,printch

   banksel latsubmin
   movfw latsubmin
   
   

   
 FAR_CALL ISR ,safepush

   banksel latsubminb
   movfw latsubminb
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL ISR,printf


 movlw .13

   
 HALF_FAR_CALL safepush


 
 FAR_CALL ISR,printch


 movlw .10

   
 HALF_FAR_CALL safepush


 
 FAR_CALL ISR,printch

   banksel londeg
   movfw londeg
   
   

   
 FAR_CALL ISR ,safepush

   banksel londegb
   movfw londegb
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL ISR,printf

 ; char ' '


 movlw .32


   
 HALF_FAR_CALL safepush


 
 FAR_CALL ISR,printch

   banksel lonmin
   movfw lonmin
   
   

   
 FAR_CALL ISR ,safepush

   banksel lonminb
   movfw lonminb
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL ISR,printf

 ; char ' '


 movlw .32


   
 HALF_FAR_CALL safepush


 
 FAR_CALL ISR,printch

   banksel lonsubmin
   movfw lonsubmin
   
   

   
 FAR_CALL ISR ,safepush

   banksel lonsubminb
   movfw lonsubminb
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL ISR,printf


 movlw .13

   
 HALF_FAR_CALL safepush


 
 FAR_CALL ISR,printch


 movlw .10

   
 HALF_FAR_CALL safepush


 
 FAR_CALL ISR,printch

 
 goto hlllb51J1
 

hlllb51J0:


hlllb51J1:


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
 

 movlw .0 

   
 FAR_CALL hlluserprog ,safepush

 POP
 banksel filtervalid
 movwf filtervalid
 


 movlw .0 

   
 FAR_CALL hlluserprog ,safepush

 POP
 banksel fix
 movwf fix
 


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
 


 movlw SCKP


   
 FAR_CALL hlluserprog ,safepush

   banksel BAUDCON
   movfw BAUDCON
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL hlluserprog,clearbit

 POP
 banksel BAUDCON
 movwf BAUDCON
 


 movlw .0 

   
 FAR_CALL hlluserprog ,safepush

 POP
 banksel isgll
 movwf isgll
 


 movlw .0 

   
 FAR_CALL hlluserprog ,safepush

 POP
 banksel scaler
 movwf scaler
 


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
 


 
 FAR_CALL hlluserprog,mainloop

    
hllprogend:
 goto hllprogend
 

hllt452 CODE
mainloop:


 
 FAR_CALL mainloop,dofunc

 ;
 goto mainloop

 

hllt453 CODE
dofunc:

 movf FSR0L,w
 

 
 FAR_CALL dofunc ,kpush


 movlw .0 

   
 HALF_FAR_CALL safepush


 
 FAR_CALL dofunc,getch


 movlw .1

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL receive


 
 FAR_CALL dofunc,kpop
; LOAD POINTER

 movwf FSR0L
 

 return
 

hllt4514 CODE
receive:

 movf FSR0L,w
 

 
 FAR_CALL receive ,kpush


 movlw .1

   
 HALF_FAR_CALL safepush


 
 FAR_CALL receive,parm

 ; char ','


 movlw .44


   
 HALF_FAR_CALL safepush


 
 FAR_CALL receive,eq

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J12 
 
   banksel isgll
   movfw isgll
   
   

   
 FAR_CALL receive ,safepush


 movlw .2

   
 HALF_FAR_CALL safepush


 
 FAR_CALL receive,geu

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J8 
 

 movlw -.1

   
 FAR_CALL receive ,safepush

   banksel isgll
   movfw isgll
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL receive,add

 POP
 banksel isgll
 movwf isgll
 


 movlw .0

   
 HALF_FAR_CALL safepush


 
 FAR_CALL receive,parm

 POP
 banksel temp
 movwf temp
 


 
 HALF_FAR_CALL dispose


 
 FAR_CALL receive,getch


 movlw .1 

   
 FAR_CALL receive ,safepush

   banksel temp
   movfw temp
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL receive,add

 ;KDISCARD 


 
 FAR_CALL receive,receive


 movlw .1 

   
 FAR_CALL receive ,safepush

 
 goto hlllb51J9
 

hlllb51J8:

   banksel isgll
   movfw isgll
   
   

   
 FAR_CALL receive ,safepush


 movlw .1

   
 HALF_FAR_CALL safepush


 
 FAR_CALL receive,eq

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J6 
 

 movlw .0

   
 FAR_CALL receive ,safepush

 POP
 banksel isgll
 movwf isgll
 


 
 FAR_CALL receive,purge

 
 goto hlllb51J7
 

hlllb51J6:


 movlw .2

   
 HALF_FAR_CALL safepush


 
 FAR_CALL receive,parm

 ; char 'L'


 movlw .76


   
 HALF_FAR_CALL safepush


 
 FAR_CALL receive,eq


 movlw .3

   
 HALF_FAR_CALL safepush


 
 FAR_CALL receive,parm

 ; char 'L'


 movlw .76


   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL eq


 
 FAR_CALL receive,andb

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J4 
 

 movlw .4

   
 FAR_CALL receive ,safepush

 POP
 banksel isgll
 movwf isgll
 

 
 goto hlllb51J5
 

hlllb51J4:


hlllb51J5:


hlllb51J7:


hlllb51J9:

 
 goto hlllb51J13
 

hlllb51J12:


 movlw .0

   
 HALF_FAR_CALL safepush


 
 FAR_CALL receive,parm


 movlw .28

   
 HALF_FAR_CALL safepush


 
 FAR_CALL receive,geu

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J10 
 

 movlw .0 

   
 FAR_CALL receive ,safepush

 POP
 banksel filtervalid
 movwf filtervalid
 

 
 goto hlllb51J11
 

hlllb51J10:


 movlw .0

   
 HALF_FAR_CALL safepush


 
 FAR_CALL receive,parm

 POP
 banksel temp
 movwf temp
 


 
 HALF_FAR_CALL dispose


 
 FAR_CALL receive,getch


 movlw .1 

   
 FAR_CALL receive ,safepush

   banksel temp
   movfw temp
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL receive,add

 ;


 KDISCARD 
 goto receive
hlllb51J11:
hlllb51J13:

 KDISCARD 
 return 

 

hllt4523 CODE
purge:

 movf FSR0L,w
 

 
 FAR_CALL purge ,kpush


 movlw .0

   
 HALF_FAR_CALL safepush


 
 FAR_CALL purge,parm


 movlw .27

   
 HALF_FAR_CALL safepush


 
 FAR_CALL purge,eq

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J21 
 

 movlw .0
 



   
 FAR_CALL purge ,safepush


 movlw .128
 


   
 FAR_CALL purge ,safepush


 movlw .32
 



   
 FAR_CALL purge ,safepush


 movlw .3
 


   
 FAR_CALL purge ,safepush


 movlw -.1

   
 FAR_CALL purge ,safepush

 ; char '0'


 movlw .48


   
 HALF_FAR_CALL safepush


 
 FAR_CALL purge,mul


 movlw .27

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL parm


 
 HALF_FAR_CALL add


 
 HALF_FAR_CALL utof


 
 HALF_FAR_CALL mulf


 
 FAR_CALL purge,addf


 movlw -.1

   
 FAR_CALL purge ,safepush

 ; char '0'


 movlw .48


   
 HALF_FAR_CALL safepush


 
 FAR_CALL purge,mul


 movlw .26

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL parm


 
 HALF_FAR_CALL add


 
 HALF_FAR_CALL utof


 
 FAR_CALL purge,addf

 POP
 banksel latdegb
 movwf latdegb
 

 POP
 banksel latdeg
 movwf latdeg
 


 movlw .0
 



   
 FAR_CALL purge ,safepush


 movlw .128
 


   
 FAR_CALL purge ,safepush


 movlw .72
 



   
 FAR_CALL purge ,safepush


 movlw .6
 


   
 FAR_CALL purge ,safepush


 movlw -.1

   
 FAR_CALL purge ,safepush

 ; char '0'


 movlw .48


   
 HALF_FAR_CALL safepush


 
 FAR_CALL purge,mul


 movlw .14

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL parm


 
 HALF_FAR_CALL add


 
 HALF_FAR_CALL utof


 
 HALF_FAR_CALL mulf


 
 FAR_CALL purge,addf


 movlw .32
 



   
 FAR_CALL purge ,safepush


 movlw .3
 


   
 FAR_CALL purge ,safepush


 movlw -.1

   
 FAR_CALL purge ,safepush

 ; char '0'


 movlw .48


   
 HALF_FAR_CALL safepush


 
 FAR_CALL purge,mul


 movlw .13

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL parm


 
 HALF_FAR_CALL add


 
 HALF_FAR_CALL utof


 
 HALF_FAR_CALL mulf


 
 FAR_CALL purge,addf


 movlw -.1

   
 FAR_CALL purge ,safepush

 ; char '0'


 movlw .48


   
 HALF_FAR_CALL safepush


 
 FAR_CALL purge,mul


 movlw .12

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL parm


 
 HALF_FAR_CALL add


 
 HALF_FAR_CALL utof


 
 FAR_CALL purge,addf

 POP
 banksel londegb
 movwf londegb
 

 POP
 banksel londeg
 movwf londeg
 


 movlw .0
 



   
 FAR_CALL purge ,safepush


 movlw .128
 


   
 FAR_CALL purge ,safepush


 movlw .32
 



   
 FAR_CALL purge ,safepush


 movlw .3
 


   
 FAR_CALL purge ,safepush


 movlw -.1

   
 FAR_CALL purge ,safepush

 ; char '0'


 movlw .48


   
 HALF_FAR_CALL safepush


 
 FAR_CALL purge,mul


 movlw .25

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL parm


 
 HALF_FAR_CALL add


 
 HALF_FAR_CALL utof


 
 HALF_FAR_CALL mulf


 
 FAR_CALL purge,addf


 movlw -.1

   
 FAR_CALL purge ,safepush

 ; char '0'


 movlw .48


   
 HALF_FAR_CALL safepush


 
 FAR_CALL purge,mul


 movlw .24

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL parm


 
 HALF_FAR_CALL add


 
 HALF_FAR_CALL utof


 
 FAR_CALL purge,addf

 POP
 banksel tempb
 movwf tempb
 

 POP
 banksel temp
 movwf temp
 

   banksel temp
   movfw temp
   
   

   
 FAR_CALL purge ,safepush

   banksel latmin
   movfw latmin
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL purge,eq

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J15 
 
 
 goto hlllb51J16
 

hlllb51J15:


 movlw .0 

   
 FAR_CALL purge ,safepush

 POP
 banksel filtervalid
 movwf filtervalid
 


hlllb51J16:

   banksel tempb
   movfw tempb
   
   

   
 FAR_CALL purge ,safepush

 POP
 banksel latminb
 movwf latminb
 

   banksel temp
   movfw temp
   
   

   
 FAR_CALL purge ,safepush

 POP
 banksel latmin
 movwf latmin
 


 movlw .0
 



   
 FAR_CALL purge ,safepush


 movlw .128
 


   
 FAR_CALL purge ,safepush


 movlw .32
 



   
 FAR_CALL purge ,safepush


 movlw .3
 


   
 FAR_CALL purge ,safepush


 movlw -.1

   
 FAR_CALL purge ,safepush

 ; char '0'


 movlw .48


   
 HALF_FAR_CALL safepush


 
 FAR_CALL purge,mul


 movlw .11

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL parm


 
 HALF_FAR_CALL add


 
 HALF_FAR_CALL utof


 
 HALF_FAR_CALL mulf


 
 FAR_CALL purge,addf


 movlw -.1

   
 FAR_CALL purge ,safepush

 ; char '0'


 movlw .48


   
 HALF_FAR_CALL safepush


 
 FAR_CALL purge,mul


 movlw .10

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL parm


 
 HALF_FAR_CALL add


 
 HALF_FAR_CALL utof


 
 FAR_CALL purge,addf

 POP
 banksel tempb
 movwf tempb
 

 POP
 banksel temp
 movwf temp
 

   banksel tempb
   movfw tempb
   
   

   
 FAR_CALL purge ,safepush

 POP
 banksel lonminb
 movwf lonminb
 

   banksel temp
   movfw temp
   
   

   
 FAR_CALL purge ,safepush

 POP
 banksel lonmin
 movwf lonmin
 


 movlw .0
 



   
 FAR_CALL purge ,safepush


 movlw .128
 


   
 FAR_CALL purge ,safepush


 movlw .0
 



   
 FAR_CALL purge ,safepush


 movlw .128
 


   
 FAR_CALL purge ,safepush


 movlw .0
 



   
 FAR_CALL purge ,safepush


 movlw .128
 


   
 FAR_CALL purge ,safepush


 movlw .28
 



   
 FAR_CALL purge ,safepush


 movlw .13
 


   
 FAR_CALL purge ,safepush


 movlw -.1

   
 FAR_CALL purge ,safepush

 ; char '0'


 movlw .48


   
 HALF_FAR_CALL safepush


 
 FAR_CALL purge,mul


 movlw .22

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL parm


 
 HALF_FAR_CALL add


 
 HALF_FAR_CALL utof


 
 HALF_FAR_CALL mulf


 
 FAR_CALL purge,addf


 movlw .122
 



   
 FAR_CALL purge ,safepush


 movlw .9
 


   
 FAR_CALL purge ,safepush


 movlw -.1

   
 FAR_CALL purge ,safepush

 ; char '0'


 movlw .48


   
 HALF_FAR_CALL safepush


 
 FAR_CALL purge,mul


 movlw .21

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL parm


 
 HALF_FAR_CALL add


 
 HALF_FAR_CALL utof


 
 HALF_FAR_CALL mulf


 
 FAR_CALL purge,addf


 movlw .72
 



   
 FAR_CALL purge ,safepush


 movlw .6
 


   
 FAR_CALL purge ,safepush


 movlw -.1

   
 FAR_CALL purge ,safepush

 ; char '0'


 movlw .48


   
 HALF_FAR_CALL safepush


 
 FAR_CALL purge,mul


 movlw .20

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL parm


 
 HALF_FAR_CALL add


 
 HALF_FAR_CALL utof


 
 HALF_FAR_CALL mulf


 
 FAR_CALL purge,addf


 movlw .32
 



   
 FAR_CALL purge ,safepush


 movlw .3
 


   
 FAR_CALL purge ,safepush


 movlw -.1

   
 FAR_CALL purge ,safepush

 ; char '0'


 movlw .48


   
 HALF_FAR_CALL safepush


 
 FAR_CALL purge,mul


 movlw .19

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL parm


 
 HALF_FAR_CALL add


 
 HALF_FAR_CALL utof


 
 HALF_FAR_CALL mulf


 
 FAR_CALL purge,addf


 movlw -.1

   
 FAR_CALL purge ,safepush

 ; char '0'


 movlw .48


   
 HALF_FAR_CALL safepush


 
 FAR_CALL purge,mul


 movlw .18

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL parm


 
 HALF_FAR_CALL add


 
 HALF_FAR_CALL utof


 
 FAR_CALL purge,addf


 movlw .67
 



   
 FAR_CALL purge ,safepush


 movlw .16
 


   
 HALF_FAR_CALL safepush


 
 FAR_CALL purge,divf

 POP
 banksel tempb
 movwf tempb
 

 POP
 banksel temp
 movwf temp
 

   banksel filtervalid
   movfw filtervalid
   
   

   
 FAR_CALL purge ,safepush

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J17 
 

 movlw .0
 



   
 FAR_CALL purge ,safepush


 movlw .255
 


   
 FAR_CALL purge ,safepush

   banksel temp
   movfw temp
   
   

   
 FAR_CALL purge ,safepush

   banksel tempb
   movfw tempb
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL purge,mulf


 movlw .0
 



   
 FAR_CALL purge ,safepush


 movlw .255
 


   
 FAR_CALL purge ,safepush

   banksel latsubmin
   movfw latsubmin
   
   

   
 FAR_CALL purge ,safepush

   banksel latsubminb
   movfw latsubminb
   
   

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL mulf


 
 FAR_CALL purge,addf

 POP
 banksel latsubminb
 movwf latsubminb
 

 POP
 banksel latsubmin
 movwf latsubmin
 

 
 goto hlllb51J18
 

hlllb51J17:

   banksel tempb
   movfw tempb
   
   

   
 FAR_CALL purge ,safepush

 POP
 banksel latsubminb
 movwf latsubminb
 

   banksel temp
   movfw temp
   
   

   
 FAR_CALL purge ,safepush

 POP
 banksel latsubmin
 movwf latsubmin
 


hlllb51J18:


 movlw .0
 



   
 FAR_CALL purge ,safepush


 movlw .128
 


   
 FAR_CALL purge ,safepush


 movlw .0
 



   
 FAR_CALL purge ,safepush


 movlw .128
 


   
 FAR_CALL purge ,safepush


 movlw .0
 



   
 FAR_CALL purge ,safepush


 movlw .128
 


   
 FAR_CALL purge ,safepush


 movlw .28
 



   
 FAR_CALL purge ,safepush


 movlw .13
 


   
 FAR_CALL purge ,safepush


 movlw -.1

   
 FAR_CALL purge ,safepush

 ; char '0'


 movlw .48


   
 HALF_FAR_CALL safepush


 
 FAR_CALL purge,mul


 movlw .8

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL parm


 
 HALF_FAR_CALL add


 
 HALF_FAR_CALL utof


 
 HALF_FAR_CALL mulf


 
 FAR_CALL purge,addf


 movlw .122
 



   
 FAR_CALL purge ,safepush


 movlw .9
 


   
 FAR_CALL purge ,safepush


 movlw -.1

   
 FAR_CALL purge ,safepush

 ; char '0'


 movlw .48


   
 HALF_FAR_CALL safepush


 
 FAR_CALL purge,mul


 movlw .7

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL parm


 
 HALF_FAR_CALL add


 
 HALF_FAR_CALL utof


 
 HALF_FAR_CALL mulf


 
 FAR_CALL purge,addf


 movlw .72
 



   
 FAR_CALL purge ,safepush


 movlw .6
 


   
 FAR_CALL purge ,safepush


 movlw -.1

   
 FAR_CALL purge ,safepush

 ; char '0'


 movlw .48


   
 HALF_FAR_CALL safepush


 
 FAR_CALL purge,mul


 movlw .6

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL parm


 
 HALF_FAR_CALL add


 
 HALF_FAR_CALL utof


 
 HALF_FAR_CALL mulf


 
 FAR_CALL purge,addf


 movlw .32
 



   
 FAR_CALL purge ,safepush


 movlw .3
 


   
 FAR_CALL purge ,safepush


 movlw -.1

   
 FAR_CALL purge ,safepush

 ; char '0'


 movlw .48


   
 HALF_FAR_CALL safepush


 
 FAR_CALL purge,mul


 movlw .5

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL parm


 
 HALF_FAR_CALL add


 
 HALF_FAR_CALL utof


 
 HALF_FAR_CALL mulf


 
 FAR_CALL purge,addf


 movlw -.1

   
 FAR_CALL purge ,safepush

 ; char '0'


 movlw .48


   
 HALF_FAR_CALL safepush


 
 FAR_CALL purge,mul


 movlw .4

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL parm


 
 HALF_FAR_CALL add


 
 HALF_FAR_CALL utof


 
 FAR_CALL purge,addf


 movlw .67
 



   
 FAR_CALL purge ,safepush


 movlw .16
 


   
 HALF_FAR_CALL safepush


 
 FAR_CALL purge,divf

 POP
 banksel tempb
 movwf tempb
 

 POP
 banksel temp
 movwf temp
 

   banksel filtervalid
   movfw filtervalid
   
   

   
 FAR_CALL purge ,safepush

 POP
 xorlw .0
 btfsc STATUS,Z
 goto hlllb51J19 
 

 movlw .0
 



   
 FAR_CALL purge ,safepush


 movlw .255
 


   
 FAR_CALL purge ,safepush

   banksel temp
   movfw temp
   
   

   
 FAR_CALL purge ,safepush

   banksel tempb
   movfw tempb
   
   

   
 HALF_FAR_CALL safepush


 
 FAR_CALL purge,mulf


 movlw .0
 



   
 FAR_CALL purge ,safepush


 movlw .255
 


   
 FAR_CALL purge ,safepush

   banksel lonsubmin
   movfw lonsubmin
   
   

   
 FAR_CALL purge ,safepush

   banksel lonsubminb
   movfw lonsubminb
   
   

   
 HALF_FAR_CALL safepush


 
 HALF_FAR_CALL mulf


 
 FAR_CALL purge,addf

 POP
 banksel lonsubminb
 movwf lonsubminb
 

 POP
 banksel lonsubmin
 movwf lonsubmin
 

 
 goto hlllb51J20
 

hlllb51J19:

   banksel tempb
   movfw tempb
   
   

   
 FAR_CALL purge ,safepush

 POP
 banksel lonsubminb
 movwf lonsubminb
 

   banksel temp
   movfw temp
   
   

   
 FAR_CALL purge ,safepush

 POP
 banksel lonsubmin
 movwf lonsubmin
 


 movlw .1 

   
 FAR_CALL purge ,safepush

 POP
 banksel filtervalid
 movwf filtervalid
 


 movlw .1 

   
 FAR_CALL purge ,safepush

 POP
 banksel fix
 movwf fix
 


hlllb51J20:

 
 goto hlllb51J22
 

hlllb51J21:


hlllb51J22:


 KDISCARD


 return
 
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
 goto hllUAAAA
 
 btfss ein1,7
 goto hllSAAAA
 
 goto hllWAAAA
hllSAAAA: 
 
 movfw ein1
 subwf ein2,w    
 btfss STATUS,C 
 goto hllVAAAA  
hllTAAAA:
 goto hllWAAAA  
hllUAAAA:   
 
 
 btfsc ein1,7
 goto hllSAAAA  
hllVAAAA:  
 
 


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
 
 
 
 goto hllWAAAA_done 
hllWAAAA: 
 
 
 
 clrf rev 
hllWAAAA_done: 
 
 
 
 
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
 
hllYAAAA:


 movfw ein1 
 xorwf ein2,w 
 btfsc STATUS,Z 
 goto hllABAAA  
 


 RSHIFT min_lower
 


 RSHIFT fulmin
 

 btfss STATUS,C
 goto hllZAAAA
 

 bsf min_lower,7
hllZAAAA:




 incf ein1,f


 goto hllYAAAA
 

hllABAAA:	

 
 
 
 
 
 btfss rev,0 
 goto hllBBAAA 



 movf fulmin2,w
 xorwf fulmin,f

 movf fulmin,w
 xorwf fulmin2,f

 movf fulmin2,w
 xorwf fulmin,f 
 
 
 movfw min_lower 
 movwf min2_lower 
 
 clrf min_lower
 
 
 
 
 
hllBBAAA: 

 banksel min_lower

 
 

hllCBAAA:	

 btfss neg,0
 goto hllDBAAA
 

 btfss neg,1
 goto hllDBAAA




 bsf minres,0

 goto hllUBAAA

 
 
 
 
hllDBAAA:
 

 btfss neg,0
 goto hllLBAAA 

 
hllEBAAA:

	
	
	
 movfw fulmin 
 subwf fulmin2,w 
 movwf mout 
 
 
 btfsc STATUS,C
 goto hllFBAAA		
		
	
 bsf minres,0	
	
	
 goto hllMBAAA	
	
hllFBAAA:

	
 movf mout,f
 btfsc STATUS,Z
 goto hllACAAA	
hllGBAAA:

	
 btfsc mout,7	
 goto hllIBAAA   
	
	
    
 LSHIFT mout
 
	
 btfss min_lower,7	
 goto hllHBAAA   

 
 decf mout,f	

	
 movlw .255
 xorwf mout,w
 btfss STATUS,Z
 goto hllHBAAA	
	
     
 bsf minres,0
 
	 
 goto hllMBAAA
	 

hllHBAAA:

   
 LSHIFT min_lower
 
	
 decf ein1,f	

	
 goto hllGBAAA

hllIBAAA:
	
 btfss min_lower,7	
 goto hllKBAAA   
		
	
 decf mout,f

	
 movlw .255
 xorwf mout,w
 btfss STATUS,Z
 goto hllJBAAA	
		
     
 bsf minres,0	 
	 
	 
 goto hllMBAAA	 
	 
	 
hllJBAAA:
	
 movlw .127
 xorwf mout,w
 btfss STATUS,Z
 goto hllKBAAA	
	
	
	
	
 LSHIFT mout
	
	
 decf ein1,f	
	
	
 btfsc min_lower,6
 goto hllKBAAA 
	
	
 incf mout,f	
	
hllKBAAA:
	
 goto hllACAAA
hllLBAAA:
 

	
 btfss neg,1
 goto hllUBAAA 
 
	
hllMBAAA:

	
 movfw fulmin2
 subwf fulmin,w 
 movwf mout 

 
 btfsc STATUS,C
 goto hllNBAAA		
	
	
	
	
 bsf minres,0
	
	
 goto hllEBAAA	

hllNBAAA:

	
 movf mout,f 
 btfsc STATUS,Z 
 goto hllACAAA 
	
hllOBAAA:

	
 btfsc mout,7
 goto hllIBAAAb
 
 	
	
    
 LSHIFT mout 
 
	
 btfss min2_lower,7
 goto hllPBAAA

	
	
 decf mout,f	
	
	
 movlw .255
 xorwf mout,w
 btfss STATUS,Z
 goto hllPBAAA	
	

 bsf minres,0
	

 goto hllEBAAA
	
hllPBAAA:

 
 LSHIFT min2_lower
 

 decf ein1,f
   
	
 goto hllOBAAA	
hllIBAAAb:

	
 btfss min2_lower,7
 goto hllSBAAA

	
 decf mout,f	
	
	
 movlw .255
 xorwf mout,w
 btfss STATUS,Z
 goto hllRBAAA	
		
	
 bsf minres,0
 
	
 goto hllEBAAA
hllRBAAA:


	
 movlw .127
 xorwf mout,w
 btfss STATUS,Z
 goto hllSBAAA	
		
	
	
	
 LSHIFT mout

	
 decf ein1,f	

	
 btfsc min2_lower,6
 goto hllSBAAA 
 
	
	
 incf mout,f	
	
hllSBAAA:

	
 goto hllACAAA

hllTBAAA:
	 
 movfw fulmin
 subwf fulmin2,w 
 movwf mout 
	 
	 
	 
     
 bsf minres,0	 
	
 goto hllACAAA

	
hllUBAAA:


 

	
 clrf mout_hi
	
	
	
 movf fulmin,w
 addwf fulmin2,w
 movwf mout
	
	

	
 btfss STATUS,C	
 goto hllVBAAA			
	
	
 incf mout_hi,f	
	
hllVBAAA:



	
 movf min_lower,w
 addwf min2_lower,w
 btfsc STATUS,C
 goto hllWBAAA   
 

	
	
 andlw .128	
 btfss STATUS,Z
 goto hllWBAAA	  
	
	
 goto hllXBAAA	
	
hllWBAAA:


	
 incf mout,f	
	
	
 movf mout,f
 btfss STATUS,Z
 goto hllXBAAA 

	
 incf mout_hi,f

hllXBAAA:
	
 movf mout_hi,f
 btfsc STATUS,Z
 goto hllACAAA 

	
	
	
	
 clrf big_c
 RSHIFT fulmin
 btfsc STATUS,C
 bsf big_c,0
	
	
 RSHIFT min_lower

	
	
 btfss big_c,0
 goto hllYBAAA
	
	
	
 bsf min_lower,7	
	
hllYBAAA:

	
	
 clrf big_c
 RSHIFT fulmin2
 btfsc STATUS,C
 bsf big_c,0
	
	
	
	
 RSHIFT min2_lower
	
	
	
 btfss big_c,0
 goto hllZBAAA

	
	
	
 bsf min_lower,7		
	
hllZBAAA:

	
 incf ein1,f	
	
	
 goto hllUBAAA


hllACAAA:

 movfw mout 
 
 
 btfss STATUS,Z 
 goto hllBCAAA 
 
 
 
 movlw .0 

 PUSH
 
 
 
 movlw 0x80 
 PUSH
 
 
 
 goto hllCCAAA
 
 
 
hllBCAAA: 
 
 
 
 
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
 
hllCCAAA:
 
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

hllDCAAA:

 movf loop_count,w
 xorlw .16
 btfsc STATUS,Z
 goto hllICAAA


 movf min,w
 andlw .128
 movwf a_hi_msb
 

 LSHIFT min2_lower



 LSHIFT run_total


 btfss STATUS,C
 goto hllECAAA


 incf min2_lower,f

hllECAAA:


 LSHIFT min



 LSHIFT quotient_lo


 btfsc STATUS,C



 incf min,f


 movf a_hi_msb,f
 btfsc STATUS,Z
 goto hllFCAAA


 incf run_total,f


 btfsc STATUS,Z
 incf min2_lower,f

hllFCAAA:


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
 goto hllGCAAA



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


 goto hllHCAAA
hllGCAAA:


 movlw .1
 iorwf quotient_lo,f
hllHCAAA:



 incf loop_count,f


 goto hllDCAAA

hllICAAA:


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
 goto hllJCAAA   
 incf mout,f 
 bsf rounded,0 
 
hllJCAAA:
 


 movf multiplier,f
 btfsc STATUS,Z
 goto hllMCAAA
 




 
 btfss mout,0
 goto hllKCAAA

 
 btfsc rounded,0
 goto hllKCAAA
 
 

 RSHIFT mout
 

 incf mout,f


 goto hllLCAAA

hllKCAAA:


 RSHIFT mout
 
hllLCAAA:


 bsf mout,7

 goto hllNCAAA
hllMCAAA:
 decf util,f 
hllNCAAA:
 movfw mout 

hllOCAAA: 

  addlw -.128 
  movwf exam 
  btfss exam,7 
  goto hllPCAAA 
  addlw .128    

 
 decf util,f 

 
 LSHIFT mout
 movfw mout 
 goto hllOCAAA 

hllPCAAA: 


 movwf mout



 
 
 btfsc neg,0
 goto hllQCAAA 
 btfss neg,1
 goto hllSCAAA 
 goto hllRCAAA 
hllQCAAA: 
 btfsc neg,1
 goto hllSCAAA 

hllRCAAA: 

 
 
 
 
 movfw mout 
 iorlw .128 
 movwf mout 
 

hllSCAAA: 
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
 goto hllTCAAA
 movlw .127	
 
 andwf HLINDF,w 
 
 btfsc STATUS,Z
 goto hllBDAAA
 
hllTCAAA: 

 
 
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
 goto hllUCAAA
 movlw .127

 andwf HLINDF,w 
 btfsc STATUS,Z
 goto hllCDAAA
hllUCAAA:

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
 goto hllEDAAA 

hllVCAAA:

 
 POP


 banksel mout
 movwf mout 

 
 btfss mout,7 
 goto hllWCAAA 

 
 POP

 
 banksel util
 incf util,f 


 
 andlw .128 
 btfss STATUS,Z
 incf mout,f

 goto hllXCAAA 


hllWCAAA: 

 
 
 
 
 

 
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
 


hllXCAAA: 

 
 movfw mout 

 
 addlw -.128 

 
 movwf mout 

 
 btfsc neg,0
 goto hllYCAAA 
 btfss neg,1
 goto hllADAAA 
 goto hllZCAAA 
hllYCAAA: 
 btfsc neg,1
 goto hllADAAA 

hllZCAAA: 

 
 movfw mout 

 
 iorlw .128 

 
 movwf mout 


hllADAAA: 

 
 movfw mout 

 
 PUSH

 
 banksel util
 movfw util 
 PUSH
 
 goto hllDDAAA 

hllBDAAA: 

 POP
 POP


hllCDAAA:
 POP

 
 movlw .128
 PUSH
 PUSH

 
 
hllDDAAA:
 
 return
 
 
 
 
hllEDAAA: 

 POP
 banksel factor1
 movwf factor1

 POP
 banksel factor2
 movwf factor2


 
 clrf hi_byte
 
 clrf make_mout
 
 clrf iterator

hllFDAAA:

 
 btfss factor1,0
 goto hllGDAAA

 
 
 movfw factor2
 addwf make_mout,f

 
 btfsc STATUS,C
 incf hi_byte,f


hllGDAAA:
 
 
 RSHIFT factor1
 
 
 
 RSHIFT hi_byte
 
 
 
 
 
 
 rrf make_mout,f


 
 
 
 
 
 
 
 
 
 
 
 
 btfsc STATUS,C
 bsf factor1,7 


 incf iterator,f


 movlw .8
 xorwf iterator,w
 btfss STATUS,Z
 goto hllFDAAA

 
 movfw factor1 
 PUSH

 
 banksel make_mout
 movfw make_mout
 PUSH

 goto hllVCAAA 





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
 goto hllHDAAA
 
 movfw thk000
 andlw .127 
 movwf thk000 
 movlw '-' 
hllHDAAA: 
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
 goto hllHDAAA2 
 movfw thk001 
 xorlw .255 
 addlw .1
 movwf thk001 
 movlw '-' 
hllHDAAA2: 
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
 goto hllJDAAA 
 
 
 

 bcf arg1,7 
 movfw arg1 
 
 PUSH


 movlw .7
 PUSH
 
 goto hllRDAAA

hllJDAAA: 
 btfss arg1,6
 goto hllKDAAA 


 
 

 
 
 

 banksel arg1
 bcf arg1,6 
 bcf STATUS,C 
 rlf arg1,f
 movfw arg1
 PUSH

 movlw .6
 PUSH
 
 goto hllRDAAA
hllKDAAA: 

 btfss arg1,5
 goto hllLDAAA

 banksel arg1
 bcf arg1,5 
 bcf STATUS,C 
 rlf arg1,f
 rlf arg1,f
 movfw arg1
 PUSH

 movlw .5
 PUSH
 
 goto hllRDAAA
hllLDAAA: 

 btfss arg1,4
 goto hllMDAAA


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
 
 goto hllRDAAA
hllMDAAA: 

 btfss arg1,3
 goto hllNDAAA

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
 
 goto hllRDAAA

hllNDAAA: 

 btfss arg1,2
 goto hllODAAA


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
 
 goto hllRDAAA

hllODAAA: 

 btfss arg1,1
 goto hllPDAAA

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

 goto hllRDAAA
hllPDAAA: 
 btfss arg1,0
 goto hllQDAAA
 movlw .0
 PUSH

 movlw .0
 PUSH
 
 goto hllRDAAA
hllQDAAA:
 movlw .0
 PUSH

 movlw -.128
 PUSH
 
hllRDAAA:
 
 return




#undefine arg1

 end
