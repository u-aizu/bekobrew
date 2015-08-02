#!/bin/sh

SCRIPT_DIR=`pwd`/`dirname $0`

mkdir -p build && cd build
cmake $@ .. && ${SCRIPT_DIR}/make.sh -j4
