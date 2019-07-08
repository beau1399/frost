



 

altsthhk CODE



#define mterm hllblss00


#define margpi hllblss01


#define mkarg1 hllblss02


safeaddi:  
#ifdef HLLMULTITASK
#ifdef HLLGUARDhllblss 
 movf in_isr,f  
 btfsc STATUS,Z
 


 goto safeaddi0

 POP
 
 banksel margpi 
 movwf margpi 
 clrf mkarg1
 andlw .128 
 btfsc STATUS,Z
 goto Tmmmy 
 bsf mkarg1,0 
Tmmmy:
 banksel stack
 
 movlw .128
 andwf HLINDF,w
 banksel mkarg1
 btfsc STATUS,Z
 goto Tmnny
 bsf mkarg1,1 
Tmnny:
 
 banksel margpi
 movf margpi,w 
 banksel stack 
 addwf HLINDF,w 
 decf HLFSR,f 
 banksel mterm
 movwf mterm
 btfsc mkarg1,0
 goto ar3neg
 
 btfsc mkarg1,1
 goto ok00
 
 
 btfss mterm,7
 goto ok00
 
 goto toob31
 
 
ar3neg:
 btfss mkarg1,1
 goto ok00
 
 btfsc mterm,7
 goto ok00
 
 goto toob32
ok00:
 
 PUSH
 return
 
toob31:
 
 movlw .127 
 PUSH
 return
toob32:
 
 movlw -.128 
 PUSH
 return

 


#undefine mterm


#undefine margpi


#undefine mkarg1


#define mterm hllblss00+1


#define margpi hllblss01+1


#define mkarg1 hllblss02+1


safeaddi0:
#endif
#endif

 POP
 
 banksel margpi 
 movwf margpi 
 clrf mkarg1
 andlw .128 
 btfsc STATUS,Z
 goto hllIAAAA 
 bsf mkarg1,0 
hllIAAAA:
 banksel stack
 
 movlw .128
 andwf HLINDF,w
 banksel mkarg1
 btfsc STATUS,Z
 goto hllJAAAA
 bsf mkarg1,1 
hllJAAAA:
 
 banksel margpi
 movf margpi,w 
 banksel stack 
 addwf HLINDF,w 
 decf HLFSR,f 
 banksel mterm
 movwf mterm
 btfsc mkarg1,0
 goto hllKAAAA
 
 btfsc mkarg1,1
 goto hllLAAAA
 
 
 btfss mterm,7
 goto hllLAAAA
 
 goto hllMAAAA
 
 
hllKAAAA:
 btfss mkarg1,1
 goto hllLAAAA
 
 btfsc mterm,7
 goto hllLAAAA
 
 goto hllNAAAA
hllLAAAA:
 
 PUSH
 return
 
hllMAAAA:
 
 movlw .127 
 PUSH
 return
hllNAAAA:
 
 movlw -.128 
 PUSH
 return

 


#undefine mterm


#undefine margpi


#undefine mkarg1
