FROM ubuntu:18.04

RUN apt update

RUN apt install -y build-essential
RUN apt install -y git
RUN apt install -y sudo
RUN apt install -y libz-dev
RUN apt install -y wget curl
RUN apt install -y bash-completion
RUN apt install -y python3 python3-dev
RUN apt install -y cmake automake autoconf libtool

RUN adduser --disabled-password --gecos '' stellar
RUN adduser stellar sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

WORKDIR /home/stellar/src

RUN git clone -b physl_2019 --single-branch https://github.com/ct-clmsn/tiramisu.git

RUN chown -R stellar:stellar /home/stellar

USER stellar
