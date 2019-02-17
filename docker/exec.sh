#!/bin/bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)

case "$1" in
  centos6|ubuntu1604)
    pushd ${SCRIPT_DIR}
    docker-compose run --rm $1 /bin/bash
    popd
    ;;
  *)
    echo "Usage: $0 [centos6|ubuntu1604]"
    ;;
esac
