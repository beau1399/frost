




 

sfp_log CODE 



#define moutH sfploc00


#define moutL sfploc01


#define mout sfploc02


#define rev sfploc03


#define neg sfploc04


#define exam sfploc05


#define util sfploc06


#define karg1 sfploc07


#define arg1 sfploc08


logf:  
#ifdef HLLMULTITASK
#ifdef HLLGUARDsfploc 
 movf in_isr,f  
 btfsc STATUS,Z
 


 goto logf0


 
 
 
 
 
 
 
logf: 


 POP
 
 banksel arg1
 movwf util 


 POP
 movwf mout 




 movf mout,f
 btfss STATUS,Z
 goto nzmdss



 movf util,f
 btfss STATUS,Z
 goto nzmdss 




 movlw .128
 PUSH
 PUSH
 


 return 

nzmdss:


 call look_core 
 movwf moutL 


 movf mout,w
 call look_core_hi
 movwf moutH 

 

 
 clrf neg
 
 
 btfss util,7
 goto nonegtlog

 
 bsf neg,0
 
 
 comf util,f 
 
 
 incf util,f 


 
nonegtlog:

 btfsc util,7
 goto fi5tt2
 btfsc util,6
 goto fi5tt3
 btfsc util,5
 goto fi5tt4
 btfsc util,4
 goto fi5tt5
 btfsc util,3
 goto fi5tt6
 btfsc util,2
 goto fi5tt7
 btfsc util,1
 goto fi5tt8
 btfsc util,0
 goto fi5tt9
 goto fi5ttz
 
 
fi5tt2:







 RSHIFT moutH
 
 
 
 


 rrf moutL
fi5tt3:
 
 
 
 
 
 
 RSHIFT moutH
 
 
 
 
 
 
 
 
 rrf moutL
fi5tt4:
 
 
 
 
 
 RSHIFT moutH
 
 
 
 
 
 
 rrf moutL
fi5tt5:
 
 
 
 
 
 
 
 RSHIFT moutH
 
 
 
 
 
 
 
 rrf moutL
fi5tt6:
 
 
 
 
 RSHIFT moutH
  
 
 
 
 
 rrf moutL
fi5tt7:
 
 
 
 
 
 RSHIFT moutH
 
 
 
 
 
 
 rrf moutL
fi5tt8:
 
 
 
 
 
 
 
 RSHIFT moutH
 
 
 
 
 
 
 
 
 
 
 rrf moutL
fi5tt9:
 
 
 
 
 
 
 RSHIFT moutH
 
 
 
 
 
 
 rrf moutL

 
 btfss STATUS,C
 goto fi5ttz
 
 
 incf moutL,f
 
 
 movf moutL,f
 btfsc STATUS,Z
 
 incf moutH,f
fi5ttz:

 
 
  btfss neg,0
  goto m1gd6
 
  comf moutH,f
 
  comf moutL,f
 
  incf moutL,f
 
  btfsc STATUS,Z
 
  incf moutH,f
 m1gd6:
 
 
  btfss util,7
  goto gkbb11
 
  movlw -.1
  movwf rev
 
  movf util,w
  addwf moutH,f
 
  goto kkbbg3
 gkbb11:

  btfss util,6
  goto gkbb22

 
   movlw -.2
   movwf rev

 
  bcf STATUS,C
  rlf util,w
  addwf moutH,f
  goto kkbbg3
 gkbb22:

  btfss util,5
  goto gkbb33

 
   movlw -.3
   movwf rev

 
   
   
   
   
   
   
 
 LSHIFT util
   
   
   
   
   
   bcf STATUS,C
   rlf util,w
   addwf moutH,f

  goto kkbbg3
 gkbb33:

  btfss util,4
  goto gkbb44

 
   movlw -.4
   movwf rev

 




 
 
 
 
 LSHIFT util




   bcf STATUS,C
   rlf util,w
   addwf moutH,f

  goto kkbbg3
 gkbb44:

  btfss util,3
  goto gkbb55

 
   movlw -.5
   movwf rev

 
 





 LSHIFT util
 LSHIFT util
 LSHIFT util
  


   bcf STATUS,C
   rlf util,w
   addwf moutH,f
   goto kkbbg3
 gkbb55:

  btfss util,2
  goto gkbb66

 
   movlw -.6
   movwf rev

 
  




  
  
 LSHIFT util
 LSHIFT util
 LSHIFT util
 LSHIFT util
 

 
 
 



   bcf STATUS,C
   rlf util,w
   addwf moutH,f
   goto kkbbg3

 gkbb66:

  btfss util,1
  goto gkbb77

 
   movlw -.7
   movwf rev







 btfss util,1
  goto ncrre
  movlw .128
  addwf moutH,f
