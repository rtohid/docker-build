# Copyright (c) 2020 R. Tohid (@rtohid)
#
# Distributed under the Boost Software License, Version 1.0. (See a copy at
# http://www.boost.org/LICENSE_1_0.txt)

# https://github.com/hdc-arizona/traveler-integrated/blob/main/Dockerfile

FROM stevenrbrandt/phylanx.test:working

USER root
RUN echo jovyan:fishfood77 | chpasswd

# Fix otf2 path
ENV PATH="/usr/local/otf2/bin:${PATH}"

# Set up traveler-integrated
WORKDIR /home/jovyan
RUN git clone https://github.com/hdc-arizona/traveler-integrated
WORKDIR /home/jovyan/traveler-integrated
RUN find . | xargs chown jovyan
RUN pip3 install -r requirements.txt
EXPOSE 8000

# Set up jupyter
RUN pip3 install jupyter requests
EXPOSE 8789

WORKDIR /home/jovyan/files
# COPY sweetnsassy.py ./
# COPY config.py ./
WORKDIR /home/jovyan/traveler-integrated

RUN chown jovyan ~jovyan/.bashrc
RUN dnf install -y jq
WORKDIR /home/jovyan
RUN git clone https://github.com/TACC-Cloud/tapis-cli-ng
WORKDIR /home/jovyan/tapis-cli-ng
RUN pip3 install --upgrade pip
RUN ln -s /home/jovyan/tapis-cli-ng /usr/local/cli
RUN dnf install -y glibc-langpack-en
ENV LC_ALL en_US.utf8

USER jovyan
WORKDIR /home/jovyan
RUN git clone https://github.com/stevenrbrandt/workenv.git
WORKDIR /home/jovyan/workenv
RUN python3 install.py
WORKDIR /home/jovyan/traveler-integrated/notebook
ENV PATH /usr/local/cli/bin:/home/jovyan/traveler-integrated/notebook/agave-cli/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/otf2/bin/

# Default container command is to launch jupyter
WORKDIR /home/jovyan/traveler-integrated/notebook
CMD ["bash", "/home/jovyan/traveler-integrated/jupyter.sh"]
