#!/usr/bin/env python3

"""
This workflow will process all Medicare data
It is recommended to be invoked on a sandbox database
for testing purposes.

A different database can be selected by overriding
`connection_name` parameter in the JSON Job Configuration


Sample configuration:


        {
            "job": {
                "database": {
                    "class": "File",
                    "path": "/opt/airflow/project/sandbox.ini"
                 },
                "connection_name": "sandbox",
                "input": {
                    "class": "Directory",
                    "path": "/data/incoming/rce/ci3_d_medicare/original_data/cms_medicare/empty"
                }
            }
        }

To ingest data from a certain directory, specify it in the `input`
parameter instead of `empty`.

> Important: Only a locally mounted directory (not NFS!) can be
specified as the `input`

"""

from cwl_airflow.extensions.cwldag import CWLDAG

args = {
    "cwl": {
        "debug": False,
        "leave-tmpdir": True,
        "parallel": True
    },
}

dag = CWLDAG(
    workflow="/opt/airflow/project/cms/src/cwl/medicare.cwl",
    dag_id="Process_Medicare_Data",
    doc_md = __doc__,
    description="Process Medicare data",
    default_args=args
)