










 

 

 hloedbg CODE



debugpeeku:
 COPY
 movlw .13
 PUSH
 FAR_CALL debugpeeku,printch
 movlw .10
 PUSH
 FAR_CALL debugpeeku, printch
 movlw 'U'
 PUSH
 FAR_CALL debugpeeku, printch
 FAR_CALL debugpeeku, printu
 return
 
 hloedhh CODE
 
debugptru:
 movlw '@'
 PUSH
 FAR_CALL debugptru, printch        
 movfw HLFSR
 PUSH
 FAR_CALL debugptru, printu 
 return
 

