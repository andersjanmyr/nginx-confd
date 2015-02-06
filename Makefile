# A makefile for Docker builds
REGISTRY = andersjanmyr
NAME = nginx-confd
# VERSION will be sent as a parameter: `make publish VERSION=1.1.1`
VERSION = development
IMAGE = $(REGISTRY)/$(NAME)
IMAGE_WITH_VERSION = $(REGISTRY)/$(NAME):$(VERSION)
LATEST = $(REGISTRY)/$(NAME):latest

default:
	@echo 'Available targets: build, publish, run, bash'

# Builds and tags the image
build:
	docker build --rm -t $(IMAGE_WITH_VERSION) .

# Pushes the image to the docker-registry
publish: build
	docker tag -f $(IMAGE_WITH_VERSION) $(LATEST)
	docker push $(IMAGE)

image:
	@echo $(IMAGE_WITH_VERSION)

run:
	docker run -p 80 $(IMAGE_WITH_VERSION)

bash:
	docker run -it $(IMAGE_WITH_VERSION) bash
