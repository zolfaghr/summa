#include <vector>
#include <iostream>
#include "cpp_class.h"

int main()
{
  SimpleF x;

  std::vector<int> testvector{2,5};
  x.SetB(testvector);
  std::cout << x.QueryB()[0] << ' ' << x.QueryB()[1] << std::endl;

  return 0;
}
