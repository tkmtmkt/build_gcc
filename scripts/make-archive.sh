#!/bin/bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
BASE_DIR=$(dirname ${SCRIPT_DIR})
BASE_NAME=$(basename ${BASE_DIR})
PARENT_DIR=$(dirname ${BASE_DIR})

tar czf ${BASE_NAME}-$(date +%Y%m%d).tar.gz -C ${PARENT_DIR} \
    --exclude=${BASE_NAME}/${BASE_NAME}-*.tar.gz \
    --exclude=${BASE_NAME}/build \
    --exclude=${BASE_NAME}/docker/*/{home,opt} \
    --exclude=${BASE_NAME}/log/*.log \
    ${BASE_NAME}
