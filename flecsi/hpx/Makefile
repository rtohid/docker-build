all: 

	@echo "Please choose run or build."

IMAGE_NAME?=stellar-img
IMAGE_TAG?=flecsi

CONTAINER_NAME?=stellar-flecsi

build: Dockerfile
	docker build --rm -t ${IMAGE_NAME}:${IMAGE_TAG} .

run: build
	docker run --rm -td --name ${CONTAINER_NAME} --tty -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix ${IMAGE_NAME}:${IMAGE_TAG}

stop:
	docker stop ${CONTAINER_NAME}

interactive:
	docker exec -it ${CONTAINER_NAME} bash

prune:
	docker system prune -f

clean:
	docker rmi ${IMAGE_NAME}:${IMAGE_TAG}
	
.PHONY : clean distclean
