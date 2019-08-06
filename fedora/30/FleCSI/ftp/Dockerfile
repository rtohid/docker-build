# Copyright (c) 2019 R. Tohid
#
# Distributed under the Boost Software License, Version 1.0. (See a copy at
# http://www.boost.org/LICENSE_1_0.txt)

FROM fedora:latest

ARG USERNAME
ARG BUILD_TYPE

RUN dnf install -y sudo
RUN dnf install -y bash-completion
RUN dnf install -y powerline powerline-fonts
RUN dnf install -y make cmake automake autoconf libtool ccache
RUN dnf install -y gcc-c++ gcc-gfortran openmpi-devel redhat-rpm-config clang
RUN dnf install -y llvm compiler-rt clang-devel llvm-devel
RUN dnf install -y texlive-epstopdf-bin ghostscript-core texlive-latex-bin-bin
RUN dnf install -y texlive-collection-fontsrecommended texlive-fancyhdr
RUN dnf install -y findutils texlive-booktabs
RUN dnf install -y gdb wget curl lcov boost-devel hwloc-devel
RUN dnf install -y flex patch doxygen graphviz pandoc cereal-devel lapack-devel
RUN dnf install -y environment-modules 
RUN dnf install -y hdf5-openmpi-devel exodusii-devel scotch-devel metis-devel
RUN dnf install -y python2 python-pip python3-pip python3-devel
RUN dnf install -y git vim-minimal

RUN wget -O /usr/bin/doxy-coverage https://raw.githubusercontent.com/alobbs/doxy-coverage/master/doxy-coverage.py
RUN chmod +x /usr/bin/doxy-coverage

RUN groupadd -r flecsi
RUN useradd -r -m -g flecsi -G wheel flecsi
RUN echo '%wheel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER flecsi

ENV PATH=$PATH:/home/flecsi/.local/bin:/usr/lib64/ccache:/usr/lib64/openmpi/bin/${PATH:+:}${PATH}
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib64/openmpi/lib/${LD_LIBRARY_PATH:+:}${LD_LIBRARY_PATH}
ENV PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.7/site-packages${PYTHONPATH:+:}${PYTHONPATH}
ENV OPENMPI=true
WORKDIR /home/flecsi
RUN pip3 install --user codecov coverxygen gcovr Sphinx recommonmark sphinx_rtd_theme breathe

COPY build_ftp.sh /tmp/build_ftp.sh
RUN bash /tmp/build_ftp.sh -b debug