ncrre: 
  btfss util,0
  goto kkbbg3
  movlw .64
  addwf moutH,f
  goto kkbbg3
gkbb77:
 
  btfss util,0
  goto gkbb88

 
   movlw -.8
   movwf rev

 
 
  
  movlw .128
  addwf moutH,f
 
  goto kkbbg3
gkbb88:
 
   movlw -.9
   movwf rev
kkbbg3:

 
 
 
 movf moutH,f
 btfsc STATUS,Z
 goto nrndmg00
 
normaa:
 
 movf moutH,w 
 btfsc STATUS,Z
 goto normaout




 
 
 
 
 
 
 
 
 
 
 
 
 
 
 RSHIFT moutH											
											
											
											
											
											
											
											
											
											
											
 rrf moutL,f 

 
 incf rev,f 
 
 goto normaa
 
 
 
normaout:
 
 btfss STATUS,C 
 goto nrndmg00

  
  incf moutL,f

 
 
  btfss STATUS,Z
  goto nrndmg00
 
  
 
 
 
 
 
  incf moutH,f
 
 
  incf rev,f
 
  movlw .128
  movwf moutL
 
nrndmg00:
 
 
 
 

 
 
 bcf moutL,7
 
 
 btfsc neg,0
 bsf moutL,7
 
 
 movf moutL,w
 PUSH
 
 movf rev,w
 PUSH
 
 return
 
look_core: 
 movlw high FPCoreTbk 
 movwf PCLATH 
 movlw low FPCoreTbk
 addwf mout,w 
 btfsc STATUS,C 
 incf PCLATH,f 
 movwf PCL 
FPCoreTbk: 
 retlw .0
 retlw .224
 retlw .186
 retlw .142
 retlw .93 
 retlw .39
 retlw .235
 retlw .170
 retlw .100
 retlw .25
 retlw .200
 retlw .115
 retlw .25 
 retlw .186
 retlw .86
 retlw .237
 retlw .129
 retlw .15
 retlw .152
 retlw .30
 retlw .159
 retlw .27
 retlw .148
 retlw .8
 retlw .120
 retlw .228
 retlw .76
 retlw .176
 retlw .16
 retlw .108
 retlw .197
 retlw .32
 retlw .106
 retlw .183
 retlw .2
 retlw .70
 retlw .137
 retlw .199
 retlw .32
 retlw .58
 retlw .111
 retlw .160
 retlw .206
 retlw .248
 retlw .32
 retlw .68
 retlw .101
 retlw .131
 retlw .157
 retlw .181
 retlw .202
 retlw .219
 retlw .234
 retlw .246
 retlw .200
 retlw .8
 retlw .8
 retlw .16
 retlw .6
 retlw .8
 retlw .250
 retlw .239
 retlw .226
 retlw .210
 retlw .193
 retlw .171
 retlw .148
 retlw .122
 retlw .94
 retlw .63
 retlw .30
 retlw .250
 retlw .212
 retlw .171
 retlw .129
 retlw .83
 retlw .36
 retlw .242
 retlw .190
 retlw .136
 retlw .80
 retlw .21
 retlw .217
 retlw .154
 retlw .89
 retlw .22
 retlw .209
 retlw .138
 retlw .64
 retlw .245
 retlw .168
 retlw .88
 retlw .16
 retlw .180
 retlw .95
 retlw .8
 retlw .175
 retlw .84
 retlw .247
 retlw .153
 retlw .56
 retlw .214
 retlw .114
 retlw .12
 retlw .165
 retlw .59
 retlw .208
 retlw .99
 retlw .245
 retlw .133
 retlw .19
 retlw .159
 retlw .42
 retlw .179
 retlw .59
 retlw .193
 retlw .69
 retlw .200
 retlw .73
 retlw .201
 retlw .70
 retlw .195
 retlw .62
 retlw .183
 retlw .47
 retlw .165
 retlw .27
 retlw .142 


