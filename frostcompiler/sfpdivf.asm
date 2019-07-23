










  
 

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
