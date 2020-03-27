# Copyright (c) 2020 R. Tohid
#
# Distributed under the Boost Software License, Version 1.0. (See a copy at
# http://www.boost.org/LICENSE_1_0.txt)

FROM fedora


ARG BUILD_PATH=/usr/local/build
ARG BUILD_TYPE=Debug
ARG PYTHON_VERSION=3.8
ARG CPUS=48
ARG MALLOC=system
ARG PREFIX=/home/stellar/bin
ARG REPO_PATH=/home/stellar/repos
ARG USER=stellar

RUN dnf -y update

RUN dnf install -y sudo

RUN dnf install -y xz xz-devel bzip2 bzip2-devel zlib-devel tar
RUN dnf install -y git
RUN dnf install -y blas blas-devel lapack lapack-devel
RUN dnf install -y boost-devel
RUN dnf install -y libatomic which compat-openssl10 vim-enhanced 


RUN dnf install -y findutils which
RUN dnf install -y bash-completion
RUN dnf install -y wget curl
RUN dnf install -y environment-modules 

RUN dnf install -y hwloc hwloc-devel
RUN dnf install -y compat-openssl10 compat-openssl10-devel
RUN dnf install -y make cmake automake autoconf libtool ccache

RUN dnf install -y gcc-c++ gcc-gfortran  redhat-rpm-config clang
RUN dnf install -y llvm llvm-devel compiler-rt clang-devel
RUN dnf install -y sqlite sqlite-devel

RUN dnf install -y gdb
RUN dnf install -y openmpi openmpi-devel
RUN dnf install -y flex patch graphviz pandoc cereal-devel lapack-devel

# install Python ${PYTHON_VERSION}
RUN git clone -b ${PYTHON_VERSION} https://github.com/python/cpython.git python-${PYTHON_VERSION}
WORKDIR /python-${PYTHON_VERSION}
RUN ./configure
RUN make -j ${CPUS} install

RUN python3 -m pip install -U pip
RUN python3 -m pip install pytest

# add user
RUN groupadd -r ${USER}
RUN useradd -r -m -g stellar -G wheel stellar
RUN echo '%wheel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers


RUN mkdir -p ${PREFIX}

# install HPX
WORKDIR ${REPO_PATH}
RUN git clone https://github.com/STEllAR-GROUP/hpx.git
WORKDIR ${BUILD_PATH}/hpx/
RUN cmake \
        -DCMAKE_BUILD_TYPE=${BUILD_TYPE}     \
        -DHPX_WITH_MALLOC=${MALLOC}          \
        -DHPX_WITH_MORE_THAN_64_THREADS=ON   \
        -DHPX_WITH_MAX_CPU_COUNT=80          \
        -DHPX_WITH_EXAMPLES=Off              \
        -DCMAKE_INSTALL_PREFIX=${PREFIX}/hpx \
        ${REPO_PATH}/hpx
RUN make -j ${CPUS} install

# install pybind11
WORKDIR ${REPO_PATH}
RUN git clone https://github.com/pybind/pybind11.git
WORKDIR ${BUILD_PATH}/pybind11
RUN cmake \
        -DCMAKE_BUILD_TYPE=${BUILD_TYPE} \
        ${REPO_PATH}/pybind11
RUN make -j ${CPUS} install

# install blaze
WORKDIR ${REPO_PATH}
RUN git clone https://bitbucket.org/blaze-lib/blaze.git
WORKDIR ${BUILD_PATH}/blaze
RUN cmake \
        -DCMAKE_BUILD_TYPE=${BUILD_TYPE} \
        ${REPO_PATH}/blaze
RUN make -j ${CPUS} install

# install blaze_tensor
WORKDIR ${REPO_PATH}
RUN git clone https://github.com/STEllAR-GROUP/blaze_tensor.git
WORKDIR ${BUILD_PATH}/blaze_tensor
RUN cmake \
        -DCMAKE_BUILD_TYPE=${BUILD_TYPE} \
        ${REPO_PATH}/blaze_tensor
RUN make -j ${CPUS} install

# get Phylanx source.
WORKDIR ${REPO_PATH}
RUN git clone https://github.com/STEllAR-GROUP/phylanx.git
WORKDIR ${BUILD_PATH}/phylanx

COPY Dockerfile /Dockerfile

# add build script, with a default Debug build.
COPY build.sh /usr/local/bin/build_phylanx.sh
RUN chmod +x /usr/local/bin/build_phylanx.sh


RUN chown -R stellar:stellar /home/stellar

USER ${USER}