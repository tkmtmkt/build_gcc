#!/bin/bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)

TARGET=gcc-8.3.0

case "$1" in
  centos6|ubuntu1604)
    pushd ${SCRIPT_DIR}
    docker-compose run --rm $1 /opt/${TARGET}/workspace/scripts/build-all.sh
    RESULT=$?
    popd
    exit ${RESULT}
    ;;
  *)
    echo "Usage: $0 [centos6|ubuntu1604]"
    ;;
esac
