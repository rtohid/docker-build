# Copyright (c) 2020 R. Tohid (@rtohid)
#
# Distributed under the Boost Software License, Version 1.0. (See a copy at
# http://www.boost.org/LICENSE_1_0.txt)

FROM fedora

ARG CPUS=4
ARG BUILD_TYPE=Debug

RUN dnf install -y make cmake git bzip2 zlib-devel hwloc-devel 
RUN dnf install -y gcc-c++ gcc
RUN dnf install -y blas blas-devel lapack lapack-devel boost-devel
RUN dnf install -y findutils openssl-devel papi papi-devel  
RUN dnf install -y libatomic which compat-openssl10 vim-enhanced wget 
RUN dnf install -y gdb sudo openmpi-devel sqlite-devel sqlite
RUN dnf install -y lm_sensors-devel hdf5-devel
RUN dnf install -y libffi-devel
RUN dnf install -y python3.8 python-devel
RUN dnf install -y python3.8 pybind11-devel


RUN ln -s /usr/lib64/openmpi/lib/libmpi_cxx.so /usr/lib64/openmpi/lib/libmpi_cxx.so.1
RUN ln -s /usr/lib64/openmpi/lib/libmpi.so /usr/lib64/openmpi/lib/libmpi.so.12

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python3.8 get-pip.py
RUN pip3.8 install -U flake8 yapf pytest pylint
RUN pip3.8 install -U --trusted-host pypi.org --trusted-host files.pythonhosted.org numpy
RUN pip3.8 install -U --trusted-host pypi.org --trusted-host files.pythonhosted.org tensorflow
RUN pip3.8 install -U --trusted-host pypi.org --trusted-host files.pythonhosted.org idx2numpy
RUN pip3.8 install -U --trusted-host pypi.org --trusted-host files.pythonhosted.org matplotlib
RUN pip3.8 install -U --trusted-host pypi.org --trusted-host files.pythonhosted.org sortedcontainers
RUN pip3.8 install -U --trusted-host pypi.org --trusted-host files.pythonhosted.org keras

WORKDIR /home/stellar/src/
RUN git clone https://github.com/rtohid/scripts.git

WORKDIR /home/stellar/src/scripts/kubuntu/build/phylanx

RUN chmod u+x ./*
RUN ./blaze.sh -i ${BUILD_TYPE}
RUN ./blaze_tensor.sh -i ${BUILD_TYPE}
RUN ./pybind11.sh -i ${BUILD_TYPE}
RUN ./hpx.sh -i ${BUILD_TYPE}
RUN ./phylanx.sh -i ${BUILD_TYPE}

RUN echo "ALL            ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN useradd -m stellar
RUN echo "export PYTHONPATH=$PYTHONPATH:/home/stellar/install/phylanx/Release/lib64" >> /home/stellar/.bashrc
RUN chown -R stellar:stellar /home/stellar
USER stellar
WORKDIR /home/stellar
