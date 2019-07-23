








 
 

sfp_add CODE




#define mout_hi sfploc00


#define big_c sfploc01


#define min2_lower sfploc02


#define minres sfploc03


#define fulmin2H sfploc04


#define fulminH sfploc05


#define min_lower sfploc06


#define rev sfploc07


#define fulmin2 sfploc08


#define fulmin sfploc09


#define multiplier sfploc10


#define mout sfploc11


#define util sfploc12


#define neg sfploc13


#define ein2 sfploc14


#define min2 sfploc15


#define ein1 sfploc16


#define min sfploc17


addf:  
#ifdef HLLMULTITASK
#ifdef HLLGUARDsfploc 
 movf in_isr,f  
 btfsc STATUS,Z
 


 goto addf0


 
 
 
 
 
 
 
 
 POP
 banksel min
 movwf ein2 
 POP
 banksel min
 movwf min2 

 POP
 banksel min
 movwf ein1 

 POP
 banksel min
 movwf min 
 
 
 
 
 bcf minres,0 
 
 
 
 clrf mout 
 
 
 
 
 
 clrf neg
 btfsc min,7
 bsf neg,0
 
 
 
 btfsc min2,7
 bsf neg,1
 



 btfsc ein2,7  
 goto yzpt44
 
 btfss ein1,7
 goto yzpt65
 
 goto ein_lt_ein2
yzpt65: 
 
 movfw ein1
 subwf ein2,w    
 btfss STATUS,C 
 goto ein_lt_ein1  
lz_ein15:
 goto ein_lt_ein2  
yzpt44:   
 
 
 btfsc ein1,7
 goto yzpt65  
ein_lt_ein1:  
 
 


 movf ein2,w
 xorwf ein1,f

 movf ein1,w
 xorwf ein2,f

 movf ein2,w
 xorwf ein1,f


 movf min2,w
 xorwf min,f

 movf min,w
 xorwf min2,f

 movf min2,w
 xorwf min,f
 
 
 
 bsf rev,0 
 
 
 
 goto ein_lt_ein2_done 
ein_lt_ein2: 
 
 
 
 clrf rev 
ein_lt_ein2_done: 
 
 
 
 
 movfw min 
 andlw .127 
 movwf min 
 
 
 
 movfw min2 
 andlw .127 
 movwf min2 
 
 
 
 clrf fulminH 
 movfw min 
 addlw .128 
 btfsc STATUS,C 
 incf fulminH,f 
 
 
 movwf fulmin 
 
 
 
 clrf fulmin2H 
 movfw min2 
 addlw .128 
 btfsc STATUS,C 
 incf fulmin2H,f 
 
 movwf fulmin2 
 
 	
	
	
	
	


 clrf min_lower

 clrf min2_lower
 
whi77:


 movfw ein1 
 xorwf ein2,w 
 btfsc STATUS,Z 
 goto eein2outw  
 


 RSHIFT min_lower
 


 RSHIFT fulmin
 

 btfss STATUS,C
 goto nocar001
 

 bsf min_lower,7
nocar001:




 incf ein1,f


 goto whi77
 

eein2outw:	

 
 
 
 
 
 btfss rev,0 
 goto if_2_done 



 movf fulmin2,w
 xorwf fulmin,f

 movf fulmin,w
 xorwf fulmin2,f

 movf fulmin2,w
 xorwf fulmin,f 
 
 
 movfw min_lower 
 movwf min2_lower 
 
 clrf min_lower
 
 
 
 
 
if_2_done: 

 banksel min_lower

 
 

nrev0:	

 btfss neg,0
 goto nextspeci0
 

 btfss neg,1
 goto nextspeci0




 bsf minres,0

 goto nextspeci2

 
 
 
 
nextspeci0:
 

 btfss neg,0
 goto nextspeci1 

 
rrrout0:

	
	
	
 movfw fulmin 
 subwf fulmin2,w 
 movwf mout 
 
 
 btfsc STATUS,C
 goto nc11rr		
		
	
 bsf minres,0	
	
	
 goto rrrout1	
	
nc11rr:

	
 movf mout,f
 btfsc STATUS,Z
 goto specidone0	
mouty:

	
 btfsc mout,7	
 goto nn91   
	
	
    
 LSHIFT mout
 
	
 btfss min_lower,7	
 goto yym43   

 
 decf mout,f	

	
 movlw .255
 xorwf mout,w
 btfss STATUS,Z
 goto yym43	
	
     
 bsf minres,0
 
	 
 goto rrrout1
	 

yym43:

   
 LSHIFT min_lower
 
	
 decf ein1,f	

	
 goto mouty

nn91:
	
 btfss min_lower,7	
 goto trup5   
		
	
 decf mout,f

	
 movlw .255
 xorwf mout,w
 btfss STATUS,Z
 goto fltu54	
		
     
 bsf minres,0	 
	 
	 
 goto rrrout1	 
	 
	 
