#ifndef COMMAND_H
#define COMMAND_H

#include <stdio.h>
#include <string.h>

#include "inline_utils.h"
#include "version.h"

struct command {
  const char *cmd;
  int (*call)(int, const char **);
};

extern int sub_command_version(int argc, const char **argv);
extern int sub_command_help(int argc, const char **argv);
extern int sub_command_install(int argc, const char **argv);
extern struct command *command_find(const char *cmd_name);

#endif
