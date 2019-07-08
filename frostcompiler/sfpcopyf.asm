



 

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
