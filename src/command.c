#include "command.h"

static struct command commands[] = {
  { "version", sub_command_version },
  { "help", sub_command_help },
  { "install", sub_command_install },
};

struct command *command_find(const char *cmd_name) {
  int i;
  for (i = 0; i < ARRAY_SIZE(commands); i++) {
    struct command *p = commands + i;
    if (!strcmp(cmd_name, p->cmd)) {
      return p;
    }
  }
  return NULL;
}
