#!/bin/bash
# https://gcc.gnu.org/
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
source ${SCRIPT_DIR}/build-common.sh

VERSION=4.8.3
TARGET=gcc-${VERSION}

# download
ARCHIVE=${ARCHIVES_DIR}/${TARGET}.tar.bz2
DOWNLOAD_URL=https://bigsearcher.com/mirrors/gcc/releases/${TARGET}/${TARGET}.tar.bz2
[[ ! -s ${ARCHIVE} ]] && curl -ksSL ${DOWNLOAD_URL} -o ${ARCHIVE}

pushd ${BUILD_DIR}

# expand
[[ -d ${TARGET} ]] && rm -rf ${TARGET}
tar xf ${ARCHIVE}
cd ${TARGET}

# build
mkdir build
cd build
../configure --prefix=${PREFIX} \
             --enable-languages=c,c++ \
             --disable-bootstrap \
             --disable-multilib \
             --with-gmp=${PREFIX} \
             --with-mpfr=${PREFIX} \
             --with-mpc=${PREFIX} \
             --with-isl=${PREFIX} &&
make && make install
RESULT=$?

popd

log ${TARGET}
exit ${RESULT}
