#!/bin/bash

cwd=$(pwd)
if  [ "${cwd##*/}" != "cwl-airflow-deployment" ] ; then
  git clone -b nsaph-develop git@gitlab-int.rc.fas.harvard.edu:rse/francesca_dominici/cwl-airflow-deployment.git
  cd cwl-airflow-deployment/ || exit
fi
git submodule update --init --recursive
cd project/ || exit
pushd nsaph_utils && git status && git checkout dev && git status && popd || exit
for d in data_platform epa cms gridmet ; do pushd $d && git status && git checkout develop && git status && popd || exit ; done
cd ..

