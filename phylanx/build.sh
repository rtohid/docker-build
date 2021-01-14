#!/bin/bash

# Copyright (c) 2020 R. Tohid (@rtohid)
#
# Distributed under the Boost Software License, Version 1.0. (See a copy at
# http://www.boost.org/LICENSE_1_0.txt)

PROCS=$(nproc)
PREFIX=/usr/local/build
BUILD_TYPE=Debug
MALLOC=system

mkdir -p ~/repos/phylanx/build
cd ~/repos/phylanx/build
cmake \
    -Dblaze_DIR=$PREFIX/blaze/share/blaze/cmake/          			\
    -DBlazeTensor_DIR=${PREFIX}/blaze_tensor/share/blaze/cmake/ \
    -DPHYLANX_WITH_BLAZE_TENSOR=ON                              \
    -Dpybind11_DIR=$PREFIX/pybind11/share/cmake/pybind11/ 			\
    -DCMAKE_BUILD_TYPE=$BUILD_TYPE                              \
    -DCMAKE_INSTALL_PREFIX=$PREFIX						                  \
    -DHPX_WITH_MALLOC=$MALLOC                                   \
    -DHPX_DIR=$PREFIX/hpx                                       \
    -DPHYLANX_WITH_VIM_YCM=ON                                   \
    -Wdev                                                       \
    ..

cd ~/repos/phylanx/build
make -j $USE_PROCS $* 2>&1 | tee make.out