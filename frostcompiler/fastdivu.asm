






 

ufstdv034 udata 





fstdvss00 res 1 	  
#ifdef HLLMULTITASK
#ifdef HLLGUARDfstdvss
fstdvss00isr res 1      
#endif
#endif

fstdvss01 res 1    
#ifdef HLLMULTITASK
#ifdef HLLGUARDfstdvss
fstdvss01isr res 1      
#endif
#endif

fstdvss02 res 1    
#ifdef HLLMULTITASK
#ifdef HLLGUARDfstdvss
fstdvss02isr res 1      
#endif
#endif
  
fstdvss03 res 1    
#ifdef HLLMULTITASK
#ifdef HLLGUARDfstdvss
fstdvss03isr res 1      
#endif
#endif
    
fstdvss04 res 1    
#ifdef HLLMULTITASK
#ifdef HLLGUARDfstdvss
fstdvss04isr res 1      
#endif
#endif
    
fstdvss05 res 1    
#ifdef HLLMULTITASK
#ifdef HLLGUARDfstdvss
fstdvss05isr res 1      
#endif
#endif
    
fstdvss CODE



#define countrr fstdvss00


#define keepp fstdvss01


#define pterm fstdvss02


#define bterm fstdvss03


#define aterm fstdvss04


fastdivu:  
#ifdef HLLMULTITASK
#ifdef HLLGUARDfstdvss 
 movf in_isr,f  
 btfsc STATUS,Z
 


 goto fastdivu0

 banksel countrr
 clrf countrr
 POP
 banksel bterm 
 movwf bterm
 POP
 banksel aterm 
 movwf aterm
 clrf pterm
lop55d:         
 movfw countrr
 xorlw .8
 btfsc STATUS,Z
 goto n2xx4s
 movfw aterm
 andlw .128
 movwf keepp
 bcf STATUS,C
 rlf pterm,f    
 bcf STATUS,C   
 rlf aterm,f    
 movfw keepp
 btfsc STATUS,Z
 goto n119ec
 incf pterm,f
n119ec:
 movfw bterm
 subwf pterm,w
 btfss STATUS,C  
 goto n01cee
 movwf pterm  
 movfw aterm  
 iorlw .1     
 movwf aterm  
n01cee: 
 incf countrr,f
 goto lop55d  
n2xx4s:
 movf aterm,w
 PUSH 
 return



#undefine countrr


#undefine keepp


#undefine pterm


#undefine bterm


#undefine aterm


#define countrr fstdvss00+1


#define keepp fstdvss01+1


#define pterm fstdvss02+1


#define bterm fstdvss03+1


#define aterm fstdvss04+1


fastdivu0:
#endif
#endif

 banksel countrr
 clrf countrr
 POP
 banksel bterm 
 movwf bterm
 POP
 banksel aterm 
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
 bcf STATUS,C
 rlf pterm,f    
 bcf STATUS,C   
 rlf aterm,f    
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
 movf aterm,w
 PUSH 
 return



#undefine countrr


#undefine keepp


#undefine pterm


#undefine bterm


#undefine aterm
