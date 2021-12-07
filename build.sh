#!/bin/bash

./hardreset.sh
mkdir -p ./dags && cp -rf ./project/examples/* ./dags
docker-compose --env-file ./.env up