fltu54:
	
 movlw .127
 xorwf mout,w
 btfss STATUS,Z
 goto trup5	
	
	
	
	
 LSHIFT mout
	
	
 decf ein1,f	
	
	
 btfsc min_lower,6
 goto trup5 
	
	
 incf mout,f	
	
trup5:
	
 goto specidone0
nextspeci1:
 

	
 btfss neg,1
 goto nextspeci2 
 
	
rrrout1:

	
 movfw fulmin2
 subwf fulmin,w 
 movwf mout 

 
 btfsc STATUS,C
 goto rmxd3		
	
	
	
	
 bsf minres,0
	
	
 goto rrrout0	

rmxd3:

	
 movf mout,f 
 btfsc STATUS,Z 
 goto specidone0 
	
moutx:

	
 btfsc mout,7
 goto nn91b
 
 	
	
    
 LSHIFT mout 
 
	
 btfss min2_lower,7
 goto spyr5

	
	
 decf mout,f	
	
	
 movlw .255
 xorwf mout,w
 btfss STATUS,Z
 goto spyr5	
	

 bsf minres,0
	

 goto rrrout0
	
spyr5:

 
 LSHIFT min2_lower
 

 decf ein1,f
   
	
 goto moutx	
nn91b:

	
 btfss min2_lower,7
 goto cxaa

	
 decf mout,f	
	
	
 movlw .255
 xorwf mout,w
 btfss STATUS,Z
 goto iwrtt	
		
	
 bsf minres,0
 
	
 goto rrrout0
iwrtt:


	
 movlw .127
 xorwf mout,w
 btfss STATUS,Z
 goto cxaa	
		
	
	
	
 LSHIFT mout

	
 decf ein1,f	

	
 btfsc min2_lower,6
 goto cxaa 
 
	
	
 incf mout,f	
	
cxaa:

	
 goto specidone0

tpc0lea:
	 
 movfw fulmin
 subwf fulmin2,w 
 movwf mout 
	 
	 
	 
     
 bsf minres,0	 
	
 goto specidone0

	
nextspeci2:


 

	
 clrf mout_hi
	
	
	
 movf fulmin,w
 addwf fulmin2,w
 movwf mout
	
	

	
 btfss STATUS,C	
 goto cxab			
	
	
 incf mout_hi,f	
	
cxab:



	
 movf min_lower,w
 addwf min2_lower,w
 btfsc STATUS,C
 goto bihhg   
 

	
	
 andlw .128	
 btfss STATUS,Z
 goto bihhg	  
	
	
 goto bihh0	
	
bihhg:


	
 incf mout,f	
	
	
 movf mout,f
 btfss STATUS,Z
 goto bihh0 

	
 incf mout_hi,f

bihh0:
	
 movf mout_hi,f
 btfsc STATUS,Z
 goto specidone0 

	
	
	
	
 clrf big_c
 RSHIFT fulmin
 btfsc STATUS,C
 bsf big_c,0
	
	
 RSHIFT min_lower

	
	
 btfss big_c,0
 goto ddnyy
	
	
	
 bsf min_lower,7	
	
ddnyy:

	
	
 clrf big_c
 RSHIFT fulmin2
 btfsc STATUS,C
 bsf big_c,0
	
	
	
	
 RSHIFT min2_lower
	
	
	
 btfss big_c,0
 goto ddnzz

	
	
	
 bsf min_lower,7		
	
ddnzz:

	
 incf ein1,f	
	
	
 goto nextspeci2


specidone0:

 movfw mout 
 
 
 btfss STATUS,Z 
 goto nomoutzeer 
 
 
 
 movlw .0 

 PUSH
 
 
 
 movlw 0x80 
 PUSH
 
 
 
 goto re455tu
 
 
 
nomoutzeer: 
 
 
 
 
 movfw mout
 addlw -.128 
 movwf mout 

 
 
 
 btfsc minres,0 
 bsf mout,7
 
 movfw mout 
 PUSH
 
 
 
 banksel min
 movfw ein1 

 PUSH
 
re455tu:
 
 return 

 


#undefine mout_hi


#undefine big_c


#undefine min2_lower


#undefine minres


#undefine fulmin2H


#undefine fulminH


#undefine min_lower


#undefine rev


#undefine fulmin2


#undefine fulmin


#undefine multiplier


#undefine mout


#undefine util


#undefine neg


#undefine ein2


#undefine min2


#undefine ein1


#undefine min


#define mout_hi sfploc00+1


#define big_c sfploc01+1


#define min2_lower sfploc02+1


#define minres sfploc03+1


#define fulmin2H sfploc04+1


