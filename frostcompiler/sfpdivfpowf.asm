






  
 

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


 
 

