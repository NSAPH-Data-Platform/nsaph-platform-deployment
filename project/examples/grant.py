#!/usr/bin/env python3
from cwl_airflow.extensions.cwldag import CWLDAG

args = {
    "cwl": {
        "debug": True
    },
    "job": {
        "database": "/opt/airflow/project/database.ini",
        "connection_name": "nsaph2"
    }
}

dag = CWLDAG(
    workflow="/opt/airflow/project/cms/src/cwl/grant_read_access.cwl",
    dag_id="Grant Access to Tables",
    default_args=args
)