look_core_hi: 
 movlw high FPCoreTblHi 
 movwf PCLATH 
 movlw low FPCoreTblHi 
 addwf mout,w 
 btfsc STATUS,C 
 incf PCLATH,f 
 movwf PCL 
 


#undefine moutH


#undefine moutL


#undefine mout


#undefine rev


#undefine neg


#undefine exam


#undefine util


#undefine karg1


#undefine arg1


#define moutH sfploc00+1


#define moutL sfploc01+1


#define mout sfploc02+1


#define rev sfploc03+1


#define neg sfploc04+1


#define exam sfploc05+1


#define util sfploc06+1


#define karg1 sfploc07+1


#define arg1 sfploc08+1


logf0:
#endif
#endif


 
 
 
 
 
 
 
hllDEAAA: 


 POP
 
 banksel arg1
 movwf util 


 POP
 movwf mout 




 movf mout,f
 btfss STATUS,Z
 goto hllEEAAA



 movf util,f
 btfss STATUS,Z
 goto hllEEAAA 




 movlw .128
 PUSH
 PUSH
 


 return 

hllEEAAA:


 call hllDFAAA 
 movwf moutL 


 movf mout,w
 call hllDFAAA_hi
 movwf moutH 

 

 
 clrf neg
 
 
 btfss util,7
 goto hllFEAAA

 
 bsf neg,0
 
 
 comf util,f 
 
 
 incf util,f 


 
hllFEAAA:

 btfsc util,7
 goto hllGEAAA
 btfsc util,6
 goto hllHEAAA
 btfsc util,5
 goto hllIEAAA
 btfsc util,4
 goto hllJEAAA
 btfsc util,3
 goto hllKEAAA
 btfsc util,2
 goto hllLEAAA
 btfsc util,1
 goto hllMEAAA
 btfsc util,0
 goto hllNEAAA
 goto hllOEAAA
 
 
hllGEAAA:







 RSHIFT moutH
 
 
 
 


 rrf moutL
hllHEAAA:
 
 
 
 
 
 
 RSHIFT moutH
 
 
 
 
 
 
 
 
 rrf moutL
hllIEAAA:
 
 
 
 
 
 RSHIFT moutH
 
 
 
 
 
 
 rrf moutL
hllJEAAA:
 
 
 
 
 
 
 
 RSHIFT moutH
 
 
 
 
 
 
 
 rrf moutL
hllKEAAA:
 
 
 
 
 RSHIFT moutH
  
 
 
 
 
 rrf moutL
hllLEAAA:
 
 
 
 
 
 RSHIFT moutH
 
 
 
 
 
 
 rrf moutL
hllMEAAA:
 
 
 
 
 
 
 
 RSHIFT moutH
 
 
 
 
 
 
 
 
 
 
 rrf moutL
hllNEAAA:
 
 
 
 
 
 
 RSHIFT moutH
 
 
 
 
 
 
 rrf moutL

 
 btfss STATUS,C
 goto hllOEAAA
 
 
 incf moutL,f
 
 
 movf moutL,f
 btfsc STATUS,Z
 
 incf moutH,f
