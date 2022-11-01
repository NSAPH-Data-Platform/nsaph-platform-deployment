#!/usr/bin/env python3

"""
Execution of this DAG will change the ownership of all
objects in the given database.

The database is defined by the
`connection_name` parameter in the JSON Job Configuration

Sample configuration:

```json
{
    "job": {
        "database": {
            "class": "File",
            "path": "/opt/airflow/project/sandbox.ini"
         },
        "connection_name": "sandbox"
    }
}
```

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
    doc_md = __doc__,
    description="Change ownership of the objects in the database",
    default_args=args
)