# Copyright (c) 2020 R. Tohid (@rtohid)
#
# Distributed under the Boost Software License, Version 1.0. (See a copy at
# http://www.boost.org/LICENSE_1_0.txt)

FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt install -y sudo

# add user
RUN adduser --disabled-password --gecos '' stellar
RUN adduser stellar sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# OS Packages
WORKDIR /home/stellar
USER stellar

# oh-my-bash
WORKDIR /tmp/
RUN sh -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)"

WORKDIR /home/stellar
