TAG        := $(shell sed -E -e '/BURROW_VERSION[ |=|v]+[0-9\.]+/!d' -e 's/.*BURROW_VERSION[ |=|v]+([0-9\.]+).*/\1/' Dockerfile)
IMAGE_NAME := panubo/burrow
REGISTRY   := docker.io

.PHONY: build push clean
build:
	docker build --pull -t $(IMAGE_NAME):$(TAG) .

push:
	docker tag $(IMAGE_NAME):$(TAG) $(REGISTRY)/$(IMAGE_NAME):$(TAG)
	docker push $(REGISTRY)/$(IMAGE_NAME):$(TAG)

clean:
	docker rmi $(IMAGE_NAME):$(TAG)
	docker rmi $(REGISTRY)/$(IMAGE_NAME):$(TAG)
