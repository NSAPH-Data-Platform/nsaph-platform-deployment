#!/bin/bash
docker-compose down &&  docker system prune -a && export log=build-`date +%Y-%m-%d-%H-%M`.log && date > $log && cat .env >> $log && DOCKER_BUILDKIT=1 BUILDKIT_PROGRESS=plain docker-compose --env-file ./.env  build --no-cache 2>&1 | tee -a $log && date >> $log
