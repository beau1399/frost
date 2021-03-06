#include<string>
#include<vector>
#include<sstream>
#include<iostream>
#include<fstream>
#include<map>
#include<cstdlib> //For "exit"

///////////////////////////UTIL FUNCS FOR PARSING OF PRECOMPILE LANG/////////////////////

inline void inc_buffer(std::string &buffer) 
{
 if(!buffer.length()) return;
  buffer.erase(0,1);
}

void whitespace(std::string &buffer)
{
 while(isspace(buffer[0])) inc_buffer(buffer);
}

//C std::string here - robust/simple; good for post-error condition
void app_error(const char* message, const char offender)
{
 std::cout<<offender<<message; exit(1);
}

std::string get_header_value(std::string key,std::string &buffer)
{
 static std::map<std::string,std::string> the_header; 

 if(buffer.length())
  {
   whitespace(buffer);
   for(int ib=0;ib<key.length();++ib) inc_buffer(buffer);
   whitespace(buffer);
   std::string slot;
   while(isalpha(buffer[0])||isdigit(buffer[0]))
   {
    slot+=(buffer)[0];
    inc_buffer(buffer);
   }
   the_header[key]=slot; 
  }
 return the_header[key];
}

std::string get_header_value(std::string key)
{
 std::string s("");
 return get_header_value(key,s);
}

void set_header_value(std::string key,std::string value)
{
  std::string setstring(key);
  setstring+=" "; setstring+=value;  
  get_header_value(key,setstring);
}

std::string read_file(const std::string &parm)
{
 static std::string ret;
 ret="";
 std::ifstream filein(parm.c_str(),std::ios::in);
 if(filein.fail())app_error((("^ FILE NOT FOUND: ")+parm).c_str(),' ');
 while(!filein.eof()&&filein.peek()!=EOF) ret+=((char)filein.get());
 filein.close();
 return ret;
}

std::string get_module_name(const std::string &sparm,const std::string &extend,const bool shortonly,const bool searchsystem);

void emit_inclusion(const std::string &name,const std::string &extension,const std::string &p1,
 const std::string &p2,std::ostream& outstr)
{
 std::string invoke="\n"+read_file(get_module_name(name,extension,0,1));
 char * a_c_buffer=new char[invoke.length()+p1.length()+p2.length()*(8-1)+1]; 

 sprintf(a_c_buffer,invoke.c_str(), //Pass 8 parms, repeating the 2nd parm 7 times. 
 p1.c_str(),p2.c_str(),p2.c_str(),p2.c_str(),p2.c_str(),p2.c_str(),p2.c_str(),
 p2.c_str(),p2.c_str(),p2.c_str(),p2.c_str(),p2.c_str(),p2.c_str(),p2.c_str(),
 p2.c_str(),p2.c_str());
 outstr<<a_c_buffer;
 delete [] a_c_buffer;
}

void emit_inclusion(const std::string &name,const std::string &extension,const int p1,const int p2,
 std::ostream& outstr)
{
 std::ostringstream s1s,s2s; 
 s1s<<p1; s2s<<p2;
 emit_inclusion(name,extension,s1s.str(),s2s.str(),outstr);
}

void insert_file(const std::string &parm,std::ofstream& target_s) //Must end w/ newline if desired by maker of INC file!
{
 std::ifstream filein(parm.c_str(),std::ios::in);
 if(filein.fail())app_error((("^ FILE NOT FOUND: ")+parm).c_str(),' ');
 while(!filein.eof()&&filein.peek()!=EOF) target_s<<((char)filein.get());
 filein.close();
 return;
}

