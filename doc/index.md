# NSAPH Data Platform Deployment

[Documentation Home](https://nsaph-data-platform.github.io/nsaph-platform-docs/home.html)

```{toctree}
---
maxdepth: 2
hidden:
---
Introduction
Guide
Howto
Configuration
Testing
Glossary
UsefulCommands
```

```{contents}
---
local:
---
```

Deployment of NSAPH Data Platform is based on  
CWL-Airflow Docker Deployment developed
by Harvard FAS RC in collaboration with Forome Association.

Essentially, this is a fork of: 
[Apache Airflow + CWL in Docker with Optional Conda and R](https://github.com/ForomePlatform/airflow-cwl-docker)
                                                            
It follows 
[Infrastructure as Code (IaC)](https://en.wikipedia.org/wiki/Infrastructure_as_code) 
approach.

## Prerequisites 

>**NB**: The docker-compose.yaml in this project uses profiles and therefore
> requires **docker-compose utility version 1.29+**
                    
## Installation

[Deployment Guide](Guide) provides detailed information about
deployment options and custom configurations.

[Howto](Howto.md) provides a list of required and optional steps
that should be performed during the deployment.  

Installation of CWL-Airflow on a dedicated host is relatively simple and 
is by and large covered by the {ref}`dep_quick_start` section below.

Advanced options are described in the 
[Configuration Guide](Configuration.md)

> If the host where you are installing CWL-Airflow is shared with other 
> applications, especially those, using PostgreSQL, you should carefully read 
> [Howto](Howto.md) and [Configuration Guide](Configuration.md)
 
After you have deployed CWL-Airflow, 
[test it](Testing.md) 
with the included examples.
                         
You should be aware of some [useful commands](UsefulCommands).

(dep_quick_start)=
## Quick Start 
 
This quick start is specific to NSAPH project. For testing general 
platform capabilities please refer to original 
[CWL-Airflow deployment README](https://github.com/ForomePlatform/airflow-cwl-docker#quick-start)

Full sequence of commands to copy and paste for  a clean VM:

    git clone https://github.com/NSAPH-Data-Platform/nsaph-platform-deployment.git
    cd nsaph-platform-deployment
    git submodule update --init --recursive
    export log=build-`date +%Y-%m-%d-%H-%M`.log && date > $log && cat .env >> $log && DOCKER_BUILDKIT=1 BUILDKIT_PROGRESS=plain docker-compose --env-file ./.env  build --no-cache 2>&1 | tee -a $log && date >> $log
    mkdir -p ./dags && cp -rf ./project/examples/* ./dags
    docker-compose --env-file ./.env up -d
    
                                                  
The whole process, when using a stable Internet
connection should take from 20 minutes to a few hours depending on your 
Internet speed.
                 
You can test the installation as described in 
[Testing the installation](Testing.md) section. The first two 
examples should run in both command-line mode and in Airflow UI. 
The third example requires Conda.


## Testing 

Testing is described in the [Test Guide](Testing.md).

## Indices {#dep-indices}

* [](genindex)
* [](modindex)
