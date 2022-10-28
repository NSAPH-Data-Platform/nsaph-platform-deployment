#!/usr/bin/env python3
from cwl_airflow.extensions.cwldag import CWLDAG

args = {
    "cwl": {
        "debug": True
    },
}

dag = CWLDAG(
    workflow="/opt/airflow/project/cms/src/cwl/grant.cwl",
    dag_id="Grant_Access_to_Tables",
    default_args=args
)