PUSH macro ;Push to the main stack for the programmer's parms and dyn. data;
 incf FSR,f ; The "incf" op serves as an allocator; it happens first so that interrupting
 movwf INDF ; code of any sort will not overwrite the data. 
 endm 
 
POP macro ;Pop from main stack; "decf" is the de-allocator and thus happens last to 
 movfw INDF ; preserve the safety of this code under interruptible conditions. 
 decf FSR,f 
 endm
 
DISCARD macro ;Remove items from the main stack and throw them away w/o affecting W
 decf FSR,f 
 endm
 
KDISCARD macro ;Remove items from stack 2 and throw them away w/o affecting W
 decf alt_fsr,f 
 endm

COPY macro ;Duplicate stack top
 movfw INDF
 incf FSR,f 
 movwf INDF 
 endm

#define HLFSR FSR
 
#define HLINDF INDF

  
FAR_CALL macro caller_os,func_os ;Call destination residing within a different code page
 pagesel func_os
 call func_os
 pagesel caller_os ;This one restores the caller's code page
 endm

;Call destination residing within a different code page... does not restore the caller's
; code page after return, which may be OK (e.g. if the next operation is another 'Far'
; function call). 
HALF_FAR_CALL macro func_os 
 pagesel func_os        
 call func_os
 endm
 
KPOP macro
 bankisel alt_stack ;This is OK for interrupts... part of STATUS 
 movf in_isr,f ;In shared RAM, no need for BANKSEL
 btfsc STATUS,Z
 goto $+0F
 movfw FSR 
 movwf softstack0+1 ;Save user stack ptr 
 movfw alt_fsr ;Get second stack ptr 
 movwf FSR 
 movfw INDF ;Dereference it 
 decf FSR,f ;Decrement it 
 movwf softstack1+1  ;Save popped value for ret urn 
 movfw FSR ;Save second stack ptr 
 movwf alt_fsr 
 movfw softstack0+1  ;Restore user stack ptr 
 movwf FSR 
 clrf softstack0+1
 movfw softstack1+1  ;Bring back popped value for ret urn 
 goto $+0E
 movfw FSR 
 movwf softstack0 ;Save user stack ptr 
 movfw alt_fsr ;Get second stack ptr 
 movwf FSR 
 movfw INDF ;Dereference it 
 decf FSR,f ;Decrement it 
 movwf softstack1  ;Save popped value for ret urn 
 movfw FSR ;Save second stack ptr 
 movwf alt_fsr 
 movfw softstack0  ;Restore user stack ptr 
 movwf FSR 
 clrf softstack0
 movfw softstack1  ;Bring back popped value for ret urn 
 bankisel stack
 endm 

KPUSH macro
 bankisel alt_stack ;This is OK for interrupts... part of STATUS 
 movf in_isr,f ;In shared RAM, no need for BANKSEL
 btfsc STATUS,Z
 goto $+0E
 movwf softstack1+1 ;softstack1 holds parm value being pushed
 movfw FSR  
 movwf softstack0+1  ;softstack0 holds FSR
 movfw alt_fsr 
 movwf FSR 
 movfw softstack1+1
 incf alt_fsr,f 
 incf FSR,f ;The actual kernel push... preincrement for interrupt safety
 movwf INDF 
 movfw softstack0+1
 movwf FSR 
 clrf softstack0+1 
 goto $+0D
 movwf softstack1 ;softstack1 holds parm value being pushed
 movfw FSR  
 movwf softstack0  ;softstack0 holds FSR
 movfw alt_fsr 
 movwf FSR 
 movfw softstack1
 incf alt_fsr,f 
 incf FSR,f ;The actual kernel push... preincrement for interrupt safety
 movwf INDF 
 movfw softstack0
 movwf FSR 
 clrf softstack0
 bankisel stack
 endm
 
;These are simple shifts, similar to << or >> in C, not rotates. Newer PICs include
; a native shift instruction that shifts in zeroes like << and >>. Older devices 
; can only rotate bits through the C register, requiring an extra instruction to
; clear C in cases where a simple shift is needed.
LSHIFT macro file_reg
 bcf STATUS,C    ;RLF is a bit shift operation that's present on both the 16F690 (for example) and the 16F1827.
 rlf file_reg,f  ; It's a rotate, pulling from C for the necessary bottom-order bit       
 endm 

RSHIFT macro file_reg
 bcf STATUS,C    ;RRF is a bit shift operation that's present on both the 16F690 (for example) and the 16F1827.
 rrf file_reg,f  ; It's a rotate, pulling from C for the necessary bottom-order bit       
 endm 
 
PREEMPT macro
#ifdef HLLMULTITASK 
 movwf W_Save ; save context- save W in "W_save" file reg.
 ;From datasheet... save STATUS properly
 swapf STATUS,W 
 movwf STATUS_Save 
 movf FSR,w 
 movwf FSR_Save 
 movf PCLATH,w ; save status in "STATUS_Save" file reg.
 movwf PC_Save 
 movf alt_fsr,w 
 movwf ALT_Save
 incf in_isr,f
 pagesel ISR
 bankisel stack 
 movf FSR,w           ;Restore "softstack" if main thread was using 2nd stack
 movf softstack0,f	  ; (coded to preserve constant interrupt latency)
 btfss STATUS,Z       
 movf softstack0,w  
 movwf FSR          
#endif 
 endm
 
RESUME macro
 
#ifdef HLLMULTITASK 
 clrf in_isr
 movf ALT_Save,w
 movwf alt_fsr 
 movf PC_Save,w ; restore context (W and STATUS)
 movwf PCLATH
 movf FSR_Save,w 
 movwf FSR
 ;Per the datasheet...
 swapf STATUS_Save,W
 movwf STATUS ;Move W into Status reg
 swapf W_Save,F ;Swap W_TEMP
 swapf W_Save,W ;Swap W_TEMP into W
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
 addwf INDF,w 
 decf FSR,f
 btfsc STATUS,C ; Necess. b/c writes to PCL take 5 bits fr. PCLATH
 incf PCLATH,f 
 movwf PCL 
mmnme#v(2): 
 ;retlw K, retlw K, etc. go here
 endm

READEEPROM macro
 POP
 banksel EEADR
 movwf EEADR
 banksel EECON1
 bcf EECON1, EEPGD
 bsf EECON1, RD
 banksel EEDAT
 movf EEDAT, W
 PUSH
endm

WRITEEEPROM macro
 POP
 banksel EEDAT
 movwf	EEDAT
 POP
 banksel EEADR 
 movwf	EEADR
 banksel EECON1
 bcf EECON1, EEPGD
 bsf EECON1, WREN
 bcf  INTCON, GIE
 btfsc INTCON, GIE
 goto $-2
 movlw	55h
 movwf	EECON2
 movlw	0AAh
 movwf	EECON2
 bsf	EECON1, WR
 bsf	INTCON, GIE
 bcf	EECON1, WREN
endm