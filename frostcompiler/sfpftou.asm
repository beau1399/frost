



 

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
 goto hllSDAAA
 POP
 goto hllCEAAA 
hllSDAAA:
 
 POP
 addlw .128
 banksel karg1
 movwf karg1 
 
 movfw karg2
 sublw .7
 
 movwf divisor 

 movlw high hllTDAAA 
 movwf PCLATH 
 movlw low hllTDAAA
 addwf divisor,w 
 btfsc STATUS,C 
 incf PCLATH,f 
 movwf PCL 


hllTDAAA:
 goto hllBEAAA
 goto hllAEAAA
 goto hllZDAAA 
 goto hllYDAAA
 goto hllXDAAA
 goto hllWDAAA
 goto hllVDAAA
 goto hllUDAAA
 
hllUDAAA:
 RSHIFT karg1
 rrf util,f
hllVDAAA:
 RSHIFT karg1
 rrf util,f
hllWDAAA:
 RSHIFT karg1
 rrf util,f
hllXDAAA:
 RSHIFT karg1
 rrf util,f
hllYDAAA:
 RSHIFT karg1
 rrf util,f
hllZDAAA:
 RSHIFT karg1
 rrf util,f
hllAEAAA:
 RSHIFT karg1
 rrf util,f
hllBEAAA:

hllCEAAA:
 banksel karg1
 movfw karg1 
 PUSH
 
 
 return




#undefine util


#undefine divisor


#undefine karg2


#undefine karg1
