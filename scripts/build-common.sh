#!/bin/bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
BASE_DIR=$(cd ${SCRIPT_DIR}/..;pwd)

export LANG=C
export PREFIX=$(cd ${BASE_DIR}/..;pwd)
export PATH=${PREFIX}/bin:${PATH}
export PKG_CONFIG_PATH=${PREFIX}/lib/pkgconfig
export CCSHARED="-fPIC"
export CFLAGS="-I${PREFIX}/include"
export CPPFLAGS="-I${PREFIX}/include"
export LDFLAGS="-L${PREFIX}/lib -L${PREFIX}/lib64 -Wl,-rpath,${PREFIX}/lib -Wl,-rpath,${PREFIX}/lib64"
export LT_SYS_LIBRARY_PATH=${PREFIX}/lib
export LD_LIBRARY_PATH=${PREFIX}/lib
export MANPATH=${PREFIX}/man:

export ARCHIVES_DIR=${BASE_DIR}/archives
[[ ! -d ${ARCHIVES_DIR} ]] && mkdir -p ${ARCHIVES_DIR}

export BUILD_DIR=${BASE_DIR}/build
[[ ! -d ${BUILD_DIR} ]] && mkdir -p ${BUILD_DIR}

function log {
  [[ ! -d "${PREFIX}" ]] && mkdir ${PREFIX}
  echo "$(TZ='Asia/Tokyo' date -Iminutes) $1" >> ${PREFIX}/BUILDLOG
}
