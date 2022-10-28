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
    workflow="/opt/airflow/project/cms/src/cwl/grant.cwl",
    dag_id="Grant_Access_to_Tables",
    default_args=args
)