






 

ufstdv034 udata 

fstmods00 res 1 	  
#ifdef HLLMULTITASK
#ifdef HLLGUARDfstmods
fstmods00isr res 1      
#endif
#endif

fstmods01 res 1    
#ifdef HLLMULTITASK
#ifdef HLLGUARDfstmods
fstmods01isr res 1      
#endif
#endif

fstmods02 res 1    
#ifdef HLLMULTITASK
#ifdef HLLGUARDfstmods
fstmods02isr res 1      
#endif
#endif
  
fstmods03 res 1    
#ifdef HLLMULTITASK
#ifdef HLLGUARDfstmods
fstmods03isr res 1      
#endif
#endif
    
fstmods04 res 1    
#ifdef HLLMULTITASK
#ifdef HLLGUARDfstmods
fstmods04isr res 1      
#endif
#endif
    
fstmods05 res 1    
#ifdef HLLMULTITASK
#ifdef HLLGUARDfstmods
fstmods05isr res 1      
#endif
#endif
    
fstmods CODE







#define countrr fstmods00


#define keepp fstmods01


#define pterm fstmods02


#define bterm fstmods03


#define aterm fstmods04


fastmodu:  
#ifdef HLLMULTITASK
#ifdef HLLGUARDfstmods 
 movf in_isr,f  
 btfsc STATUS,Z
 


 goto fastmodu0

 banksel countrr
 clrf countrr
 POP
 movwf bterm
 POP
 movwf aterm
 clrf pterm
mop55d:         
 movfw countrr
 xorlw .8
 btfsc STATUS,Z
 goto m2xx4s
 movfw aterm
 andlw .128
 movwf keepp
 LSHIFT pterm
 LSHIFT aterm
 movfw keepp   
 btfsc STATUS,Z
 goto m119ec
 incf pterm,f
m119ec:
 movfw bterm
 subwf pterm,w
 btfss STATUS,C  
 goto m01cee
 movwf pterm  
 movfw aterm  
 iorlw .1     
 movwf aterm  
m01cee: 
 incf countrr,f
 goto mop55d  
m2xx4s:
 movf pterm,w  
 PUSH          
 return        



#undefine countrr


#undefine keepp


#undefine pterm


#undefine bterm


#undefine aterm


#define countrr fstmods00+1


#define keepp fstmods01+1


#define pterm fstmods02+1


#define bterm fstmods03+1


#define aterm fstmods04+1


fastmodu0:
#endif
#endif

 banksel countrr
 clrf countrr
 POP
 movwf bterm
 POP
 movwf aterm
 clrf pterm
hllIAAAA:         
 movfw countrr
 xorlw .8
 btfsc STATUS,Z
 goto hllLAAAA
 movfw aterm
 andlw .128
 movwf keepp
 LSHIFT pterm
 LSHIFT aterm
 movfw keepp   
 btfsc STATUS,Z
 goto hllJAAAA
 incf pterm,f
hllJAAAA:
 movfw bterm
 subwf pterm,w
 btfss STATUS,C  
 goto hllKAAAA
 movwf pterm  
 movfw aterm  
 iorlw .1     
 movwf aterm  
hllKAAAA: 
 incf countrr,f
 goto hllIAAAA  
hllLAAAA:
 movf pterm,w  
 PUSH          
 return        



#undefine countrr


#undefine keepp


#undefine pterm


#undefine bterm


#undefine aterm
