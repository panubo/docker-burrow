NAME       := burrow
TAG        := latest #$(shell sed -E -e '/BURROW_VERSION[ |=|v]+[0-9\.]+/!d' -e 's/.*BURROW_VERSION[ |=|v]+([0-9\.]+).*/\1/' Dockerfile)
IMAGE_NAME := panubo/$(NAME)

.PHONY: *

help:
	@printf "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\x1b[36m\1\\x1b[m:\2/' | column -c2 -t -s :)\n"

build:  ## build image
	docker build --pull -t $(IMAGE_NAME):$(TAG) .

push:
	docker push $(IMAGE_NAME):$(TAG)

clean:
	docker rmi $(IMAGE_NAME):$(TAG)

run:  ## run image
	docker run -t $(IMAGE_NAME):$(TAG)
