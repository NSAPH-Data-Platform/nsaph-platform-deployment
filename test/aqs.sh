#!/bin/bash
rundir=/opt/airflow/cwl-rundir/aqs/run-`date +%Y-%m-%d-%H-%M`
docker exec  webserver bash -c "source /root/anaconda/etc/profile.d/conda.sh && conda activate nsaph && mkdir -p ${rundir} && cd ${rundir} && cwl-runner /opt/airflow/project/epa/src/cwl/aqs.cwl --database /opt/airflow/project/database.ini --connection_name nsaph_test --aggregation annual --parameter_code PM25 --table pm25_annual --proxy $HTTP_PROXY"