#define fulminH sfploc05+1


#define min_lower sfploc06+1


#define rev sfploc07+1


#define fulmin2 sfploc08+1


#define fulmin sfploc09+1


#define multiplier sfploc10+1


#define mout sfploc11+1


#define util sfploc12+1


#define neg sfploc13+1


#define ein2 sfploc14+1


#define min2 sfploc15+1


#define ein1 sfploc16+1


#define min sfploc17+1


addf0:
#endif
#endif


 
 
 
 
 
 
 
 
 POP
 banksel min
 movwf ein2 
 POP
 banksel min
 movwf min2 

 POP
 banksel min
 movwf ein1 

 POP
 banksel min
 movwf min 
 
 
 
 
 bcf minres,0 
 
 
 
 clrf mout 
 
 
 
 
 
 clrf neg
 btfsc min,7
 bsf neg,0
 
 
 
 btfsc min2,7
 bsf neg,1
 



 btfsc ein2,7  
 goto hllUAAAA
 
 btfss ein1,7
 goto hllSAAAA
 
 goto hllWAAAA
hllSAAAA: 
 
 movfw ein1
 subwf ein2,w    
 btfss STATUS,C 
 goto hllVAAAA  
hllTAAAA:
 goto hllWAAAA  
hllUAAAA:   
 
 
 btfsc ein1,7
 goto hllSAAAA  
hllVAAAA:  
 
 


 movf ein2,w
 xorwf ein1,f

 movf ein1,w
 xorwf ein2,f

 movf ein2,w
 xorwf ein1,f


 movf min2,w
 xorwf min,f

 movf min,w
 xorwf min2,f

 movf min2,w
 xorwf min,f
 
 
 
 bsf rev,0 
 
 
 
 goto hllWAAAA_done 
hllWAAAA: 
 
 
 
 clrf rev 
hllWAAAA_done: 
 
 
 
 
 movfw min 
 andlw .127 
 movwf min 
 
 
 
 movfw min2 
 andlw .127 
 movwf min2 
 
 
 
 clrf fulminH 
 movfw min 
 addlw .128 
 btfsc STATUS,C 
 incf fulminH,f 
 
 
 movwf fulmin 
 
 
 
 clrf fulmin2H 
 movfw min2 
 addlw .128 
 btfsc STATUS,C 
 incf fulmin2H,f 
 
 movwf fulmin2 
 
 	
	
	
	
	


 clrf min_lower

 clrf min2_lower
 
hllYAAAA:


 movfw ein1 
 xorwf ein2,w 
 btfsc STATUS,Z 
 goto hllABAAA  
 


 RSHIFT min_lower
 


 RSHIFT fulmin
 

 btfss STATUS,C
 goto hllZAAAA
 

 bsf min_lower,7
hllZAAAA:




 incf ein1,f


 goto hllYAAAA
 

hllABAAA:	

 
 
 
 
 
 btfss rev,0 
 goto hllBBAAA 



 movf fulmin2,w
 xorwf fulmin,f

 movf fulmin,w
 xorwf fulmin2,f

 movf fulmin2,w
 xorwf fulmin,f 
 
 
 movfw min_lower 
 movwf min2_lower 
 
 clrf min_lower
 
 
 
 
 
hllBBAAA: 

 banksel min_lower

 
 

hllCBAAA:	

 btfss neg,0
 goto hllDBAAA
 

 btfss neg,1
 goto hllDBAAA




 bsf minres,0

 goto hllUBAAA

 
 
 
 
hllDBAAA:
 

 btfss neg,0
 goto hllLBAAA 

 
hllEBAAA:

	
	
	
 movfw fulmin 
 subwf fulmin2,w 
 movwf mout 
 
 
 btfsc STATUS,C
 goto hllFBAAA		
		
	
 bsf minres,0	
	
	
 goto hllMBAAA	
	
hllFBAAA:

	
 movf mout,f
 btfsc STATUS,Z
 goto hllACAAA	
hllGBAAA:

	
 btfsc mout,7	
 goto hllIBAAA   
	
	
    
 LSHIFT mout
 
	
 btfss min_lower,7	
 goto hllHBAAA   

 
 decf mout,f	

	
 movlw .255
 xorwf mout,w
 btfss STATUS,Z
 goto hllHBAAA	
	
     
 bsf minres,0
 
	 
 goto hllMBAAA
	 

hllHBAAA:

   
 LSHIFT min_lower
 
	
 decf ein1,f	

	
 goto hllGBAAA

hllIBAAA:
	
 btfss min_lower,7	
 goto hllKBAAA   
		
	
 decf mout,f

	
 movlw .255
 xorwf mout,w
 btfss STATUS,Z
 goto hllJBAAA	
		
     
 bsf minres,0	 
	 
	 
 goto hllMBAAA	 
	 
	 
