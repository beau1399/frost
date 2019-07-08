#include <iostream>
#include <cstdlib>

int main()
{
  std::cout<<std::endl<<"hi!";
  std::cout<<std::endl<<getenv("PATH");
  std::cout<<std::endl<<getenv("FROST")<<std::endl<<std::endl;
}
