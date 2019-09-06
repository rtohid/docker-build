all:
	@echo "Please choose run or build."

build-env: Dockerfile.env
	docker build -t flecsi:fedora-env -f Dockerfile.env .

run-env: build-env
	docker run -it --rm --tty -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
	flecsi:fedora-env bash

build: build-env Dockerfile
	docker build -t flecsi:fedora-slack .

run: build
	docker run -it --rm --tty -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
	flecsi:fedora-slack bash

.PHONY : clean distclean
