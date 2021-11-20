#!/bin/bash
docker exec  webserver bash -c "source /root/anaconda/etc/profile.d/conda.sh && conda activate nsaph && cd /root/tmp && cwl-runner /opt/airflow/project/epa/src/cwl/aqs.cwl --database /opt/airflow/project/database.ini --connection_name nsaph2 --aggregation annual --parameter_code PM25 --table pm25_annual  "