std::string get_module_name(const std::string &sparm,const std::string &extend,const bool shortonly,const bool searchsystem)
{
 std::string headfile;
 if(shortonly)
 {
   if(searchsystem)
   {
         std::string szdbg=(std::string(getenv("FROST"))+sparm+get_header_value("board is")+extend);
	 std::ifstream filein((std::string(getenv("FROST"))+sparm+get_header_value("board is")+extend).c_str(),std::ios::in);

	 if(get_header_value("board is").length()&&!(filein.fail()))
	 {   
	  headfile=((sparm+get_header_value("board is")+extend).c_str()			 );
	  filein.close();
	 }
	 else
	 {
	   szdbg=(std::string(getenv("FROST"))+(sparm+get_header_value("proc is")+extend));
	  std::ifstream filein2((std::string(getenv("FROST"))+(sparm+get_header_value("proc is")+extend)).c_str()			  		
	  ,std::ios::in);
	  if(!(filein2.fail()))
	  {
	   headfile=(sparm+get_header_value("proc is")+extend);
	   filein2.close();
	  }
	  else headfile=sparm+extend;
	 }
   }else{
	 std::ifstream filein((sparm+get_header_value("board is")+extend).c_str(),std::ios::in);

	 if(get_header_value("board is").length()&&!(filein.fail()))
	 {   
	  headfile=((sparm+get_header_value("board is")+extend).c_str());
	  filein.close();
	 }
	 else
	 {   
	  std::ifstream filein2(((sparm+get_header_value("proc is")+extend)).c_str()
	  ,std::ios::in);
	  if(!(filein2.fail()))
	  {
	   headfile=(sparm+get_header_value("proc is")+extend);
	   filein2.close();
	  }
	  else headfile=sparm+extend;
	 }
	}		 
 }else{ 
   if(searchsystem)
   {
	//Search system, return long
         std::string szdbg=(std::string(getenv("FROST"))+sparm+get_header_value("board is")+extend);
	 std::ifstream filein((std::string(getenv("FROST"))+sparm+get_header_value("board is")+extend).c_str(),std::ios::in);
	 if(get_header_value("board is").length()&&!(filein.fail()))
	 {   
	  headfile=((std::string(getenv("FROST"))+sparm+get_header_value("board is")+extend).c_str());
	  filein.close();
	 }
	 else
	 {
	   szdbg=(                std::string(getenv("FROST"))+(sparm+get_header_value("proc is")+extend));
	  std::ifstream filein2((std::string(getenv("FROST"))+(sparm+get_header_value("proc is")+extend)).c_str()
	   ,std::ios::in);
	  if(!(filein2.fail()))
	  {
	   headfile=(std::string(getenv("FROST"))+sparm+get_header_value("proc is")+extend);
	   filein2.close();
	  }
	  else headfile=std::string(getenv("FROST"))+sparm+extend;
	 }
  }else{
	 //Return long, don't search system 
	 std::ifstream filein((sparm+get_header_value("board is")+extend).c_str(),std::ios::in);

	 if(get_header_value("board is").length()&&!(filein.fail()))
	 {   
	  headfile=( (sparm+get_header_value("board is")+extend).c_str()  );
	  filein.close();
	 }
	 else
	 {   
	  std::ifstream filein2(((sparm+get_header_value("proc is")+extend)).c_str()  ,std::ios::in);
	  if(!(filein2.fail()))
	  {
	   headfile=(sparm+get_header_value("proc is")+extend);
	   filein2.close();
	  }
	  else headfile=sparm+extend;
	 }
	}
 }
 return headfile;
}

void JBWStringReplace(std::string &buffer,std::string to_repl,std::string new_text)
{
   std::string buffer2;
   bool hloe=true;
   //bool mfound=0;
   while( buffer.find((to_repl))>=0 &&
   buffer.find((to_repl))<buffer.length() ) //Look for the macro name
   { 
    //mfound=1;
    buffer2=buffer.substr(0,buffer.find((to_repl))); //Pre-macro text

    std::string macj;
    int macjcount=0;     
    macj=buffer.substr(buffer.find((to_repl))+(to_repl).length());	
    
     while(isspace(macj[0])||macj[0]=='\r'||macj[0]=='\n') 
   {macjcount+=macj.length();macj.erase(0,1);macjcount-=macj.length();
	  }
    std::vector<char> cparm;
    std::string mbody=new_text;
    std::string mbody2("");
    buffer2.append(mbody); //Append result of parameterization &c to pre-macro text 
    buffer2.append( //Append post-macro-text
     buffer.substr(buffer.find((to_repl))+(to_repl).length()+macjcount*(1-hloe))//TODO
	);
    buffer=buffer2; //Set overall result for next run of outer macro system loop
   }

}