hllJBAAA:
	
 movlw .127
 xorwf mout,w
 btfss STATUS,Z
 goto hllKBAAA	
	
	
	
	
 LSHIFT mout
	
	
 decf ein1,f	
	
	
 btfsc min_lower,6
 goto hllKBAAA 
	
	
 incf mout,f	
	
hllKBAAA:
	
 goto hllACAAA
hllLBAAA:
 

	
 btfss neg,1
 goto hllUBAAA 
 
	
hllMBAAA:

	
 movfw fulmin2
 subwf fulmin,w 
 movwf mout 

 
 btfsc STATUS,C
 goto hllNBAAA		
	
	
	
	
 bsf minres,0
	
	
 goto hllEBAAA	

hllNBAAA:

	
 movf mout,f 
 btfsc STATUS,Z 
 goto hllACAAA 
	
hllOBAAA:

	
 btfsc mout,7
 goto hllIBAAAb
 
 	
	
    
 LSHIFT mout 
 
	
 btfss min2_lower,7
 goto hllPBAAA

	
	
 decf mout,f	
	
	
 movlw .255
 xorwf mout,w
 btfss STATUS,Z
 goto hllPBAAA	
	

 bsf minres,0
	

 goto hllEBAAA
	
hllPBAAA:

 
 LSHIFT min2_lower
 

 decf ein1,f
   
	
 goto hllOBAAA	
hllIBAAAb:

	
 btfss min2_lower,7
 goto hllSBAAA

	
 decf mout,f	
	
	
 movlw .255
 xorwf mout,w
 btfss STATUS,Z
 goto hllRBAAA	
		
	
 bsf minres,0
 
	
 goto hllEBAAA
hllRBAAA:


	
 movlw .127
 xorwf mout,w
 btfss STATUS,Z
 goto hllSBAAA	
		
	
	
	
 LSHIFT mout

	
 decf ein1,f	

	
 btfsc min2_lower,6
 goto hllSBAAA 
 
	
	
 incf mout,f	
	
hllSBAAA:

	
 goto hllACAAA

hllTBAAA:
	 
 movfw fulmin
 subwf fulmin2,w 
 movwf mout 
	 
	 
	 
     
 bsf minres,0	 
	
 goto hllACAAA

	
hllUBAAA:


 

	
 clrf mout_hi
	
	
	
 movf fulmin,w
 addwf fulmin2,w
 movwf mout
	
	

	
 btfss STATUS,C	
 goto hllVBAAA			
	
	
 incf mout_hi,f	
	
hllVBAAA:



	
 movf min_lower,w
 addwf min2_lower,w
 btfsc STATUS,C
 goto hllWBAAA   
 

	
	
 andlw .128	
 btfss STATUS,Z
 goto hllWBAAA	  
	
	
 goto hllXBAAA	
	
hllWBAAA:


	
 incf mout,f	
	
	
 movf mout,f
 btfss STATUS,Z
 goto hllXBAAA 

	
 incf mout_hi,f

hllXBAAA:
	
 movf mout_hi,f
 btfsc STATUS,Z
 goto hllACAAA 

	
	
	
	
 clrf big_c
 RSHIFT fulmin
 btfsc STATUS,C
 bsf big_c,0
	
	
 RSHIFT min_lower

	
	
 btfss big_c,0
 goto hllYBAAA
	
	
	
 bsf min_lower,7	
	
hllYBAAA:

	
	
 clrf big_c
 RSHIFT fulmin2
 btfsc STATUS,C
 bsf big_c,0
	
	
	
	
 RSHIFT min2_lower
	
	
	
 btfss big_c,0
 goto hllZBAAA

	
	
	
 bsf min_lower,7		
	
hllZBAAA:

	
 incf ein1,f	
	
	
 goto hllUBAAA


hllACAAA:

 movfw mout 
 
 
 btfss STATUS,Z 
 goto hllBCAAA 
 
 
 
 movlw .0 

 PUSH
 
 
 
 movlw 0x80 
 PUSH
 
 
 
 goto hllCCAAA
 
 
 
hllBCAAA: 
 
 
 
 
 movfw mout
 addlw -.128 
 movwf mout 

 
 
 
 btfsc minres,0 
 bsf mout,7
 
 movfw mout 
 PUSH
 
 
 
 banksel min
 movfw ein1 

 PUSH
 
hllCCAAA:
 
 return 

 


#undefine mout_hi


#undefine big_c


#undefine min2_lower


#undefine minres


#undefine fulmin2H


#undefine fulminH


#undefine min_lower


#undefine rev


#undefine fulmin2


#undefine fulmin


#undefine multiplier


#undefine mout


#undefine util


#undefine neg


#undefine ein2


#undefine min2


#undefine ein1


#undefine min
