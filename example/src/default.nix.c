let
    greeting = builtins.getEnv "GREETING";
in
assert greeting != "";

''
#include "helper.h"

int main() {
  greet("${builtins.getEnv "GREETING"}\n");
  return 0;
}
''
