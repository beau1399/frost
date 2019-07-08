//Note that the members are allocated here... a single instance of this struct is
// therefore allocated by the program and a reference thereto is passed around at
// runtime.

struct compilerstate
{

 //Uncompiled portion of frost source
 string buffer; //TODO this really doesn't belong here any more
 
 //Are we in ISR? (versus main task or frost "d" functions)
 bool in_isr;
 
 //Perform stack bounds checking?
 bool checks;
 
 //Carefully space TARGET.ASM?
 bool canonize;
 
 //List of HLOE (versus "d" frost) functions called by frost program
 set<string> funcs;
 
 //Entire frost source
 string text;
 
 //List of all functions (HLOE and "d") called from main task
 set<string> maincalls;
 
 //List of all functions (HLOE and "d") called from ISR
 set<string> eventcalls; 
 
 //Maps HLOE calls to their thunkspace (if any)
 map<string,string> thunks;
 
 //Maps "d" function calls to HLOE call lists
 map<string,vector<string> > ds_to_calls;
 
 //List of frost variables (declared using "var")
 set<string> statics;

 string memzone; //A label that is in our own code page

 string in_function; //Name of function being evaluated, if any

 bool star; //Does function being evaluated manage its own stack space?

 int nofrets; //Number of return bytes for function being evaluated

 int nofparms; //Number of parameter bytes for function being evaluated
 
 
 int labels; //Running counter for generation of label names

// int baselb; //Base label number for current conditional structure
 
 bool multitask; //Is there concurrency in the frost program
 
// stack<int> baselabel; //To support nested conditions

 };
