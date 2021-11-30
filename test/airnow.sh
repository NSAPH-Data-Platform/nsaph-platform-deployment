#!/bin/bash
rundir=/opt/airflow/cwl_rundir/airnow/run-`date +%Y-%m-%d-%H-%M`
docker exec  webserver bash -c "source /root/anaconda/etc/profile.d/conda.sh && conda activate nsaph && mkdir -p ${rundir} && cd ${rundir} && cwl-runner /opt/airflow/project/epa/src/cwl/airnow.cwl --database /opt/airflow/project/database.ini --connection_name nsaph_test --parameter_code PM25 --table pm25_airnow_test --proxy $HTTP_PROXY --api-key 9B053C38-3C42-416E-A330-203A698CCCDA --from 2020-12-25 --to 2021-01-05 "
