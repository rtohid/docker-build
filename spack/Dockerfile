# Copyright (c) 2020 R. Tohid
#
# Distributed under the Boost Software License, Version 1.0. (See a copy at
# http://www.boost.org/LICENSE_1_0.txt)

FROM fedora

RUN dnf -y update

RUN dnf install -y sudo

RUN dnf install -y git wget curl
RUN dnf install -y vim-enhanced 
RUN dnf install -y xz xz-devel bzip2 bzip2-devel zlib-devel tar
RUN dnf install -y which findutils bash-completion environment-modules

RUN dnf install -y make cmake automake autoconf libtool ccache

RUN dnf install -y gcc-c++ gcc-gfortran  redhat-rpm-config
RUN dnf install -y llvm llvm-devel compiler-rt clang clang-devel
RUN dnf install -y python3 python3-devel python3-pip

RUN dnf install -y patch
WORKDIR /home/stellar/

RUN git clone https://github.com/spack/spack.git

WORKDIR /home/stellar/spack
RUN git remote add stellar https://github.com/stellar-group/spack.git

RUN groupadd -r stellar
RUN useradd -r -m -g stellar -G wheel stellar
RUN echo '%wheel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN chown -R stellar:stellar /home/stellar

USER stellar