#!/bin/sh

SCRIPT_DIR=`pwd`/`dirname $0`

mkdir -p build && cd build
${SCRIPT_DIR}/make.sh install
