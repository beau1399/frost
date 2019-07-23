





 
 


sfp_iszero CODE

iszerof: 
 POP
 xorlw 0x80 
 btfss STATUS,Z 
 goto nonzf 
 POP
 andlw .127
 xorlw .0 
 btfss STATUS,Z 
 goto nonzg
 movlw .1 
 goto nonzr
nonzf: 
 decf HLFSR,f
nonzg:  
 movlw .0 
nonzr:  
 PUSH
 return 


 
 