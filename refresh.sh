#!/bin/bash

git pull
# git submodule update --recursive
cd project/ || exit
for d in nsaph_utils data_platform epa cms census gridmet ; do
  pushd $d && git status && git pull && popd || exit ;
done
cd ..

