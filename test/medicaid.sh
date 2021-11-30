#!/bin/bash
rundir=/opt/airflow/cwl-rundir/medicaid/run-`date +%Y-%m-%d-%H-%M`
docker exec  webserver bash -c "source /root/anaconda/etc/profile.d/conda.sh && conda activate nsaph && mkdir -p ${rundir} && cd ${rundir} && cwl-runner /opt/airflow/project/cms/src/cwl/medicaid.cwl --database /opt/airflow/project/database.ini --connection_name nsaph_test --input /data/incoming/medicaid/mini_random_data/ "

