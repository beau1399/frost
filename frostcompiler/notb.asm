





 
 
hlog1f CODE

notb: 
 movf HLINDF,f
 btfsc STATUS,Z
 goto nbnb
 clrf HLINDF
 goto ncnc
nbnb: 
 bsf HLINDF,0 
ncnc:
 return
 

