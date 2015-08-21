#include "bekobuild.h"

static struct bekobuild_t *new_bekobuild() {
  return (struct bekobuild_t*) malloc(sizeof(struct bekobuild_t));
}

static struct list_t *new_list() {
  return (struct list_t*) malloc(sizeof(struct list_t));
}

static yaml_parser_t *new_parser() {
  return (yaml_parser_t*) malloc(sizeof(yaml_parser_t));
}

static void init_parser(yaml_parser_t *parser, FILE* file) {
  if (!yaml_parser_initialize(parser)) {
    fputs("ERROR: yaml_parser_initialize", stderr);
    exit(1);
  }
  yaml_parser_set_input_file(parser, file);
}

static const char *to_string(yaml_token_t *token) {
  return strdup((const char *)token->data.scalar.value);
}

static struct list_t *parse_seq(yaml_parser_t *parser) {
  yaml_token_t token;
  int done = 0;
  struct list_t *head = new_list();

  while (!done) {
    if (!yaml_parser_scan(parser, &token)) {
      return NULL;
    }

    switch (token.type) {
      case YAML_SCALAR_TOKEN:
        break;

      case YAML_BLOCK_END_TOKEN:
        done = 1;
        break;
    }
  }

  return head;
}

static int parse(yaml_parser_t *parser) {
  yaml_token_t token;
  int done = 0;
  int flag_key = 0;
  const char *item_key;
  const char *item_value;

  while (!done) {
    if (!yaml_parser_scan(parser, &token)) {
      return 0;
    }

    switch (token.type) {
      case YAML_KEY_TOKEN:
        flag_key = 1;
        break;

      case YAML_SCALAR_TOKEN:
        if (flag_key) {
          item_key = to_string(&token);
        } else {
          item_value = to_string(&token);
        }
        flag_key = 0;
        break;

      case YAML_BLOCK_SEQUENCE_START_TOKEN:
        parse_seq(parser);
        break;

      case YAML_STREAM_END_TOKEN:
        done = 1;
        break;
    }

    yaml_token_delete(&token);
  }

  return 1;
}

struct bekobuild_t *bekobuild_open(FILE* file) {
  struct bekobuild_t *self = new_bekobuild();
  self->parser = new_parser();
  init_parser(self->parser, file);
  if (!parse(self->parser)) {
    bekobuild_close(self);
    exit(1);
  }
  return self;
}

void bekobuild_close(struct bekobuild_t *self) {
  yaml_parser_delete(self->parser);
  free(self->parser);
  free(self);
}
