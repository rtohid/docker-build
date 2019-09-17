all:
	@echo "Please choose run or build."

build-env: env.docker
	docker build -t flecsi:fedora-env -f env.docker .

run-env: build-env
	docker run -it --rm --tty -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
	flecsi:fedora-env bash

build-hpx: build-env hpx.docker
	docker build -t flecsi:fedora-hpx -f hpx.docker .

run-hpx: build-hpx
	docker run -it --rm --tty -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
	flecsi:fedora-hpx bash

build: build-env
	docker build -t flecsi:fedora-slack .

launch: build
	docker run --name devenv --privileged -d  -t --rm flecsi:fedora-slack

run: launch
	docker exec -it devenv /bin/bash

prune:
	docker system prune -f

.PHONY : clean distclean
