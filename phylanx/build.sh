#!/bin/bash

PROCS=24
PREFIX=$HOME/bin
BUILD_TYPE=Debug
MALLOC=system

mkdir ~/repos/phylanx/build
cd ~/repos/phylanx/build
cmake \
    -Dblaze_DIR=$PREFIX=/blaze/share/blaze/cmake/          			        \
    -DBlazeTensor_DIR=${PREFIX}/blaze_tensor/share/blaze/cmake/          	\
    -DPHYLANX_WITH_BLAZE_TENSOR=ON                                          \
    -Dpybind11_DIR=$PREFIX/pybind11/share/cmake/pybind11/ 			        \
    -DCMAKE_BUILD_TYPE=$BUILD_TYPE                                          \
    -DCMAKE_INSTALL_PREFIX=$PREFIX						                    \
    -DHPX_WITH_MALLOC=$MALLOC                                               \
    -DHPX_DIR=$PREFIX/hpx                                                   \
    -DPHYLANX_WITH_VIM_YCM=ON                                               \
    -Wdev                                                                   \
    ..

cd ~/repos/phylanx/build
make -j $USE_PROCS $* 2>&1 | tee make.out