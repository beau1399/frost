
extern void compile_time_language(string &usercode,set<string> &funcs,
 map<string,string> &macromap, vector<string> &macroorder, set<string> &statics);

extern void expand_macros(string &macrobuf, const map<string,string> &macromap, 
      const vector<string> &macroorder, const bool hloe);

extern void remove_comments(string &usercode,const string &tkn);

extern bool is_definition(string fcode);
 
extern char makempasmid(char psl0);

extern char makefunctionname(char psl0);

extern void list_bottom_level_calls(compilerstate &c);

extern void list_bottom_level_calls(compilerstate &c);

extern void list_function_thunks(compilerstate &c, map<string,vector<string> > &ds_to_thunks );

extern void list_task_thunks(compilerstate &c, const map<string,vector<string> >& ds_to_thunks );

extern vector<string> find_libs(const set<string> funcs,const bool checks); 

extern void compile_hloe(const vector<string> libs,map<string,string> &thunks);

extern void build(string s,ofstream& make_file_s); //Used to construct MAKE.BASH, the build script

extern void link(string s,ofstream& make_file_s); //Called by "for_each" iterating through an STL vector 

extern void guard(string s);

extern void pushpopoptimize();

extern void farcalloptimize();

extern void make_real(double f, unsigned char& mant_byte,unsigned char& exp_byte);

extern void tailrecursion();

extern void canonicalspacing();

extern bool istable(const string& proposedtable,const string& text);

extern void canonizeintegers(string &usercode);

extern void canonizefrost(string &usercode);

