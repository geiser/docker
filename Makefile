ifndef path
$(error path variable is not set. Use `make path={path} target`)
endif

# import config.
cnf ?= config.env
include $(path)/$(cnf)
export $(shell sed 's/=.*//' $(path)/$(cnf))
TAG_NAME=$(DOCKER_REPO)/$(APP_NAME)

# HELP: This will output the help for each task
.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

# DOCKER TASKS
pull: ##  Pull the image
	docker pull $(TAG_NAME)

build: ##  Build the container
	docker build -t $(APP_NAME) --target $(VERSION) $(path)

build-nc: ## Build the container without caching
	docker build --no-cache -t $(APP_NAME) --target $(VERSION) $(path)

run: tag ## Run container
	docker run -i -t --rm $(RUN_OPTIONS) --name="$(APP_NAME)" $(TAG_NAME)

shell: tag ## Run container as shell
	docker run --name="$(APP_NAME)" --rm -it --entrypoint /bin/bash $(TAG_NAME)

up: build run ## Build and run the container

stop: ## Stop and remove a running container
	docker stop $(APP_NAME); docker rm $(APP_NAME)

release: build publish ## Make a release by building and publishing the `{version}` as `latest` tagged containers to the docker.io

release-nc: build-nc publish ## Make a release by building the container without caching the image, and publishing the `{version}` as `latest` tagged containers in the docker.io

# Docker publish
publish: publish-latest publish-version ## Publish the `{version}` ans `latest` tagged containers to docker.io

publish-latest: tag-latest ## Publish the `latest` taged container to the docker.io
	@echo 'publish latest to docker.io/$(TAG_NAME):latest'
	docker push $(TAG_NAME):latest

publish-version: tag-version ## Publish the `{version}` taged container to the docker.io
	@echo 'publish $(VERSION) to docker.io/$(TAG_NAME):$(VERSION)'
	docker push $(TAG_NAME):$(VERSION)

# Docker tagging
tag: tag-latest tag-version ## Generate container tags for the `{version}` ans `latest` tags

tag-latest: ## Generate container `{version}` tag
	@echo 'create tag latest'
	docker tag $(APP_NAME) $(TAG_NAME):latest

tag-version: ## Generate container `latest` tag
	@echo 'create tag $(VERSION)'
	docker tag $(APP_NAME) $(TAG_NAME):$(VERSION)

# HELPERS
version: ## Output the current version
	@echo $(VERSION)
