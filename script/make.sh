#!/bin/sh

is_command() {
  type $@ 1>/dev/null 2>/dev/null
}

if is_command gmake; then
  gmake $@
else
  make $@
fi
