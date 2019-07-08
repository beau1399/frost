





 


 
hlog1e CODE
 

orb: 
 POP
 xorlw .0
 btfsc STATUS,Z
 goto zzorz1
 movlw .1
 movwf HLINDF
 return
zzorz1: 
 POP
 xorlw .0
 btfsc STATUS,Z
 goto zzorz2
 movlw .1
 PUSH
 return
zzorz2: 
 movlw .0
 PUSH
 return

 