hllOEAAA:

 
 
  btfss neg,0
  goto hllPEAAA
 
  comf moutH,f
 
  comf moutL,f
 
  incf moutL,f
 
  btfsc STATUS,Z
 
  incf moutH,f
 hllPEAAA:
 
 
  btfss util,7
  goto hllQEAAA
 
  movlw -.1
  movwf rev
 
  movf util,w
  addwf moutH,f
 
  goto hllZEAAA
 hllQEAAA:

  btfss util,6
  goto hllREAAA

 
   movlw -.2
   movwf rev

 
  bcf STATUS,C
  rlf util,w
  addwf moutH,f
  goto hllZEAAA
 hllREAAA:

  btfss util,5
  goto hllSEAAA

 
   movlw -.3
   movwf rev

 
   
   
   
   
   
   
 
 LSHIFT util
   
   
   
   
   
   bcf STATUS,C
   rlf util,w
   addwf moutH,f

  goto hllZEAAA
 hllSEAAA:

  btfss util,4
  goto hllTEAAA

 
   movlw -.4
   movwf rev

 




 
 
 
 
 LSHIFT util




   bcf STATUS,C
   rlf util,w
   addwf moutH,f

  goto hllZEAAA
 hllTEAAA:

  btfss util,3
  goto hllUEAAA

 
   movlw -.5
   movwf rev

 
 





 LSHIFT util
 LSHIFT util
 LSHIFT util
  


   bcf STATUS,C
   rlf util,w
   addwf moutH,f
   goto hllZEAAA
 hllUEAAA:

  btfss util,2
  goto hllVEAAA

 
   movlw -.6
   movwf rev

 
  




  
  
 LSHIFT util
 LSHIFT util
 LSHIFT util
 LSHIFT util
 

 
 
 



   bcf STATUS,C
   rlf util,w
   addwf moutH,f
   goto hllZEAAA

 hllVEAAA:

  btfss util,1
  goto hllXEAAA

 
   movlw -.7
   movwf rev







 btfss util,1
  goto hllWEAAA
  movlw .128
  addwf moutH,f
hllWEAAA: 
  btfss util,0
  goto hllZEAAA
  movlw .64
  addwf moutH,f
  goto hllZEAAA
hllXEAAA:
 
  btfss util,0
  goto hllYEAAA

 
   movlw -.8
   movwf rev

 
 
  
  movlw .128
  addwf moutH,f
 
  goto hllZEAAA
hllYEAAA:
 
   movlw -.9
   movwf rev
hllZEAAA:

 
 
 
 movf moutH,f
 btfsc STATUS,Z
 goto hllCFAAA
 
hllAFAAA:
 
 movf moutH,w 
 btfsc STATUS,Z
 goto hllBFAAA




 
 
 
 
 
 
 
 
 
 
 
 
 
 
 RSHIFT moutH											
											
											
											
											
											
											
											
											
											
											
 rrf moutL,f 

 
 incf rev,f 
 
 goto hllAFAAA
 
 
 
hllBFAAA:
 
 btfss STATUS,C 
 goto hllCFAAA

  
  incf moutL,f

 
 
  btfss STATUS,Z
  goto hllCFAAA
 
  
 
 
 
 
 
  incf moutH,f
 
 
  incf rev,f
 
  movlw .128
  movwf moutL
 
hllCFAAA:
 
 
 
 

 
 
 bcf moutL,7
 
 
 btfsc neg,0
 bsf moutL,7
 
 
 movf moutL,w
 PUSH
 
 movf rev,w
 PUSH
 
 return
 
hllDFAAA: 
 movlw high hllEFAAA 
 movwf PCLATH 
 movlw low hllEFAAA
 addwf mout,w 
 btfsc STATUS,C 
 incf PCLATH,f 
 movwf PCL 
