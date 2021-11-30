#!/bin/bash -v
year=$1
rundir=/opt/airflow/cwl_rundir/medicaid/run-${year}-`date +%Y-%m-%d-%H-%M`
echo $year ==\> $rundir
docker exec  webserver bash -c "source /root/anaconda/etc/profile.d/conda.sh && conda activate nsaph && mkdir -p ${rundir} && cd ${rundir} && cwl-runner /opt/airflow/project/cms/src/cwl/medicaid.cwl --database /opt/airflow/project/database.ini --connection_name nsaph_cms --input /data/incoming/rce/ci3_d_medicaid/original_data/cms_medicaid-max/data/${year}/ "

