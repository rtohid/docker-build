#!/bin/bash -e

# Copyright (c) 2019 R. Tohid
#
# Distributed under the Boost Software License, Version 1.0. (See a copy at
# http://www.boost.org/LICENSE_1_0.txt)

ARGS=$@
FILENAME=$0

while [[ $# -gt 0 ]]
do
  key="$1"

  case $key in
    -b|--build)
      COMMAND="build"
      shift
      ;;
    -r|--run)
      COMMAND="run"
      shift
      ;;
    *) echo "Invalid argument: <$1>"
      exit -1
      ;;
  esac
done

build_image()
{
  docker build -t tpl:fedora .
}

run_image()
{
  docker run -it --rm --tty -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix tpl:fedora bash
}

if [ "$COMMAND" = "build" ]; then
  build_image
fi

if [ "$COMMAND" = "run" ]; then
  run_image
fi
