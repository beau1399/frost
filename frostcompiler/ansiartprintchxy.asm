



 
 
ansiarh CODE
 
printchxy: 
 
 movlw 0x1b
 PUSH
 FAR_CALL printchxy,printch
 movlw '['
 PUSH
 FAR_CALL printchxy,printch
 FAR_CALL printchxy,printu
 movlw ';'
 PUSH
 FAR_CALL printchxy,printch
 FAR_CALL printchxy,printu
 movlw 'H'
 PUSH
 FAR_CALL printchxy,printch
 FAR_CALL printchxy,printch
 return
 