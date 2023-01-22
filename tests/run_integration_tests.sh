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

HOST_2_LOOPBACK_IP=10.100.220.3
docker compose -f ./tests/docker-compose.yml exec -T host1 \
  ping -c 5 $HOST_2_LOOPBACK_IP

TEST_RESULT=$?
if [ $TEST_RESULT -eq 0 ]; then
  printf "\e[32m%s\e[m\n" "統合テストが成功しました。"
else
  printf "\e[31m%s\e[m\n" "統合テストが失敗しました。"
fi

exit $TEST_RESULT
