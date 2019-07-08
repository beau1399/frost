
template<typename parm_type,typename language_type>
 void lillex
 (
  std::string &cbuffer,
  parm_type &parm, 
  language_type language,
  void (*whitespace)(std::string &)=0
 )
 {  
  
  if(whitespace)(*whitespace)(cbuffer); 
  bool skipdefault;
  while(cbuffer.length())
  {

    skipdefault=0;
  
	typename language_type::iterator pmaps=language.begin();   
    
    while(pmaps!=language.end())                
    {	 
	  if(cbuffer.find(pmaps->first)==0 && pmaps->first.compare(""))
	  {	  
	    bool (*pfunc)(parm_type&) ;
		pfunc=(pmaps->second);
	    if((*pfunc)(parm)) return;
		skipdefault=1;
		break;
	  }
	  ++pmaps;
	 }	
	 
  if(!skipdefault)
  {  
      bool (*pfunc)(parm_type&) ;
	  pfunc=(language.find("")->second); 
	  if((*pfunc)(parm)) return;
  }

  if(whitespace)(*whitespace)(cbuffer); 
 }

}

