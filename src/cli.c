#include "cli.h"

static int parse_options(int *argc, const char ***argv) {
  const char **prev_argv = *argv;
  while (*argc > 0) {
    const char *option = **argv;

    if (!start_with(option, '-')) {
      break;
    }

    if (!strcmp(option, "--version")) {
      break;
    }

    (*argv)++;
    (*argc)--;
  }
  return (*argv) - prev_argv;
}

static void help(int argc, const char **argv) {
  const char *cmd_name = "help";
  struct command *cmd = command_find(cmd_name);
  cmd->call(argc, argv);
}

int cli_run(int argc, char **_argv) {
  const char **argv = (const char **)_argv;

  argv++;
  argc--;
  parse_options(&argc, &argv);

  if (argc > 0) {
    skip_prefix(argv[0], "--", &argv[0]);
  }

  const char *cmd_name;
  if (argc > 0) {
    cmd_name = argv[0];
  } else {
    cmd_name = "help";
  }

  struct command *cmd = command_find(cmd_name);
  if (cmd) {
    cmd->call(argc, argv);
  } else {
    help(argc, argv);
  }

  return 0;
}
