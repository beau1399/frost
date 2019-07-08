






 
 

hlpa22 CODE


day:
 
 
 movlw 0x1b
 PUSH
 FAR_CALL day,printch
 movlw '['
 PUSH
 FAR_CALL day,printch

 movlw '0'
 PUSH
 FAR_CALL day,printch
 movlw ';'
 PUSH
 FAR_CALL day,printch

 movlw '4'
 PUSH
 FAR_CALL day,printch
 movlw '7'
 PUSH
 FAR_CALL day,printch
 movlw ';'
 PUSH
 FAR_CALL day,printch
 movlw '3'
 PUSH
 FAR_CALL day,printch
 movlw '4'
 PUSH
 FAR_CALL day,printch
 movlw 'm'
 PUSH
 FAR_CALL day,printch
 
 return
 


 



 