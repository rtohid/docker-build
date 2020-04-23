# Copyright (c) 2020 R. Tohid
#
# Distributed under the Boost Software License, Version 1.0. (See a copy at
# http://www.boost.org/LICENSE_1_0.txt)

FROM ubuntu:18.04

RUN apt update
RUN apt install -y sudo


RUN apt install -y clang-8 python3.8 python3.8-dev
RUN apt install -y build-essential
RUN apt install -y cmake automake autoconf libtool
RUN apt install -y zlib1g-dev libz-dev
RUN apt install -y git vim
RUN apt install -y wget curl
RUN apt install -y bash-completion
RUN apt install -y libisl-dev

RUN apt install -y python3.8-distutils
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python3.8 get-pip.py
RUN python3.8 -m pip install pytest numpy astpretty
RUN adduser --disabled-password --gecos '' stellar
RUN adduser stellar sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

WORKDIR /home/stellar/src
RUN git clone -b physl_2019 --single-branch https://github.com/rtohid/tiramisu.git

WORKDIR /home/stellar/src/tiramisu/build
RUN cmake ..
RUN make -j tiramisu

WORKDIR /home/stellar/src/
RUN git clone --single-branch https://github.com/pybind/pybind11.git

WORKDIR /home/stellar/src/pybind11/build
RUN cmake ..
RUN make -j
RUN make install
RUN python3.8 -m pip install pybind11

WORKDIR /home/stellar/src
RUN git clone -b tiramisu --single-branch https://github.com/rtohid/phyflow.git

WORKDIR /home/stellar/src/phyflow/backend
RUN ln -s /home/stellar/src/tiramisu/build/libtiramisu.so .
RUN make -j

RUN chown -R stellar:stellar /home/stellar
RUN echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH/home/stellar/src/phyflow/backend" >> /home/stellar/.bashrc

WORKDIR /home/stellar
USER stellar
WORKDIR /home/stellar/src/phyflow/backend

RUN sh -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)"