hllEFAAA: 
 retlw .0
 retlw .224
 retlw .186
 retlw .142
 retlw .93 
 retlw .39
 retlw .235
 retlw .170
 retlw .100
 retlw .25
 retlw .200
 retlw .115
 retlw .25 
 retlw .186
 retlw .86
 retlw .237
 retlw .129
 retlw .15
 retlw .152
 retlw .30
 retlw .159
 retlw .27
 retlw .148
 retlw .8
 retlw .120
 retlw .228
 retlw .76
 retlw .176
 retlw .16
 retlw .108
 retlw .197
 retlw .32
 retlw .106
 retlw .183
 retlw .2
 retlw .70
 retlw .137
 retlw .199
 retlw .32
 retlw .58
 retlw .111
 retlw .160
 retlw .206
 retlw .248
 retlw .32
 retlw .68
 retlw .101
 retlw .131
 retlw .157
 retlw .181
 retlw .202
 retlw .219
 retlw .234
 retlw .246
 retlw .200
 retlw .8
 retlw .8
 retlw .16
 retlw .6
 retlw .8
 retlw .250
 retlw .239
 retlw .226
 retlw .210
 retlw .193
 retlw .171
 retlw .148
 retlw .122
 retlw .94
 retlw .63
 retlw .30
 retlw .250
 retlw .212
 retlw .171
 retlw .129
 retlw .83
 retlw .36
 retlw .242
 retlw .190
 retlw .136
 retlw .80
 retlw .21
 retlw .217
 retlw .154
 retlw .89
 retlw .22
 retlw .209
 retlw .138
 retlw .64
 retlw .245
 retlw .168
 retlw .88
 retlw .16
 retlw .180
 retlw .95
 retlw .8
 retlw .175
 retlw .84
 retlw .247
 retlw .153
 retlw .56
 retlw .214
 retlw .114
 retlw .12
 retlw .165
 retlw .59
 retlw .208
 retlw .99
 retlw .245
 retlw .133
 retlw .19
 retlw .159
 retlw .42
 retlw .179
 retlw .59
 retlw .193
 retlw .69
 retlw .200
 retlw .73
 retlw .201
 retlw .70
 retlw .195
 retlw .62
 retlw .183
 retlw .47
 retlw .165
 retlw .27
 retlw .142 


hllDFAAA_hi: 
 movlw high FPCoreTblHi 
 movwf PCLATH 
 movlw low FPCoreTblHi 
 addwf mout,w 
 btfsc STATUS,C 
 incf PCLATH,f 
 movwf PCL 
 


#undefine moutH


#undefine moutL


#undefine mout


#undefine rev


#undefine neg


#undefine exam


#undefine util


#undefine karg1


#undefine arg1
FPCoreTblHi: 
 retlw .0
 retlw .2
 retlw .5
 retlw .8
 retlw .11
 retlw .14
 retlw .16
 retlw .19
 retlw .22
 retlw .25
 retlw .27
 retlw .30
 retlw .33
 retlw .35
 retlw .38
 retlw .40
 retlw .43
 retlw .46
 retlw .48
 retlw .51
 retlw .53
 retlw .56
 retlw .58
 retlw .61
 retlw .63
 retlw .65
 retlw .68
 retlw .70
 retlw .73
 retlw .75
 retlw .77
 retlw .80
 retlw .82
 retlw .84
 retlw .87
 retlw .89
 retlw .91
 retlw .93
 retlw .96
 retlw .98
 retlw .100
 retlw .102
 retlw .104
 retlw .106
 retlw .109
 retlw .111
 retlw .113
 retlw .115
 retlw .117
 retlw .119
 retlw .121
 retlw .123
 retlw .125
 retlw .127
 retlw .129
 retlw .132
 retlw .134
 retlw .136
 retlw .138
 retlw .140
 retlw .141
 retlw .143
 retlw .145
 retlw .147
 retlw .149
 retlw .151
 retlw .153
 retlw .155
 retlw .157
 retlw .159
 retlw .161
 retlw .162
 retlw .164
 retlw .166
 retlw .168
 retlw .170
 retlw .172
 retlw .173
 retlw .175
 retlw .177
 retlw .179
 retlw .181
 retlw .182
 retlw .184
 retlw .186
 retlw .188
 retlw .189
 retlw .191
 retlw .193
 retlw .194
 retlw .196
 retlw .198
 retlw .200
 retlw .201
 retlw .203
 retlw .205
 retlw .206
 retlw .208
 retlw .209
 retlw .211
 retlw .213
 retlw .214
 retlw .216
 retlw .218
 retlw .219
 retlw .221
 retlw .222
 retlw .224
 retlw .225
 retlw .227
 retlw .229
 retlw .230
 retlw .232
 retlw .233
 retlw .235
 retlw .236
 retlw .238
 retlw .239
 retlw .241
 retlw .242
 retlw .244
 retlw .245
 retlw .247
 retlw .248
 retlw .250
 retlw .251
 retlw .253
 retlw .254

 