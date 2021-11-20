#!/bin/bash
docker exec  webserver bash -c "source /root/anaconda/etc/profile.d/conda.sh && conda activate nsaph && cd /root/tmp && cwl-runner /opt/airflow/project/cms/src/cwl/medicaid.cwl --database /opt/airflow/project/database.ini --connection_name nsaph2 --input /data/incoming/medicaid/random_data/ "
