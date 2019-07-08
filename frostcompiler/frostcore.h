#include <string>
#include <iostream>


extern void whitespace(std::string &buffer);

extern void inc_buffer(std::string &buffer);

extern void app_error(const char* message, const char offender);

extern std::string get_header_value(std::string key,std::string &buffer);

extern std::string get_header_value(std::string key);

extern void set_header_value(std::string key,std::string value);

extern std::string read_file(const std::string &parm);

extern void emit_inclusion(const std::string &name,const std::string &extension,const std::string &p1,
 const std::string &p2,std::ostream& outstr);

extern void emit_inclusion(const std::string &name,const std::string &extension,const int p1,const int p2,
 std::ostream& outstr);

extern void insert_file(const std::string &parm,std::ofstream& target_s);

extern std::string get_module_name(const std::string &sparm,const std::string &extend,const bool shortonly,const bool searchsystem);

extern void JBWStringReplace(std::string &buffer,std::string to_repl,std::string new_text);