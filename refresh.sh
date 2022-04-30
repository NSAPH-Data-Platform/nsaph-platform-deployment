#!/bin/bash

git pull
# git submodule update --recursive
cd project/ || exit
for d in nsaph_utils data_platform epa cms census gridmet ; do
  pushd $d && git status && git checkout develop && git pull && docker exec  webserver bash -c "source /root/anaconda/etc/profile.d/conda.sh && conda activate nsaph && pip install /opt/airflow/project/$d" && popd || exit ;
done
cd ..

