
%s:  
#ifdef HLLMULTITASK
#ifdef HLLGUARD%s 
 movf in_isr,f  
 btfsc STATUS,Z
 
