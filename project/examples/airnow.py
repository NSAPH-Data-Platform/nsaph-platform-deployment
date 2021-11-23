#!/usr/bin/env python3
from cwl_airflow.extensions.cwldag import CWLDAG

args = {
    "cwl": {
        "debug": True,
        "parallel": True
    }
}

dag = CWLDAG(
    workflow="/opt/airflow/project/epa/src/cwl/airnow.cwl",
    dag_id="AirNow",
    default_args=args
)