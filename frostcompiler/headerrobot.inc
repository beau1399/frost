

;
; R O B O T
;
; H E A D E R
;

#ifdef HLLMULTITASK
ExitISR:    
 RESUME 
 
  retfie
#endif

mainvars udata_shr	
#ifdef HLLMULTITASK
pbase res .1			; Used for functions w/ numbered pass/return, to clean up parms/push args
pbaseisr res .1	
#else
pbase res .1
#endif
PC_Save res .1

main code
hloego:

 

  
  clrf in_isr
 
  movlw stack-1		;Set up stack starting position based on literals det. by incremental linker
  movwf FSR 
  movlw alt_stack-1
  movwf alt_fsr 
 
 
 clrf softstack0 
 
 bankisel stack
 pagesel hlluserprog
 goto hlluserprog
hllupuser CODE
hlluserprog: 
 