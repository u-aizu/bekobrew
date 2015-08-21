#ifndef INLINE_UTILS_H
#define INLINE_UTILS_H

#define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))

static inline int start_with(const char *s, const char c) {
  return s[0] == c;
}

static inline int skip_prefix(const char *s, const char *prefix,
                              const char **out) {
  do {
    if(!*prefix) {
      *out = s;
      return 1;
    }
  } while(*s++ == *prefix++);

  return 0;
}

#endif
