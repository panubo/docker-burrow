VERSION    := $(shell sed -E -e '/BURROW_VERSION[ |=|v]+[0-9\.]+/!d' -e 's/.*BURROW_VERSION[ |=|v]+([0-9\.]+).*/\1/' Dockerfile)
IMAGE_NAME := panubo/burrow
REGISTRY   := docker.io

.PHONY: build push clean
build:
	docker build --pull -t $(IMAGE_NAME):$(VERSION) .

push:
	docker tag $(IMAGE_NAME):$(VERSION) $(REGISTRY)/$(IMAGE_NAME):$(VERSION)
	docker push $(REGISTRY)/$(IMAGE_NAME):$(VERSION)

clean:
	docker rmi $(IMAGE_NAME):$(VERSION)
	docker rmi $(REGISTRY)/$(IMAGE_NAME):$(VERSION)
