#include "command.h"

int sub_command_version(int argc, const char **argv) {
  printf("bekobrew version %s\n", BEKOBREW_VERSION);
}
