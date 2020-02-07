# Copyright (c) 2020 R. Tohid
#
# Distributed under the Boost Software License, Version 1.0. (See a copy at
# http://www.boost.org/LICENSE_1_0.txt)

FROM fedora:30

RUN dnf -y update

RUN dnf install -y sudo

RUN dnf install -y xz
RUN dnf install -y git
RUN dnf install -y tar
RUN dnf install -y bzip2
RUN dnf install -y findutils
RUN dnf install -y bash-completion
RUN dnf install -y wget curl
RUN dnf install -y environment-modules 

RUN dnf install -y openssl-devel
RUN dnf install -y make cmake automake autoconf libtool ccache

RUN dnf install -y gcc-c++ gcc-gfortran  redhat-rpm-config clang
RUN dnf install -y llvm compiler-rt clang-devel llvm-devel
RUN dnf install -y python2 python2-devel python2-pip

RUN dnf install -y gdb lcov

RUN dnf install -y flex patch graphviz pandoc cereal-devel lapack-devel

RUN groupadd -r stellar
RUN useradd -r -m -g stellar -G wheel stellar
RUN echo '%wheel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

WORKDIR /home/stellar/src

RUN git clone https://github.com/spack/spack.git
COPY ./packages.yaml /home/stellar/src/spack/etc/spack/defaults/linux/
COPY ./package.py /home/stellar/src/spack/var/spack/repos/builtin/packages/flecsi/package.py

RUN git clone --recursive https://github.com/stellar-group/flecsi.git
RUN git clone --recursive https://github.com/laristra/flecsale.git

WORKDIR /home/stellar/src/flecsale/flecsi
RUN git remote add stellar https://github.com/stellar-group/flecsi.git
RUN git fetch stellar
RUN git checkout -b hpx_backend_rebooted stellar/hpx_backend_rebooted
RUN git submodule update --recursive

WORKDIR /home/stellar/src/flecsi
RUN git fetch
RUN git checkout -b hpx_backend_rebooted origin/hpx_backend_rebooted
RUN git submodule update --recursive


RUN . /home/stellar/src/spack/share/spack/setup-env.sh && \
    spack env create flecsi-deps && \
    spack env activate flecsi-deps && \
    spack install --only dependencies flecsi backend=hpx +debug_backend %gcc@9.2.1 ^mpich@3.2.1 ^boost@1.70.0 && \
    spack install exodusii %gcc@9.2.1 ^mpich@3.2.1 && \
    spack install lua

WORKDIR /home/stellar/src/flecsi/build

RUN echo "source /home/stellar/src/spack/share/spack/setup-env.sh" >> /home/stellar/.bashrc
RUN echo "spack env activate flecsi-deps" >> /home/stellar/.bashrc

RUN chown -R stellar:stellar /home/stellar

USER stellar
