#!/bin/bash

function usage_exit() {
  exit 1
}

function install_bekobrew() {
  local tmpdir=`mktemp -d`
  pushd $tmpdir

  wget -O archive.tar.gz https://github.com/u-aizu/bekobrew/archive/<%= ENV['BEKOBREW_VERSION'] %>.tar.gz
  tar xvf ./archive.tar.gz

  OPTDIR=bekobrew-<%= ENV['BEKOBREW_VERSION'] %>

  mkdir -p ${HOME}/local/opt || true
  cp -r ${OPTDIR}/ ${HOME}/local/opt/
  echo 'export PATH=${HOME}/local/opt/'"${OPTDIR}"'/bin:${PATH}' >> ~/.bashrc

  popd  # tmpdir

  rm -rf $tmpdir
}

function install_develop_bekobrew() {
  local tmpdir=`mktemp -d`
  pushd $tmpdir

  exit 0
  git clone --single-branch -b develop git://github.com/sh19910711/bekobrew.git
  cd bekobrew
  make bekobrew
  echo 'export PATH='"`pwd`"'/tmp:${PATH}' >> ~/.bashrc

  popd # tmpdir
}

GETOPT=`getopt -q -o h -l develop -- "$@"` ; [ $? != 0 ] && usage_exit
eval set -- "$GETOPT"

while true
do
  case $1 in
  --develop) FLAG_DEVELOP=yes ; shift
        ;;
  -h)   usage_exit
        ;;
  --)   shift ; break
        ;;
  *)    usage_exit
        ;;
  esac
done

if [[ ${FLAG_DEVELOP} ]]; then
  install_develop_bekobrew
else
  install_bekobrew
fi

