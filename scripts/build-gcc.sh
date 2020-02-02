#!/bin/bash
# https://gcc.gnu.org/
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
source ${SCRIPT_DIR}/build-common.sh

VERSION=8.3.0
TARGET=gcc-${VERSION}

# download
ARCHIVE=${ARCHIVES_DIR}/${TARGET}.tar.xz
DOWNLOAD_URL=http://ftp.tsukuba.wide.ad.jp/software/gcc/releases/${TARGET}/${TARGET}.tar.xz
[[ ! -s ${ARCHIVE} ]] && curl -ksSL ${DOWNLOAD_URL} -o ${ARCHIVE}

pushd ${BUILD_DIR}

# expand
[[ -d ${TARGET} ]] && rm -rf ${TARGET}
tar xf ${ARCHIVE}
cd ${TARGET}

while read DEP
do
  ARCHIVE=${ARCHIVES_DIR}/${DEP}
  [[ ! -s ${ARCHIVE} ]] && curl -ksSL ftp://gcc.gnu.org/pub/gcc/infrastructure/${DEP} ${ARCHIVE}
  tar xf ${ARCHIVE}
  ln -s ${DEP%%.tar.*} ${DEP%%-*}
done <<'EOS'
gmp-6.1.0.tar.bz2
mpfr-3.1.4.tar.bz2
mpc-1.0.3.tar.gz
isl-0.18.tar.bz2
EOS

# build
mkdir build
cd build
../configure --prefix=${PREFIX} \
             --enable-languages=c,c++ \
             --disable-bootstrap \
             --disable-multilib &&
make && make install
RESULT=$?

popd

log ${TARGET}
exit ${RESULT}
