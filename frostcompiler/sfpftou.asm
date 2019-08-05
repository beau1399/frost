



 

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
 RSHIFT karg1
 rrf util,f
shift6:
 RSHIFT karg1
 rrf util,f
shift5:
 RSHIFT karg1
 rrf util,f
shift4:
 RSHIFT karg1
 rrf util,f
shift3:
 RSHIFT karg1
 rrf util,f
shift2:
 RSHIFT karg1
 rrf util,f
shift1:
 RSHIFT karg1
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
 goto hllUCAAA
 POP
 goto hllEDAAA 
hllUCAAA:
 
 POP
 addlw .128
 banksel karg1
 movwf karg1 
 
 movfw karg2
 sublw .7
 
 movwf divisor 

 movlw high hllVCAAA 
 movwf PCLATH 
 movlw low hllVCAAA
 addwf divisor,w 
 btfsc STATUS,C 
 incf PCLATH,f 
 movwf PCL 


hllVCAAA:
 goto hllDDAAA
 goto hllCDAAA
 goto hllBDAAA 
 goto hllADAAA
 goto hllZCAAA
 goto hllYCAAA
 goto hllXCAAA
 goto hllWCAAA
 
hllWCAAA:
 RSHIFT karg1
 rrf util,f
hllXCAAA:
 RSHIFT karg1
 rrf util,f
hllYCAAA:
 RSHIFT karg1
 rrf util,f
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

hllEDAAA:
 banksel karg1
 movfw karg1 
 PUSH
 
 
 return




#undefine util


#undefine divisor


#undefine karg2


#undefine karg1
