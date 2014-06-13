#!/bin/bash

TMPDIR=`mktemp -d`
pushd $TMPDIR

wget -O archive.tar.gz https://github.com/u-aizu/bekobrew/archive/<%= ENV['BEKOBREW_VERSION'] %>.tar.gz
tar xvf ./archive.tar.gz

OPTDIR=bekobrew-<%= ENV['BEKOBREW_VERSION'] %>

mkdir -p ${HOME}/local/opt || true
cp -r ${OPTDIR}/ ${HOME}/local/opt/
echo 'export PATH=${HOME}/local/opt/'"${OPTDIR}"'/bin:${PATH}' >> ~/.bashrc

popd  # TMPDIR

rm -rf $TMPDIR

