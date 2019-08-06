#!/bin/bash -e

# Copyright (c) 2019 R. Tohid
#
# Distributed under the Boost Software License, Version 1.0. (See a copy at
# http://www.boost.org/LICENSE_1_0.txt)

ARGS=$@
FILENAME=$0
NUM_JOBS=`grep -c ^processor /proc/cpuinfo`

FTP_DIR=/tmp/ftp
INSTALL_DIR=/home/flecsi/.FleCSI/install/ftp
mkdir -p $INSTALL_DIR

while [[ $# -gt 0 ]]
do
    key="$1"

    case $key in
        -b|--build)
            COMMAND="build"
            BUILD_TYPE="${2^}"
            shift
            shift
            ;;
        -h|--help)
            help
            exit 0
            shift
            ;;
        -i|--install)
            COMMAND="install"
            BUILD_TYPE="${2^}"
            shift
            shift
            ;;
        *) echo "Invalid argument: <$1>"
            exit -1
            ;;
    esac
done

if [ "$BUILD_TYPE" != "Debug" ] && [ "$BUILD_TYPE" != "Release" ] && [ "$BUILD_TYPE" != "RelWithDebInfo" ]; then
    BUILD_TYPE='Debug'
    echo "Build type '$BUILD_TYPE' is not reconized. Falling back to 'Debug'."
    echo "Press Ctrl+c to cancel"
    
    sleep 5s
fi

setup_ftp_src()
{
    rm -rf $FTP_DIR
    cd /tmp
    git clone --recursive https://github.com/laristra/flecsi-third-party.git $FTP_DIR
}

build_ftp()
{
    BUILD_DIR=$FTP_DIR/build
    mkdir -p "$BUILD_DIR"
    cd "$BUILD_DIR"
    cmake \
        -DBUILD_SHARED_LIBS=ON                                                 \
        -DCMAKE_BUILD_TYPE=$BUILD_TYPE                                         \
        -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR                                    \
        -DENABLE_METIS=ON                                                      \
        -DMETIS_MODEL=parallel                                                 \
        -DENABLE_HPX=ON                                                        \
        -DENABLE_EXODUS=ON                                                     \
        -DENABLE_LEGION=OFF                                                    \
        $FTP_DIR

    # make VERBOSE=1 -j $NUM_JOBS
    make -j $NUM_JOBS
}

install_ftp()
{
    build_ftp
    cd $BUILD_DIR
    make -j $NUM_JOBS install
}

setup_ftp_src

if [ "$COMMAND" = "build" ]; then
    build_ftp
fi

if [ "$COMMAND" = "install" ]; then
    install_ftp
fi
