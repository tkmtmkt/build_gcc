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

for ITEM in $(awk '/^(gmp|mpfr|mpc|isl)=/{print}' contrib/download_prerequisites | sed 's/'\''//g')
do
  NAME=${ITEM%%=*}
  FILE=${ITEM##*=}
  ARCHIVE=${ARCHIVES_DIR}/${FILE}
  [[ ! -s ${ARCHIVE} ]] && curl -ksSL ftp://gcc.gnu.org/pub/gcc/infrastructure/${FILE} ${ARCHIVE}
  tar xf ${ARCHIVE}
  ln -s ${FILE%%.tar.*} ${NAME}
done

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
