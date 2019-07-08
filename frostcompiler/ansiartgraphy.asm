




 

 
 
ansiaff CODE




#define flgg3 aart00


#define vert aart01


#define cont aart02


graphy:  
#ifdef HLLMULTITASK
#ifdef HLLGUARDaart 
 movf in_isr,f  
 btfsc STATUS,Z
 


 goto graphy0





 
 movf HLFSR,w
 




 
 
 
 
 
 
 pagesel kpush
 call kpush



 movlw .2
 PUSH
 FAR_CALL graphy,parm
 POP
 banksel cont
 movwf cont
 
 
 
 movlw .0
 xorwf cont,w
 btfsc STATUS,Z
 goto b6tt1f
 
ttl44: 
 bcf flgg3,0
 goto p1helpr
went44: 

 
 

 
 movlw 0xDB
 PUSH
 FAR_CALL graphy,printch
 

 banksel cont
 decfsz cont,F
 goto ttl44
 

 
  
b6tt1f: 
 movlw .3
 PUSH
 
  pagesel parm
  call parm
 
 movlw .2
 PUSH
 
 
 
  pagesel parm
  call parm



 
  pagesel negti
  call negti

 
 
 FAR_CALL graphy,add
 POP
 banksel cont
 movwf cont
 
 movf cont,f
 btfsc STATUS,Z
 goto tt655 







ttl55: 
 bsf flgg3,0 
 goto p1helpr
went55:
 
 
 movlw 0xB0
 PUSH
 FAR_CALL graphy,printch
 

 banksel cont
 decfsz cont,F
 goto ttl55
 
 
tt655:
 
  
 
 
 pagesel kpop
 goto kpop
 
 movwf HLFSR
 return
 
 

p1helpr:

 movlw 0x1b
 PUSH
 
 pagesel printch
 call printch

 
 movlw '['
 PUSH

 
 pagesel printch
 call printch

 
 
 COPY 
 
 pagesel printu
 call printu

 
 
 decf HLINDF,f
 
 movlw ';'
 PUSH
 
 pagesel printch
 call printch

 

 movlw .1 
 PUSH

 pagesel parm
 call parm


 pagesel printu
 call printu

 
 movlw 'H'
 PUSH
 FAR_CALL graphy,printch
 
 banksel cont
 btfss flgg3,0 
 goto went44
 goto went55
  
 
 



#undefine flgg3


#undefine vert


#undefine cont


#define flgg3 aart00+1


#define vert aart01+1


#define cont aart02+1


graphy0:
#endif
#endif





 
 movf HLFSR,w
 




 
 
 
 
 
 
 pagesel kpush
 call kpush



 movlw .2
 PUSH
 FAR_CALL graphy,parm
 POP
 banksel cont
 movwf cont
 
 
 
 movlw .0
 xorwf cont,w
 btfsc STATUS,Z
 goto hllGAAAA
 
hllEAAAA: 
 bcf flgg3,0
 goto hllKAAAA
hllFAAAA: 

 
 

 
 movlw 0xDB
 PUSH
 FAR_CALL graphy,printch
 

 banksel cont
 decfsz cont,F
 goto hllEAAAA
 

 
  
hllGAAAA: 
 movlw .3
 PUSH
 
  pagesel parm
  call parm
 
 movlw .2
 PUSH
 
 
 
  pagesel parm
  call parm



 
  pagesel negti
  call negti

 
 
 FAR_CALL graphy,add
 POP
 banksel cont
 movwf cont
 
 movf cont,f
 btfsc STATUS,Z
 goto hllJAAAA 







hllHAAAA: 
 bsf flgg3,0 
 goto hllKAAAA
hllIAAAA:
 
 
 movlw 0xB0
 PUSH
 FAR_CALL graphy,printch
 

 banksel cont
 decfsz cont,F
 goto hllHAAAA
 
 
hllJAAAA:
 
  
 
 
 pagesel kpop
 goto kpop
 
 movwf HLFSR
 return
 
 

hllKAAAA:

 movlw 0x1b
 PUSH
 
 pagesel printch
 call printch

 
 movlw '['
 PUSH

 
 pagesel printch
 call printch

 
 
 COPY 
 
 pagesel printu
 call printu

 
 
 decf HLINDF,f
 
 movlw ';'
 PUSH
 
 pagesel printch
 call printch

 

 movlw .1 
 PUSH

 pagesel parm
 call parm


 pagesel printu
 call printu

 
 movlw 'H'
 PUSH
 FAR_CALL graphy,printch
 
 banksel cont
 btfss flgg3,0 
 goto hllFAAAA
 goto hllIAAAA
  
 
 



#undefine flgg3


#undefine vert


#undefine cont
