#!/bin/bash

REPOSITORY_ROOT=$(cd $(dirname $0); dirname $(pwd))
cd $REPOSITORY_ROOT

FLAG_BUILD=false

while getopts abc OPT
do
  case $OPT in
     a)
       FLAG_BUILD=true
       ;;
  esac
done

if [ "$FLAG_BUILD" = "true" ]; then
  docker compose -f ./tests/docker-compose.yml build --no-cache
fi

docker compose -f ./tests/docker-compose.yml up -d
docker compose -f ./tests/docker-compose.yml exec -T host2 \
  cargo test -- --test-threads=1 --nocapture
