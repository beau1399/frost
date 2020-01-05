
PUSH macro ;Push to the main stack for the programmer's parms and dyn. data;
 movwi ++INDF0
 endm
 
POP macro ;Pop from main stack; "decf" is the de-allocator and thus happens last to 
 moviw INDF0-- ; preserve the safety of this code under interruptible conditions. 
 endm
 
DISCARD macro ;Remove items from the main stack and throw them away w/o affecting W
 decf FSR0L,f 
 endm

COPY macro ;Duplicate stack top
 movfw INDF0
 incf FSR0L,f 
 movwf INDF0 
 endm

#define HLFSR FSR0L
 
#define HLINDF INDF0

KPUSH macro
 movwi ++INDF1
 endm
 
KPOP macro 
 moviw INDF1--
 endm 

KDISCARD macro ;Remove items from stack 2 and throw them away w/o affecting W
 decf FSR1L,f 
 endm

FAR_CALL macro caller_os,func_os ;Call destination residing within a different code page
 pagesel func_os
 call func_os
 pagesel caller_os
 endm

;Call destination residing within a different code page... does not restore the caller's
; code page after return, which may be OK (e.g. if the next operation is another 'Far'
; function call). 
HALF_FAR_CALL macro func_os 
 pagesel func_os        
 call func_os
 endm

;These are simple shifts, similar to << or >> in C, not rotates. Newer PICs include
; a native shift instruction that shifts in zeroes like << and >>. Older devices 
; can only rotate bits through the C register, requiring an extra instruction to
; clear C in cases where a simple shift is needed.
LSHIFT macro file_reg
 lslf file_reg,f
 endm 

RSHIFT macro file_reg
 lsrf file_reg,f
 endm 
 
PREEMPT macro
#ifdef HLLMULTITASK 
 incf in_isr,f
 pagesel ISR
 movf FSR0L,w           ;Restore "softstacks" if main thread was using 2nd stack
 movf softstack0,f
 btfss STATUS,Z   
 movf softstack0,w  
 movwf FSR0L          
#endif 
 endm

RESUME macro
#ifdef HLLMULTITASK 
 clrf in_isr
#endif
 endm
 
; Table macro.. this followed by any series of RETLW calls
; transforms said call list into a function that takes an offset
; and returns that entry in the table (takes 1 byte, returns 1
; byte... this goes atop the HLL feature which allows generation 
; of tables. It can also go atop RETLW tables entered into assembly 
; files in a very basic fashion when doing assembly programming. In 
; either case, the overall result can be called exactly as if it were any 
; other HLOE function
HLTABLE macro mmnme
mmnme:
 movlw high mmnme#v(2) ; Necess. b/c writes to PCL take 5 bits fr. PCLATH
 movwf PCLATH ; and PAGESEL doesn't take care of all 5
 movlw low mmnme#v(2) ; Perform pointer arithmetic
 addwf INDF0,w 
 decf FSR0L,f
 btfsc STATUS,C ; Necess. b/c writes to PCL take 5 bits fr. PCLATH
 incf PCLATH,f 
 movwf PCL 
mmnme#v(2): 
 ;retlw K, retlw K, etc. go here
 endm

READEEPROM macro
 banksel EEADR
 POP
 movwf	EEADR
 banksel EECON1
 bcf EECON1, EEPGD
 bsf EECON1, RD
 banksel EEDAT
 movf EEDAT, W
 PUSH
endm

WRITEEEPROM macro
 banksel EEADRL
 POP
 movwf	EEDATL
 POP
 movwf	EEADRL
 bcf EECON1, CFGS
 bcf EECON1, EEPGD
 bsf EECON1, WREN
 bcf	INTCON, GIE
 movlw	55h
 movwf	EECON2
 movlw	0AAh
 movwf	EECON2
 bsf	EECON1, WR
 bsf	INTCON, GIE
 bcf	EECON1, WREN
 btfsc	EECON1, WR
 GOTO	$-2
endm