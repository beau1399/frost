



 

sfp_gt CODE



#define karg4 sfploc00


#define karg3 sfploc01


#define karg2 sfploc02


#define karg1 sfploc03


#define neg2 sfploc04


#define neg sfploc05


gtf:  
#ifdef HLLMULTITASK
#ifdef HLLGUARDsfploc 
 movf in_isr,f  
 btfsc STATUS,Z
 


 goto gtf0

 
 
 
 
 

 
 
 
 
 
 POP
 banksel karg4
 movwf karg4 

 POP

 movwf karg3 
 
 POP

 movwf karg2 

 POP

 movwf karg1 
 
 
 
 clrf neg 
 clrf neg2 

 btfsc karg1,7
 bsf neg,0 
 btfsc karg3,7
 bsf neg2,0 


 
 btfss neg,0
 goto tsok7
 btfsc neg2,0
 goto tsok7
 movlw .0

 PUSH
 
 goto retok7
tsok7:






 
 btfsc neg,0
 goto tsok8
 btfss neg2,0
 goto tsok8
 movlw .1 
 PUSH
 
 goto retok7
tsok8:



 
 
 bcf karg1,7
 bcf karg3,7


 
 
 
 

 
 
 
 
 
 

 btfsc karg4,7 
 goto nxclg55
 movf karg4,f
 btfsc STATUS,Z 
 goto nxclg55 
 

 movf karg2,f
 btfsc STATUS,Z
 goto iiout4
 btfsc karg2,7
 goto iiout4
 goto iistl3
 
nxclg55: 

 btfsc karg2,7 
 goto iiout4
 movf karg2,f
 btfsc STATUS,Z 
 goto iiout4 
 goto retnn
iistl3: 
 movfw 	karg2			
 subwf karg4,w    
 btfsc STATUS,C    
 goto iiout4
 goto retnn



iiout4: 



 





 btfsc karg2,7 
 goto nzxlg55
 movf karg2,f
 btfsc STATUS,Z 
 goto nzxlg55 
 

 movf karg4,f
 btfsc STATUS,Z
 goto izxut4
 btfsc karg4,7
 goto izxut4
 goto izxtl3
 
nzxlg55: 

 btfsc karg4,7 
 goto izxut4
 movf karg4,f
 btfsc STATUS,Z 
 goto izxut4 
 goto retin
izxtl3: 
 movfw 	karg4			
 subwf karg2,w    
 btfsc STATUS,C    
 goto izxut4
 goto retin
izxut4: 








 
 
 
 
 movfw karg1
 subwf karg3,w
 btfss STATUS,C 
 goto retnn 
 
 movfw karg3
 subwf karg1,w
 btfss STATUS,C 
 goto retin

 
 movlw .0 
 PUSH
 
 goto retok7 

 
retin:
 banksel neg
 movlw .0 
 btfsc neg,0
 movlw .1 
 PUSH
 
 goto retok7 
retnn:
 banksel neg
 movlw .0 
 btfss neg,0
 movlw .1
 PUSH
 
retok7:
 
 return 
 



#undefine karg4


#undefine karg3


#undefine karg2


#undefine karg1


#undefine neg2


#undefine neg


#define karg4 sfploc00+1


#define karg3 sfploc01+1


#define karg2 sfploc02+1


#define karg1 sfploc03+1


#define neg2 sfploc04+1


#define neg sfploc05+1


gtf0:
#endif
#endif

 
 
 
 
 

 
 
 
 
 
 POP
 banksel karg4
 movwf karg4 

 POP

 movwf karg3 
 
 POP

 movwf karg2 

 POP

 movwf karg1 
 
 
 
 clrf neg 
 clrf neg2 

 btfsc karg1,7
 bsf neg,0 
 btfsc karg3,7
 bsf neg2,0 


 
 btfss neg,0
 goto hllIDAAA
 btfsc neg2,0
 goto hllIDAAA
 movlw .0

 PUSH
 
 goto hllSDAAA
hllIDAAA:






 
 btfsc neg,0
 goto hllJDAAA
 btfss neg2,0
 goto hllJDAAA
 movlw .1 
 PUSH
 
 goto hllSDAAA
hllJDAAA:



 
 
 bcf karg1,7
 bcf karg3,7


 
 
 
 

 
 
 
 
 
 

 btfsc karg4,7 
 goto hllKDAAA
 movf karg4,f
 btfsc STATUS,Z 
 goto hllKDAAA 
 

 movf karg2,f
 btfsc STATUS,Z
 goto hllMDAAA
 btfsc karg2,7
 goto hllMDAAA
 goto hllLDAAA
 
hllKDAAA: 

 btfsc karg2,7 
 goto hllMDAAA
 movf karg2,f
 btfsc STATUS,Z 
 goto hllMDAAA 
 goto hllRDAAA
hllLDAAA: 
 movfw 	karg2			
 subwf karg4,w    
 btfsc STATUS,C    
 goto hllMDAAA
 goto hllRDAAA



hllMDAAA: 



 





 btfsc karg2,7 
 goto hllNDAAA
 movf karg2,f
 btfsc STATUS,Z 
 goto hllNDAAA 
 

 movf karg4,f
 btfsc STATUS,Z
 goto hllPDAAA
 btfsc karg4,7
 goto hllPDAAA
 goto hllODAAA
 
hllNDAAA: 

 btfsc karg4,7 
 goto hllPDAAA
 movf karg4,f
 btfsc STATUS,Z 
 goto hllPDAAA 
 goto hllQDAAA
hllODAAA: 
 movfw 	karg4			
 subwf karg2,w    
 btfsc STATUS,C    
 goto hllPDAAA
 goto hllQDAAA
hllPDAAA: 








 
 
 
 
 movfw karg1
 subwf karg3,w
 btfss STATUS,C 
 goto hllRDAAA 
 
 movfw karg3
 subwf karg1,w
 btfss STATUS,C 
 goto hllQDAAA

 
 movlw .0 
 PUSH
 
 goto hllSDAAA 

 
hllQDAAA:
 banksel neg
 movlw .0 
 btfsc neg,0
 movlw .1 
 PUSH
 
 goto hllSDAAA 
hllRDAAA:
 banksel neg
 movlw .0 
 btfss neg,0
 movlw .1
 PUSH
 
hllSDAAA:
 
 return 
 



#undefine karg4


#undefine karg3


#undefine karg2


#undefine karg1


#undefine neg2


#undefine neg
