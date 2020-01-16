 banksel PIR1
 btfss PIR1,RCIF
 goto hllnotisr%s
 bcf PIR1,RCIF

 
 ;Make the user do this.... including it here is typically redundant, for well-written 
 ; code; also, reading RCREG twice causes MPSIM errors and may be unreliable.
 ; banksel RCREG
 ;movf RCREG,w
