




 
  
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
 goto rhik3sz
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
 goto hllIAAAA
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
