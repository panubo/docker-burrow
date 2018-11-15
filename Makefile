TAG        := 1.1.0
IMAGE_NAME := panubo/burrow
REGISTRY   := docker.io

build:
	docker build -t ${IMAGE_NAME}:${TAG} .

run:
	docker run --rm -it ${IMAGE_NAME}:${TAG}

push:
	docker tag ${IMAGE_NAME}:${TAG} ${REGISTRY}/${IMAGE_NAME}:${TAG}
	docker push ${REGISTRY}/${IMAGE_NAME}:${TAG}
