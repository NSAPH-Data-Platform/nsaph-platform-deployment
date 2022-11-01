#!/usr/bin/env python3

"""
Execution of this DAG will grant `SELECT` privileges to all
tables and
NSAPH group users. By default it is executed in the production
database.

A different database can be selected by overriding
`connection_name` parameter in the JSON Job COnfiguration
"""

from cwl_airflow.extensions.cwldag import CWLDAG

args = {
    "cwl": {
        "debug": True
    },
}

dag = CWLDAG(
    workflow="/opt/airflow/project/cms/src/cwl/change_owner.cwl",
    dag_id="Change_Ownership_of_Tables",
    params = {
        "job": {
            "database": {
              	"class": "File",
          		"path": "/opt/airflow/project/database.ini"
            },
            "connection_name": "nsaph2"
        }
    },
    doc_md = __doc__,
    description="Grant Read access to teh database",
    default_args=args
)