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
is by and large covered by the [](#quick-start-deployment) section below.

Advanced options are described in the 
[Configuration Guide](Configuration.md)

> If the host where you are installing CWL-Airflow is shared with other 
> applications, especially those, using PostgreSQL, you should carefully read 
> [Howto](Howto.md) and [Configuration Guide](Configuration.md)
 
After you have deployed CWL-Airflow, 
[test it](Testing.md) 
with the included examples.
                         
You should be aware of some [useful commands](UsefulCommands).

## Quick Start Deployment
 
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

Basic testing is described in the [Test Guide](Testing.md). The
guide describes how to test both command line commands and Airflow UI.

            
## Updating project packages
                                                                 
### What are project packages?

The code that performs actual data processing lives in `project`
subdirectory. From there it is installed in all Docker containers
that are used by the platform. In this documentation we also refer 
to it as 'user code', meaning that it is not part of infrastructure
but code developed by researchers and engineers for their specific 
projects. 

Obviously, from time to time the runtime environment requires to be 
updated with the latest version of this user code. In this section we describe
how it can be done by system administrator.

There are three options to update user code in the runtime environment:

* Rebuild all docker containers
* Install updates inside docker containers
* Map packages from container to the host

### Option 1: Rebuild all docker containers

This is the most straightforward and proper option. It follows the 
best practices guidelines but have a few caveats. 

Executing this option is equivalent to following the instructions
in [Quick Start](#quick-start-deployment). There is also a helper script
[hardreset.sh](members/rebuild.md)

There are, however, a few caveats associated with this option:

1. The process might take several hours, depending on the Internet speed
    and hardware.
2. If build fails for some reason (e.g. some third-party packages have been
    updated and some dependencies are broken), it will take time and effort
    even to get back to the working version

### Option 2: Install updates inside docker containers

This is quick and easy option which is also relatively safe. It can
be performed by running [refresh.sh](members/refresh.md) script or
by executing similar commands.

The main downside of this option is that changes affect containers only
while they are running. If any of the containers are restarted, all changes
will be lost. However, this is not as awful as it sounds, just:

> Do not forget to rerun [refresh.sh](members/refresh.md) script every 
> time you restart the containers!
 
### Option 3: Map packages from host

We can map packages on the host machine to the library path in the containers.
File 
[docker-compose.mapped-packages.yaml](members/docker-compose-mapped-packages.yaml.md)
illustrates how to do it. Look at lines 64-70.

If this option is used, just refreshing packages on the host
(e.g. by executing `git pull`) will automatically update packages
inside the container.

However, keep in mind that you are bypassing normal installation with 
unpredictable consequences.

