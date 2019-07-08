






 

hlpal1 CODE

night:
 
 
 movlw 0x1b
 PUSH
 FAR_CALL night,printch
 movlw '['
 PUSH
 FAR_CALL night,printch

 movlw '0'
 PUSH
 FAR_CALL night,printch
 movlw ';'
 PUSH
 FAR_CALL night,printch

 movlw '3'
 PUSH
 FAR_CALL night,printch
 movlw '2'
 PUSH
 FAR_CALL night,printch
 movlw ';'
 PUSH
 FAR_CALL night,printch
 movlw '4'
 PUSH
 FAR_CALL night,printch
 movlw '0'
 PUSH
 FAR_CALL night,printch
 movlw 'm'
 PUSH
 FAR_CALL night,printch
 
 return




 