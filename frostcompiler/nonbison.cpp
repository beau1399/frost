//TODO - some of this should be in another file, frost semantics file
//TODO - naming in this file is a bit of a mess
#include<vector> 
#include<set>
#include<string>
#include<map>
#include<iterator>
#include<sstream>
#include<fstream>
#include<iostream>
#include<dirent.h> //POSIX folder traversal functions
#include<algorithm>
#include<cmath>
#include<stack>
#include "lillexer.h"
#include "frostcore.h"
//Often too broad, here it avoids about a dozen "using" statments
using namespace std;
#include "state.h"
#define HLL_STRANGE_CHAR "~"
#define HLL_STRANGE_STRING "~IFTR~"
extern ofstream target_s;  //Generated assembly language output
extern ofstream inc_file_s;  //HLOE libs include this for portability
extern ofstream make_file_s;  //Build script for target
///////////////////////////MACRO EXPANDER////////////////////////////////////////////////
void expand_macros(string &macrobuf, const map<string,string> &macromap, 
const vector<string> &macroorder, const bool hloe)
{
 vector<string> * macparms;
 string macrobuf2=macrobuf;
 bool mfound;
 do{
  mfound=0;  
  for(vector<string>::const_reverse_iterator maci=macroorder.rbegin();maci!=macroorder.rend(); 
  ++maci)
  { //For each macro name...
   while( macrobuf.find((*maci))>=0 &&
   macrobuf.find((*maci))<macrobuf.length() ) //Look for the macro name
   {
    mfound=1;
    macrobuf2=macrobuf.substr(0,macrobuf.find((*maci))); //Pre-macro text
    string macj;
    int macjcount=0;     
    macj=macrobuf.substr(macrobuf.find((*maci))+(*maci).length());
    macparms=new vector<string>();
    do
    { 
     while(isspace(macj[0])||macj[0]=='\r'||macj[0]=='\n') 
     {macjcount+=macj.length();
      macj.erase(0,1);
      macjcount-=macj.length();
     }
     vector<char> cparm;
     if((macj[0]=='`'||macj[0]=='(')&&!hloe)
     {
      macjcount+=macj.length();
      macj.erase(0,1);
      macjcount-=macj.length();
      int mdepth=1;
      while(mdepth)
      {  
       if(macj[0]=='\\'||macj[0]==')') --mdepth;
       if(macj[0]=='`'||macj[0]=='(') ++mdepth;
       if(mdepth){cparm.push_back(macj[0]);
        macjcount+=macj.length();
        macj.erase(0,1);
        macjcount-=macj.length();
       }
      }
      macjcount+=macj.length();
      macj.erase(0,1);
      macjcount-=macj.length();
     }else  break;
     string stringcparm;
     for(vector<char>::const_iterator vci=cparm.begin();vci!=cparm.end();++vci)
     {stringcparm.insert(stringcparm.end(),*vci);}
     macparms->insert(macparms->end(),stringcparm);
    }while(1);
    string mbody=(macromap.find(*maci))->second;
    string mbody2("");
    //Parameterize the macro
    while((!hloe)&&mbody.find("$")>=0 && mbody.find("$")<mbody.length() )
    {
     mbody2=mbody.substr(0,mbody.find("$"));
     int pk;  
     istringstream macsr(mbody.substr(mbody.find("$")+1));
     macsr>>pk;
     if(*(mbody.c_str()+2+mbody.find("$"))=='-') //Assumes parms0-9; whitespace !allowed
     {      
      int todec1;
      istringstream mac_psr((*macparms)[pk]);
      mac_psr>>todec1;
      ostringstream mac_osr;
      mac_osr<<(todec1-1);
      mbody2.append(mac_osr.str());
      mbody2.append(mbody.substr(mbody.find("$")+3)); 
     }
     else if(*(mbody.c_str()+2+mbody.find("$"))=='+')
     {
      int todec1;
      istringstream mac_psr((*macparms)[pk]);
      mac_psr>>todec1;
      ostringstream mac_osr;
      mac_osr<<(todec1+1);
      mbody2.append(mac_osr.str());
      mbody2.append(mbody.substr(mbody.find("$")+3)); 
     }
     else
     {
      mbody2.append((*macparms)[pk]);  
      if(mbody.find("$")+2<mbody.length())
      mbody2.append(mbody.substr(mbody.find("$")+2)); 
     }
     mbody=mbody2;
    }    
    while(mbody.find("when=")>=0 && mbody.find("when=")<mbody.length() )
    {
      //These (when= and when!) were implemented w/o using the old C string stuff originally...
      //  this broke for some reason during the transition to Linux- TODO!
     mbody2=mbody.substr(0,mbody.find("when="));    
     string when1str,when2str;
     const char * m_cstr = mbody.c_str();     
     while(*m_cstr!='=') ++m_cstr;
     int mbitc=1;
     ++m_cstr;     
     while(isspace(*m_cstr)) { ++m_cstr; ++mbitc; }
     while(!isspace(*m_cstr)) {when1str+=*m_cstr++; ++mbitc; }
     while(isspace(*m_cstr)){ ++m_cstr; ++mbitc;}
     while(!isspace(*m_cstr)) {when2str+=*m_cstr++; ++mbitc; }     
     if(!when1str.compare(when2str))/*same philos. for expansion scope*/
     {                             /* - assume 1 char of whitesp. in defs*/
       int lmacer=mbody.find("when=")+mbitc+6;
       int rmacer=mbody.find("end=")-1;
       mbody2.append(mbody.substr(lmacer,rmacer-lmacer));
     }   
     if(mbody.find("end=")+5 < mbody.length())
     mbody2.append(mbody.substr(mbody.find("end=")+5));
     mbody=mbody2;
    }             
    while(mbody.find("when!")>=0 && mbody.find("when!")<mbody.length() )
    {
     mbody2=mbody.substr(0,mbody.find("when!"));    
     string when1str,when2str;
     const char * m_cstr = mbody.c_str();     
     while(*m_cstr!='!') ++m_cstr;
     int mbitc=1;
     ++m_cstr;     
     while(isspace(*m_cstr)) { ++m_cstr; ++mbitc; }
     while(!isspace(*m_cstr)) {when1str+=*m_cstr++; ++mbitc; }
     while(isspace(*m_cstr)){ ++m_cstr; ++mbitc;}
     while(!isspace(*m_cstr)) {when2str+=*m_cstr++; ++mbitc; }     
     if(when1str.compare(when2str))/*same philos. for expansion scope*/
     {                             /* - assume 1 char of whitesp. in defs*/
       int lmacer=mbody.find("when!")+mbitc+6;
       int rmacer=mbody.find("end!")-1;
       mbody2.append(mbody.substr(lmacer,rmacer-lmacer));
     }   
     if(mbody.find("end!")+5 < mbody.length())
     mbody2.append(mbody.substr(mbody.find("end!")+5));
     mbody=mbody2;
    }                
    delete macparms;
    macrobuf2.append(mbody); //Append result of parameterization &c to pre-macro text  
    if(!hloe)macrobuf2.append(" "); 
    macrobuf2.append( //Append post-macro-text
    macrobuf.substr(macrobuf.find((*maci))+(*maci).length()+macjcount*(1-hloe))
    );
    macrobuf=macrobuf2; //Set overall result for next run of outer macro system loop
   }
  }
 }while(mfound);
}
//Throw error if not valid character for identifier our small HLOE assembly language...
void check_id(const char buffer)
{
 //Should work w/ most character systems
 if( (!(buffer>='A'&&buffer<='Z')) && (!(buffer>='a'&&buffer<='z')) &&(buffer!='-') 
   &&(buffer!='_') 
   )
 app_error("^ LETTER (IDENTIFIER) EXPECTED",buffer);
}
/////////////////////////////////////////PRECOMPILE LANGUAGE PARSER//////////////////////
struct macro_parser_parms
{
 string slot; 
 string usercode; 
 map<string,string> macromap; 
 set<string> funcs;
 vector<string> macroorder;
 set<string> statics; 
 string savecode;
};
bool var(macro_parser_parms &mpp);
bool comment(macro_parser_parms &mpp);
bool calls(macro_parser_parms &mpp);
bool macro(macro_parser_parms &mpp);
bool stackis(macro_parser_parms &mpp);
bool altstackis(macro_parser_parms &mpp);
bool runtime(macro_parser_parms &mpp);
void compile_time_language(string &usercode,set<string> &funcs,
map<string,string> &macromap, vector<string> &macroorder, set<string> &statics)
{
 static string savecode;
 string slot;
 static macro_parser_parms mpp;
 mpp.slot=slot;
 mpp.usercode=usercode;
 mpp.macromap=macromap;
 mpp.funcs=funcs;
 mpp.macroorder=macroorder;
 mpp.statics=statics;
 mpp.savecode=savecode;
 mpp.savecode=""; 
 map<string, bool (*)(macro_parser_parms&) > language;
 language["/"]=comment;
 language["stack is "]=stackis; language["stack is\t"]=stackis;
 language["stack is\n"]=stackis;
 language["altstack is "]=altstackis; language["altstack is\t"]=altstackis;
 language["altstack is\n"]=altstackis;
 language["macro "]=macro;
 language["macro\t"]=macro;
 language["macro\r"]=macro; //For UNIX
 language["macro\n"]=macro;
 language["calls "]=calls; language["calls\t"]=calls; language["calls\n"]=calls;
 language["var "]=var; language["var\t"]=var; language["var\n"]=var;
 language[""]=runtime;
 lillex(mpp.usercode,mpp,language,&whitespace); 
 macromap=mpp.macromap;
 funcs=mpp.funcs;
 macroorder=mpp.macroorder;
 statics=mpp.statics;
 usercode=mpp.savecode;
}
bool var(macro_parser_parms &mpp)
{  //Looking for "var"
 while((mpp.usercode.length())&&( (!(mpp.usercode.find("var ")))||(!(mpp.usercode.find("var\t")))||
 (!(mpp.usercode.find(","))) ||(!(mpp.usercode.find("var\n")))   ))
 {
  mpp.slot="";
  if(mpp.usercode.find(",")){inc_buffer(mpp.usercode);inc_buffer(mpp.usercode);}//eat "va"
  inc_buffer(mpp.usercode); //eat "," or "r"
  whitespace(mpp.usercode);
  while(!isspace(mpp.usercode[0])&&mpp.usercode[0]!=','&&mpp.usercode.length()>0)
  {
   check_id(mpp.usercode[0]);
   mpp.slot+=mpp.usercode[0];
   inc_buffer(mpp.usercode);    
  }
  mpp.statics.insert(mpp.statics.begin(),mpp.slot);
  whitespace(mpp.usercode);   
 }
 whitespace(mpp.usercode);
 return 0;
}
bool comment(macro_parser_parms &mpp)
{
 while(mpp.usercode[0] && mpp.usercode[0]!='\n' && mpp.usercode[0]!='\r') inc_buffer(mpp.usercode);
 whitespace(mpp.usercode);
 return 0;
}
bool calls(macro_parser_parms &mpp)
{  //Looking for "calls"
 while((mpp.usercode.length())&&( (!(mpp.usercode.find("calls ")))||
 (!(mpp.usercode.find("calls\t")))  ||  (!(mpp.usercode.find(",")))||
 (!(mpp.usercode.find("calls\n"))))) 
 {
  mpp.slot="";
  if(mpp.usercode.find(",")){inc_buffer(mpp.usercode);inc_buffer(mpp.usercode);inc_buffer(mpp.usercode);
   inc_buffer(mpp.usercode);}
  inc_buffer(mpp.usercode);  //eat "," or "s"
  whitespace(mpp.usercode);
  while(!isspace(mpp.usercode[0])&&mpp.usercode[0]!=','&&mpp.usercode.length()>0)
  {
   check_id(mpp.usercode[0]);
   mpp.slot+=mpp.usercode[0];
   inc_buffer(mpp.usercode); 
  }
  mpp.funcs.insert(mpp.funcs.begin(),mpp.slot);
  whitespace(mpp.usercode);   
 }
 whitespace(mpp.usercode);
 return 0;
}
bool macro(macro_parser_parms &mpp)
{
 mpp.slot="";
 inc_buffer(mpp.usercode); inc_buffer(mpp.usercode); inc_buffer(mpp.usercode);
 inc_buffer(mpp.usercode); inc_buffer(mpp.usercode); //Eat "macro"
 whitespace(mpp.usercode);
 while(!isspace(mpp.usercode[0]) )
 {
  mpp.slot+=mpp.usercode[0];
  inc_buffer(mpp.usercode); 
 } 
 whitespace(mpp.usercode); // is... 
 // Macro content begins two characters after "is" (1 spc
 // assumed) This should allow complete flexibility to
 // expand to a prespaced or unspaced output.
 inc_buffer(mpp.usercode);inc_buffer(mpp.usercode);inc_buffer(mpp.usercode);//"is "
 string stringvalue;
 //Again, 1 space is assumed (i.e. removed from the expansion) at macro end; hence >1
 while(mpp.usercode.find("end macro")>1)
 {
  stringvalue+=mpp.usercode[0];
  inc_buffer(mpp.usercode);
 }
 mpp.macromap[string(mpp.slot)]=stringvalue; 
 mpp.macroorder.insert(mpp.macroorder.begin(),string(mpp.slot));
 for (int anind=0; anind<string("end macro").length()+1; ++anind) mpp.usercode.erase(0,1);
 whitespace(mpp.usercode);
 return 0;
}
bool stackis(macro_parser_parms &mpp)
{
 get_header_value("stack is",mpp.usercode);
 return 0;
}
bool altstackis(macro_parser_parms &mpp)
{
 get_header_value("altstack is",mpp.usercode);
 return 0;
}
bool runtime(macro_parser_parms &mpp)
{   
 //Skip (but save) the runtime component... one token of non-header info plus all
 // whitespace thereafter
 while(!isspace(mpp.usercode[0])  && mpp.usercode.length() )
 {mpp.savecode.append(mpp.usercode.substr(0,1)); inc_buffer(mpp.usercode); 
 }
 while(isspace(mpp.usercode[0]) && mpp.usercode.length())
 {mpp.savecode.append(mpp.usercode.substr(0,1)); inc_buffer(mpp.usercode); 
 }
 return 0;
}
void remove_comments(string &usercode,const string &tkn)
{
 string token=tkn;
 static string usercode2;
 usercode2="";
 while( usercode.find(token)>=0 && usercode.find(token)<usercode.length() )
 { 
  if(usercode.find(token)&&usercode[usercode.find(token)-1]=='\'')
  { //Support character literals e.g. in .HLOE files; replace with special char.
   usercode=usercode.substr(0,usercode.find(token))+string(HLL_STRANGE_CHAR)+
   usercode.substr(usercode.find(token)+1);
   continue;  
  }
  usercode2=usercode.substr(0,usercode.find(token));
  usercode=usercode.substr(usercode.find(token));
  if(usercode.find("\n")>=0 && usercode.find("\n")<usercode.length())
  {usercode=usercode.substr(usercode.find("\n"));}
  else usercode="";   //Unterminated comment at source file end
  usercode2.append(usercode);
  usercode=usercode2;
 }
 token=HLL_STRANGE_CHAR; //Support character literals
 while( usercode.find(token)>=0 && usercode.find(token)<usercode.length() )
 { 
  usercode2=usercode.substr(0,usercode.find(token))+tkn;
  usercode=usercode.substr(usercode.find(token)+1);
  usercode2.append(usercode);
  usercode=usercode2;
 }
}
bool is_definition(string fcode)
{
 static set<string> dummy0;
 static map<string,string> dummy1;
 static vector<string> dummy2;
 static set<string> dummy3;
 compile_time_language(fcode,dummy0,dummy1,dummy2,dummy3);
 whitespace(fcode);
 if(fcode[0]!='d') return false;
 inc_buffer(fcode);
 if(!(isspace(fcode[0]))) return false;
 return true;
}
//MPASM constants must be transformed to remove - and lower case letters
char makempasmid(char psl0) 
{
 if(psl0>='a' && psl0<='z') return (psl0-'a'+'A'); //All caps
 else if(psl0=='-') return '_'; //Underscores (vs. frost dashed)
 else if(psl0>='0' && psl0<='9')  return psl0; //Emit digits directly
 else if(psl0>='A' && psl0<='Z')  return psl0; //Emit caps directly
 else app_error("^EXPECTED MPASM IDENT",psl0); 
}
char makefunctionname(char psl0) 
{
 if(psl0=='-') return '_';
 else return psl0;
}
//Translate c.ds_to_calls into pure bottom-level listings for "#define hllguard" series
void list_bottom_level_calls(compilerstate &c)
{
 map< string, vector<string> >::iterator pout; 
 bool inserted;
 do{
  pout=c.ds_to_calls.begin();
  inserted=0;
  while(pout!=c.ds_to_calls.end())
  {
   map< string, vector<string> >::iterator pin=c.ds_to_calls.begin(); 
   while(pin!=c.ds_to_calls.end())
   {//pin->first is a "d" and pout->first is a c.ds_to_calls; 
    //  so if pout->first if anything (non-recursive) in 
    //pin->second is pout->first, replace it in pin->second with pout->second
    if((!(pin->first.compare(pout->first)))) {++pin;continue;}
    vector<string>::iterator torepl=pin->second.begin();
    while(torepl!=pin->second.end()) 
    {
     if(!(pout->first.compare(*torepl)))
     {
      string avoid=*torepl;
      pin->second.erase(torepl);
      vector<string>::iterator toins=pout->second.begin();
      while(toins!=pout->second.end())
      {
       if(toins->compare(avoid))pin->second.insert(pin->second.end(),*toins); 
       ++toins;
      }
      inserted=1;
      break;
     }
     ++torepl;
    }
    if(inserted) break; 
    ++pin;
   }
   if(inserted) break;
   ++pout;
  }
 }while(inserted); 
}
void list_function_thunks(compilerstate &c, map<string,vector<string> > &ds_to_thunks )
{
 //TRANSLATE c.ds_to_calls INTO THUNK-LEVEL LISTINGS
 map< string, vector<string> >::iterator pout;
 pout=c.ds_to_calls.begin();
 while(pout!=c.ds_to_calls.end())
 {
  vector<string>::iterator toins=pout->second.begin();
  while(toins!=pout->second.end()) //pout.2nd is a list of calls; pout.1st is "d" caller
  {
   //toins is a  bottom-level call (c.ds_to_calls[k].calls[k])
   ds_to_thunks[pout->first].insert(ds_to_thunks[pout->first].begin(),c.thunks[*toins]); 
   toins++;
  }
  ++pout;
 }
 set<string>::iterator pcfuncs=c.funcs.begin(); 
 while(pcfuncs!=c.funcs.end())
 {
  bool lfd=0;
  set<string>::iterator pc1=c.maincalls.begin();
  while(pc1!=c.maincalls.end())
  {
   if(!(pc1->compare(*pcfuncs)))  lfd=1; 
   ++pc1;
  }
  pc1=c.eventcalls.begin();
  while(pc1!=c.eventcalls.end())
  {
   if(!(pc1->compare(*pcfuncs)))  lfd=1;
   ++pc1;
  }
  //Does any "d" function call *pcfuncs?
  pout=c.ds_to_calls.begin();
  while(pout!=c.ds_to_calls.end())
  {
   vector<string>::iterator toins=pout->second.begin();
   while(toins!=pout->second.end()) //pout.2nd is a list of calls; pout.1st is "d" caller
   {
    if(!(toins->compare(*pcfuncs))) lfd=1;
    ++toins;
   }
   ++pout;
  }
  if(!lfd)
  {
   c.funcs.erase(pcfuncs);
   pcfuncs=c.funcs.begin();
   continue;
  } 
  ++pcfuncs;
 }
}
void list_task_thunks(compilerstate &c, const map<string,vector<string> >& ds_to_thunks )
{
 bool found1;
 for(int toplevels=0;toplevels<=1;++toplevels)
 {
  do
  {    
   set<string>::iterator mcv; 
   if(!toplevels)
   mcv=c.maincalls.begin();
   else 
   mcv=c.eventcalls.begin();
   found1=0;
   while(mcv!=((toplevels?c.eventcalls:c.maincalls).end()))
   {
    if(  
      ds_to_thunks.find(*mcv)!=ds_to_thunks.end()
      &&
      (!((ds_to_thunks.find(*mcv))->second.empty())) 
      )
    {  
     string mcvwork=*mcv;  
     (toplevels?c.eventcalls:c.maincalls).erase(mcv);
     vector<string>::const_iterator mct=((ds_to_thunks.find(mcvwork))->second).begin();
     while(mct!=(ds_to_thunks.find(mcvwork))->second.end())
     {    
      (toplevels?c.eventcalls:c.maincalls).insert
      ((toplevels?c.eventcalls:c.maincalls).begin(),*mct++);
     }        
     found1=1;
     break;
    }else if(c.thunks[*mcv].length())
    { //Remaining bottom level call from original "c.maincalls" from ISR compilation     
     string targ("");
     targ=c.thunks[*mcv];  
     (toplevels?c.eventcalls:c.maincalls).erase(mcv);
     (toplevels?c.eventcalls:c.maincalls).insert((toplevels?c.eventcalls:c.maincalls).begin(),
     targ);
     found1=1;
     break;
    }else{ //It's either a c.thunkspace or a non-thunk call into a kernel function
     set<string>::iterator kcalls=c.funcs.begin();
     while(kcalls!=c.funcs.end())
     {
      if(!(mcv->compare(*kcalls++)))
      { //It's a call into a thunkless kernel function 
       (toplevels?c.eventcalls:c.maincalls).erase(mcv);
       found1=1;
       break;    
      }
     }
    }
    if(found1) break;
    mcv++;
   }
  }while(found1);
 }
}
//Traverse file folder for libs
vector<string> getdirs(string dir);
void compile_hloe(const vector<string> libs,map<string,string> &thunks)
{                          
 vector<string>::const_iterator ps=libs.begin();   
 while(ps!=libs.end())                
 {
  string s=*ps++;
  string sfind=get_module_name(s,".hloe",0,1);
  string srccode,usercode,parmlist,expand; 
  //If s.hloe doesn't exist, return
  ifstream filein((sfind).c_str(),ios::in);
  static char sequencize[6]={'A','A','A','A','A','\0'}; //26*26*26*26*26 labels per CPU
  remove((s+(".asm")).c_str()); //Delete s.asm... 5 in next stmt is strlen(".hloe")
  ofstream objecf((sfind.substr(0,sfind.length()-5)+(".asm")).c_str(),ios::out);
  while(!filein.eof()&&filein.peek()!=EOF) srccode+=(filein.get());//Read s.hloe->srccode 
  filein.close();
  remove_comments(srccode,";"); 
  remove_comments(srccode,"GLOBAL"); //Do not want; everything ends up in the same file
  string srccode2; 
  while(srccode.find("HLTHUNK")>=0 &&srccode.find("HLTHUNK")<srccode.length())
  {   //Find each HLTHUNK/HLEND pair... put interior into "usercode"
   vector<string> vars; //Ea. of these will have a vars list
   string thunkn(""); //Thunk name
   string thunkspace(""); //Thunk namespace
   usercode=srccode.substr(srccode.find("HLTHUNK")+string("HLTHUNK").length());
   whitespace(usercode);
   parmlist=" ";      
   bool foundcomma;   
   do
   {
    while(usercode[0]=='-' || (usercode[0]>='A' && usercode[0]<='Z') ||  
    (usercode[0]>='a' && usercode[0]<='z') ||
    (usercode[0]>='0' && usercode[0]<='9') || usercode[0]=='_') 
    {
     parmlist+=usercode[0];
     usercode.erase(0,1);
    }
    string pre=usercode;
    whitespace(usercode);
    foundcomma=(usercode[0]==',');
    if(foundcomma)
    {
     parmlist+=",";
     usercode.erase(0,1);
     whitespace(usercode); 
    }else usercode=pre; //Restore last whitespace... it is significant
   }while(foundcomma);
   parmlist+="\n"; 
   if(usercode.find(usercode.find("HLEND"))<0) app_error("^ UNMATCHED THUNK",usercode[0]);    
   usercode=usercode.substr(0,usercode.find("HLEND"));
   whitespace(parmlist); //Get thunk namespace and name
   thunkspace=parmlist.substr(0,parmlist.find(","));
   parmlist=parmlist.substr(parmlist.find(",")+1);
   whitespace(parmlist);
   thunkn=parmlist.substr(0,parmlist.find(","));
   parmlist=parmlist.substr(parmlist.find(",")+1);
   thunks[thunkn]=thunkspace;       
   do{  //Build a var list...
    string parmt;
    parmt=parmlist.substr(0,parmlist.find(","));
    whitespace(parmt);    
    if(parmlist.find(",")>=0&&parmlist.find(",")<parmlist.length())
    parmlist=parmlist.substr(parmlist.find(",")+1); 
    else
    parmlist="";
    if(parmt[parmt.length()-1]=='\t')parmt=parmt.substr(0,parmt.find("\t"));
    if(parmt[parmt.length()-1]==' ')parmt=parmt.substr(0,parmt.find(" "));
    if(parmt[parmt.length()-1]=='\n')parmt=parmt.substr(0,parmt.find("\n"));
    vars.insert(vars.begin(),parmt); 
   }while(parmlist.length()>0);   
   objecf<<srccode.substr(0,srccode.find("HLTHUNK"));
   srccode=srccode.substr(srccode.find("HLEND")+string("HLEND").length());
   whitespace(srccode);
   map<string,string> labes;    //Mangle labels for next section
   vector<string> labeorder;
   string srccode2=usercode;
   while(srccode2.find(":")>=0 &&srccode2.find(":")<srccode2.length())
   {  
    string getname=srccode2.substr(0,srccode2.find(":"));
    getname= getname.substr( getname.find_last_of("\n")+1);
    whitespace(getname);
    labes[getname]=(read_file(get_module_name("mangle",".inc",0,1))+string(sequencize)); 
    labeorder.insert(labeorder.begin(),getname);
    srccode2=srccode2.substr(srccode2.find(":")+1);
    sequencize[0]++; 
    if(sequencize[0]>'Z'){
     sequencize[0]='A'; sequencize[1]++; 
     if(sequencize[1]>'Z'){
      sequencize[1]='A'; sequencize[2]++;    
      if(sequencize[2]>'Z'){
       sequencize[2]='A'; sequencize[3]++;    
       if(sequencize[3]>'Z'){
        sequencize[3]='A'; sequencize[4]++; 
       }
      }
     }
    }
   }  
   char vrn[3]; //Variable number... goes up to 100 per namespace
   vrn[0]=vrn[1]='0';
   vrn[2]='\0';
   vector<string>::iterator pvars=vars.begin();
   while(pvars!=vars.end()){
    emit_inclusion(("hloevar"),(".inc"),*pvars++,thunkspace+vrn,objecf);
    if(++(vrn[1])>'9'){vrn[1]='0';++(vrn[0]);} }
   emit_inclusion(("thunk"),(".inc"),thunkn,thunkspace,objecf);      
   emit_inclusion(("hloejmp"),(".inc"),thunkn,usercode,objecf);   
   //Mangle labels for next section (Apply)... done within thunk (no cross-calling)
   expand_macros(usercode,labes,labeorder,1);     
   pvars=vars.begin();
   while(pvars!=vars.end())
   {emit_inclusion(("hloeudef"),(".inc"),*pvars,*pvars,objecf); ++pvars;}
   pvars=vars.begin();
   vrn[0]=vrn[1]='0';
   while(pvars!=vars.end()){
    {emit_inclusion(("hloedef"),(".inc"),*pvars,thunkspace+vrn+"+1",objecf); ++pvars;}
    if(++(vrn[1])>'9'){vrn[1]='0';++(vrn[0]);}
   }
   emit_inclusion(("altcode"),(".inc"),thunkn+"0:",usercode,objecf);   
   pvars=vars.begin();
   while(pvars!=vars.end())
   {emit_inclusion(("hloevdef"),(".inc"),*pvars,*pvars,objecf); ++pvars;}
  } 
  objecf<<srccode; 
  objecf.close();  
 } 
}
char lcasex(char psl0) 
{
 if(psl0>='A' && psl0<='Z') return (psl0-'A'+'a'); //All caps
 else return psl0;  
}
vector<string> find_libs(const set<string> funcs, const bool checks)
{
 map<string,vector<string> > libstofuncs;
 vector<string> gd=getdirs(getenv("FROST")); 
 vector<string>::iterator pfi=gd.begin();
 while(pfi!=gd.end())
 { 
  transform(pfi->begin(), pfi->end(), pfi->begin(), lcasex); 
  if(pfi->find(".hloe")!=string::npos)
  {
   ifstream dothloe((string(getenv("FROST"))+*pfi).c_str());
   string dotline;
   while(!(dothloe.fail()))
   {
    dothloe>>dotline;
    whitespace(dotline);
    if(!(dotline.find("GLOBAL")))
    {
     string utillib;
     while(dothloe.peek()!='\n') 
     {
      if(dothloe.peek()==',')
      {
       libstofuncs[pfi->substr(0,pfi->length()-string(".hloe").length())].
       insert(libstofuncs[pfi->substr(0,pfi->length()-string(".hloe").length())].end(),
       utillib);
       utillib="";
       dothloe.get();
      }
      else if(!isspace(dothloe.peek()))
      {
       utillib+=dothloe.get();
      }else dothloe.get();
     }
     libstofuncs[pfi->substr(0,pfi->length()-string(".hloe").length())].
     insert(libstofuncs[pfi->substr(0,pfi->length()-string(".hloe").length())].end(),
     utillib);
     dothloe.get(); //Eat endl
    }
   }
   dothloe.close();
  }
  ++pfi;
 }
 set<string> thelibs; 
 set<string>::iterator vi=funcs.begin();
 while(vi!=funcs.end())
 {
  map<string,vector<string> >::iterator wi=libstofuncs.begin();
  while(wi!=libstofuncs.end())
  {
   vector<string>::iterator xi=wi->second.begin();
   while(xi!=wi->second.end())
   {
    if(!(xi->compare(*vi))){thelibs.insert(wi->first); 
    }
    ++xi;
   }
   ++wi;
  }  
  ++vi;
 }
 //If, for any found lib, there is another .hloe file whose name is the first N chars
 // of the found lib's name, then by rule that second lib is a dependency also (e.g.
 // "sfp" for "sfpaddf" and such).
 set<string>::iterator yi=thelibs.begin(); 
 thelibs.insert(("kernel"));
 if(checks)thelibs.insert(("safepush"));
 while(yi!=thelibs.end()) 
 {
  pfi=gd.begin();
  while(pfi!=gd.end()) //pfi=potential root lib (w/extension); yi=potential sub-lib
  {
   transform(pfi->begin(), pfi->end(), pfi->begin(), lcasex); 
   if(pfi->find(".hloe")!=string::npos)
   {
    string pfroot=pfi->substr(0,pfi->length()-string(".hloe").length());
    if(pfroot.length()<yi->length())
    { 
     if(!(yi->find(pfroot))){ thelibs.insert(pfroot); 
     }
    }
   }  
   ++pfi;
  }
  ++yi;
 }
 vector<string> retlibs; 
 yi=thelibs.begin(); 
 while(yi!=thelibs.end()) retlibs.insert(retlibs.end(),*yi++);
 return retlibs; 
}
vector<string> getdirs(string dir)
{
 DIR *dp = opendir(dir.c_str());
 vector<string> files;
 struct dirent *dirp;
 while ((dirp = readdir(dp)) != NULL) files.push_back(string(dirp->d_name));
 closedir(dp);
 return files;
}
void build(string s,ofstream& make_file_s) //Used to construct MAKE.BAT, the build script
{
 s=get_module_name(s,(".hloe"),1,1).
 substr(0,get_module_name(s,(".hloe"),1,1).length()-string(".hloe").length());
 emit_inclusion(("build"),(".inc"),get_header_value("proc is"),s,make_file_s);
}
void link(string s,ofstream& make_file_s) //Called by "for_each" iterating through an STL vector 
{ 
 make_file_s<<" "<<s.c_str()<<".o ";
}
void guard(string s) //Used to construct MAKE.BAT, the build script
{
 if(s.length()) 
 emit_inclusion(("defguard"),(".inc"),s,s,inc_file_s);
}
struct postprocessordata
{
 string buffer;
 ostream * file;
};
bool nopush(postprocessordata &p)
{
 if(p.buffer.find("PUSH")>0 && p.buffer.find("PUSH")<p.buffer.length())
 {
  (*(p.file))<<p.buffer.substr(0,p.buffer.find("PUSH"));
  p.buffer=p.buffer.substr(p.buffer.find("PUSH"));
  return 0; //Don't stop parsing... hand off to "foundpush"
 } 
 (*(p.file))<<p.buffer[0]; //Echo char
 p.buffer.erase(0,1);
 if(p.buffer.length())return 0; //Don't stop parsing
 else return 1;
}
bool foundpush(postprocessordata &p)
{
 p.buffer=p.buffer.substr(4);//length of PUSH...
 string totest=p.buffer;
 whitespace(totest); //plus all trail. whitesp.
 if(totest.find("POP")!=0)
 {
  (*(p.file))<<"PUSH"; //Not a push-pop pair, must emit PUSH
 }
 else 
 { 
  p.buffer=p.buffer.substr(p.buffer.find("POP")+3);//length of POP 
 }
 if(p.buffer.length())return 0; //Don't stop parsing
 else return 1;
}
void pushpopoptimize()
{
 string incode=read_file("target.asm");
 postprocessordata ppo;
 map<string, bool (*)(postprocessordata &p) > language;
 language[""]=nopush; 
 language["PUSH "]=foundpush; 
 language["PUSH\t"]=foundpush; 
 language["PUSH\n"]=foundpush; 
 ofstream outcode("target.asm");
 ppo.file=&outcode;
 ppo.buffer=incode;
 lillex(ppo.buffer,ppo,language); 
 outcode.close();
}
bool nofar(postprocessordata &p)
{
 if(p.buffer.find("FAR_CALL")>0 && p.buffer.find("FAR_CALL")<p.buffer.length())
 {
  (*(p.file))<<p.buffer.substr(0,p.buffer.find("FAR_CALL"));
  p.buffer=p.buffer.substr(p.buffer.find("FAR_CALL"));
  return 0; //Don't stop parsing... hand off to foundfar
 } 
 (*(p.file))<<p.buffer;
 return 1;
}
bool foundfar(postprocessordata &p)
{
 p.buffer=p.buffer.substr(8);//length of FAR_CALL...
 whitespace(p.buffer);
 string callfrom=p.buffer.substr(0,p.buffer.find(","));
 p.buffer=p.buffer.substr(p.buffer.find(",")+1);
 whitespace(p.buffer);
 string callto=p.buffer.substr(0,p.buffer.find("\n"));
 p.buffer=p.buffer.substr(p.buffer.find("\n")+1);
 string totest=p.buffer;
 whitespace(totest);
 if(totest.find("FAR_CALL")==0) 
 //It's another far_call... no need to re-select original code page
 (*(p.file))<<endl<<" HALF_FAR_CALL "<<callto<<endl; 
 else
 (*(p.file))<<endl<<" FAR_CALL "<<callfrom<<","<<callto<<endl;
 if(p.buffer.length())return 0; //Don't stop parsing
 else return 1;
}
void farcalloptimize()
{
 string incode=read_file("target.asm");
 postprocessordata ppo;
 map<string, bool (*)(postprocessordata &p) > language;
 language[""]=nofar; 
 language["FAR_CALL "]=foundfar; 
 language["FAR_CALL\t"]=foundfar; 
 language["FAR_CALL\n"]=foundfar; 
 ofstream outcode("target.asm");
 ppo.file=&outcode;
 ppo.buffer=incode;
 lillex(ppo.buffer,ppo,language); 
 outcode.close();
}
bool nocall(postprocessordata &p)
{ 
 if(p.buffer.find(HLL_STRANGE_STRING)>0 && p.buffer.find(HLL_STRANGE_STRING)<p.buffer.length())
 {
  (*(p.file))<<p.buffer.substr(0,p.buffer.find(HLL_STRANGE_STRING));
  p.buffer.erase(0,p.buffer.find(HLL_STRANGE_STRING));
  return 0; //Don't stop parsing... hand off to "foundpush"
 } 
 /*
Naive, original implementation... costs ~10sec!
(*(p.file))<<p.buffer[0]; //Echo char
p.buffer.erase(0,1);
if(p.buffer.length())return 0; //Don't stop parsing
else return 1;*/
 (*(p.file))<<p.buffer;
 return 1;
}
bool foundcall(postprocessordata &p)
{ 
 p.buffer.erase(0,string(HLL_STRANGE_STRING).length()); //length of HLL_STRANGE_STRING
 //Function is static; it is based on lookahead, not reentry 
 //static string remainder; remainder=p.buffer;
 string remainder=p.buffer; 
 string labelize;
 //Magic string-ism... need to refactor away
 bool star=
 remainder.find("KDISCARD")==0;
 //Var "remainder" is everything from potential tail-recursive call to
 // the single exit point of the function. 
 remainder=remainder.substr(0,remainder.find("return"));
 bool tr=1; 
 //static 
 string afunct; //The function being called
 while(remainder.length()&&tr)
 {
  if(isspace(remainder[0]))
  {
   remainder.erase(0,1);
  }
  else if(remainder.find("FAR_CALL ")==0 ||
    remainder.find("FAR_CALL\t")==0)
  {
   remainder=remainder.substr(9); //9 is string("FAR_CALL").length()+1
   whitespace(remainder); 
   afunct=remainder.substr(0,remainder.find(","));
   afunct=afunct.substr(0,remainder.find(" "));
   afunct=afunct.substr(0,remainder.find("\t"));
   string calledto=remainder.substr(remainder.find(",")+1);
   calledto=calledto.substr(0,calledto.find(" "));
   calledto=calledto.substr(0,calledto.find("\t"));
   calledto=calledto.substr(0,calledto.find("\n"));
   calledto=calledto.substr(0,calledto.find("\r")); //UNIX made me do this 
   tr&=!((calledto).compare(afunct));
   remainder.erase(0,remainder.find("\n")+1);
  }
  else if(
    remainder.find("KDISCARD")==0
    ||remainder.find(";")==0
    //GOTO is OK; any GOTOs in the "remainder" will be forward references to a
    // label residing between the tail recursive call and the single exit point
    // of the function. This is true b/c "if" is the only frost idiom that 
    // causes GOTOs to be emitted. A goto and some labels, by themselves, 
    // are the object code equivalent of empty "else" clauses; Because each 
    // object code "user" function has a single exit point, GOTOs by themselves 
    // do not indicate any subsequent real processing that necessitates a real
    // "call"... standalone GOTOs will be within the "user" function, and if this
    // function is otherwise devoid of subsequent processing, the GOTO is not a
    // problem.
    ||remainder.find("goto ")==0 ||remainder.find("goto\t")==0 
    )
  {
   //In each of the above cases, skip the remainder of the line.
   remainder.erase(0,remainder.find("\n")+1);
  }
  else if(remainder.find("hlllb51")==0)
  {
   (*(p.file))<<endl;
   //Labels are OK, but must emit them. Labels in the "remainder" represent
   // potential calls to a point just below a tail-recursive call. So, we put 
   // these before a new terminal call to KDISCARD, if any, and a new return.
   //   while(remainder[0]!='\n'){ labelize+=remainder[0]; remainder.erase(0,1);}
   //labelize.append("\n"); 
   labelize.append(remainder.substr(0,remainder.find("\n")+1));  
   remainder.erase(0,remainder.find("\n")+1);
  }  
  else{ tr=0;}//By default, anything unexpected (post-call actions) turn off tr
 }
 if(tr)
 {
  //Consume rest of function as found
  p.buffer.erase(0,p.buffer.find("return")+string("return").length());
  if(star) (*(p.file))<<"\n KDISCARD \n goto "<<afunct<<endl;
  else (*(p.file))<<"\n goto "<<afunct<<endl;
  if(labelize.length())
  {
   (*(p.file))<<labelize;  
   if(star) (*(p.file))<<"\n KDISCARD \n return \n";
   else (*(p.file))<<"\n return \n";
  }
  
 }
 if(p.buffer.length())return 0; //Don't stop parsing
 else return 1;  
}
void tailrecursion()
{
 string incode=read_file("target.asm");
 postprocessordata ppo;
 map<string, bool (*)(postprocessordata &p) > language;
 language[""]=nocall; 
 language[HLL_STRANGE_STRING]=foundcall; 
 ostringstream outcode;
 ppo.file=&outcode;
 ppo.buffer=incode;
 lillex(ppo.buffer,ppo,language); 
 ofstream outcodf("target.asm");
 outcodf<<outcode.str().c_str();
 outcodf.close();
}
void make_real(double f, unsigned char& mant_byte,unsigned char& exp_byte)
{
 int exp,exp_min,mant_min,try_exp=128,char_ind=6;
 if(fabs(f)<=powf((double)2.0,(double)-128.0))
 { 
  mant_byte=0; //ZERO (SMALLER THAN EPSILON)
  exp_byte=0x80;
  return;
 } 
 (mant_byte)=0;
 if(f < 0.0)
 {
  f=-f; 
  mant_min=1;
 }else
 {
  mant_min=0;
 }
 do
 {
  if(f>=pow((double)2,(double)try_exp))
  {
   //Hidden bit assumed 
   f-=pow((double)2,(double)try_exp);
   exp=try_exp;
   --try_exp;
   break;
  }
  --try_exp;
 }while(1);
 
 do
 {
  if(f>=pow((double)2,(double)try_exp))
  {
   (mant_byte)|=(int)(pow((double)2,char_ind--));
   f-=pow((double)2,(double)try_exp);
  }
  else 
  {
   (mant_byte)&=(int)(255-pow((double)2,char_ind--));
  }
  --try_exp;
  if(char_ind<0)break;
 }while(1);
 if(f>=pow((double)2,(double)try_exp)) //Rounding
 {
  (mant_byte)+=1;
  if(mant_byte==128)
  {
   (mant_byte)=0;
   ++exp;
  }
 } 
 if(mant_min) (mant_byte)|=128;  //Just set top bit... that's it   
 exp_byte=exp&255;
}
void canonicalspacing()
{
 string incode=read_file("target.asm");
 string was;
 do
 {
  was=incode;
  JBWStringReplace(incode,"\r","\n"); //TODO rename
  JBWStringReplace(incode,"\t"," ");
  JBWStringReplace(incode,"  "," ");
  JBWStringReplace(incode," \n","\n");
  JBWStringReplace(incode,"\n\n","\n");
  JBWStringReplace(incode," ,",",");
  JBWStringReplace(incode,", ",",");
 }while( was!=incode);
 ofstream outcode("target.asm"); //TODO these file names should not be here, should be in main()
 outcode<<incode;
 outcode.close();
}
bool istable(const string& proposedtable,const string& fulltext)
{ 
 string text=fulltext;
 char lastch='0'; //Table wouldn't be located at start anyway
 do{
  if(text[0]=='t'&&(isspace(lastch)|| ';'==lastch))
  {     
   string cbuffer=text.substr(1);
   while(isspace(cbuffer[0]))cbuffer=cbuffer.substr(1);
   string possible1=proposedtable+"\n";
   string possible2=proposedtable+"\t";
   string possible3=proposedtable+"\r";
   string possible4=proposedtable+" ";
   if
    (
     cbuffer[0]=='.' 
     && 
     (
      cbuffer.find(possible1)==1 ||
      cbuffer.find(possible2)==1 ||
      cbuffer.find(possible3)==1 ||
      cbuffer.find(possible4)==1
     ) 
    ) return 1;        
  } 
  lastch=text[0]; 
  text=text.substr(1);
 }while(text[0]);
 return 0;
}
bool nodigit(postprocessordata &p)
{
 //This is potentially a slow implementation... it is good that it operates on 
 // FROST and not ASM
 (*(p.file))<<p.buffer[0]; //Echo char
 p.buffer.erase(0,1);
 if(p.buffer.length())return 0; //Don't stop parsing
 else return 1;
}
bool founddigit(postprocessordata &p)
{
 //string acopy=p.buffer;
 while(isdigit(p.buffer[0]))//Echo integer portion
 {
  (*(p.file))<<p.buffer[0]; 
  p.buffer.erase(0,1);
 }
 if(p.buffer[0]=='.') //Maybe continue to decimal portion
 {
  if(isdigit(p.buffer[1])) 
  {
   (*(p.file))<<p.buffer[0];
   p.buffer.erase(0,1);
   while(isdigit(p.buffer[0])) 
   {
    (*(p.file))<<p.buffer[0];
    p.buffer.erase(0,1);
   }
  }
  else
  {
   //A digit followed by a dot followed by something other than a digit... the
   // dot is part of a function call, and this needs to be made unambiguous by
   // adding a space in front of the dot.
   (*(p.file))<<" ";
   (*(p.file))<<p.buffer[0]; 
   p.buffer.erase(0,1);
  }
 }
 if(p.buffer.length())return 0; //Don't stop parsing
 else return 1;
}
void canonizeintegers(string &usercode)
{
 map<string, bool (*)(postprocessordata &p) > language;
 language["0"]=founddigit; language["1"]=founddigit; language["2"]=founddigit; 
 language["3"]=founddigit; language["4"]=founddigit; language["5"]=founddigit; 
 language["6"]=founddigit; language["7"]=founddigit; language["8"]=founddigit; 
 language["9"]=founddigit; language[""]=nodigit;     
 ostringstream outcode;
 postprocessordata ppo;
 ppo.file=&outcode;
 ppo.buffer=usercode;
 lillex(ppo.buffer,ppo,language); 
 usercode=outcode.str(); 
}
void canonizefrost(string &usercode)
{
 string was;
 do
 {
  was=usercode;
  JBWStringReplace(usercode,"\r","\n"); //TODO rename
  JBWStringReplace(usercode,"\t"," ");
  JBWStringReplace(usercode,"  "," ");
  JBWStringReplace(usercode," \n","\n");
  JBWStringReplace(usercode,"\n\n","\n");
  JBWStringReplace(usercode," ,",",");
  JBWStringReplace(usercode,", ",",");
 }while( was!=usercode); 
}
