
 
sfp_nex CODE 



#define loc001 sfploc00


#define loc000 sfploc01


nextf:  
#ifdef HLLMULTITASK
#ifdef HLLGUARDsfploc 
 movf in_isr,f  
 btfsc STATUS,Z
 


 goto nextf0

 POP 
 banksel loc001 
 movwf loc001
 POP 
 movwf loc000
 andlw .127
 xorlw .127
 btfss STATUS,Z 
 goto m0r33n
 movfw loc000
 andlw .128
 movwf loc000
 incf loc001,f
 goto m0r34d   
m0r33n:
 incf loc000,f
m0r34d:
 movfw loc000
 PUSH
 movfw loc001
 PUSH
 return



#undefine loc001


#undefine loc000


#define loc001 sfploc00+1


#define loc000 sfploc01+1


nextf0:
#endif
#endif

 POP 
 banksel loc001 
 movwf loc001
 POP 
 movwf loc000
 andlw .127
 xorlw .127
 btfss STATUS,Z 
 goto hllUFAAA
 movfw loc000
 andlw .128
 movwf loc000
 incf loc001,f
 goto hllVFAAA   
hllUFAAA:
 incf loc000,f
hllVFAAA:
 movfw loc000
 PUSH
 movfw loc001
 PUSH
 return



#undefine loc001


#undefine loc000
