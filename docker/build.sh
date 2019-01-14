#!/bin/bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)

TARGET=gcc-4.9.4

case "$1" in
  centos6|ubuntu1404)
    pushd ${SCRIPT_DIR}
    docker-compose run --rm $1 /opt/${TARGET}/workspace/scripts/build-all.sh
    popd
    ;;
  *)
    echo "Usage: $0 [centos6|ubuntu1404]"
    ;;
esac
