#
# Django Boston Website project makefile
#

include .env*
export $(shell sed 's/=.*//' .env*)

SHELL := /bin/bash
.PHONY: help


help: ## This help message
	@echo -e "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | \
		sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\x1b[36m\1\\x1b[m:\2/' | column -c2 -t -s :)"

foo:  ## Test foo
	@echo -e "FOO = $(FOO)"


#
# use docker-compose run --rm djangoapp /bin/bash -c "command" to 
# 1. execute a command or set of commands when running a set of containers
# 2. automatically remove the container when done
# TODO: Remove named volumes

docker.app.build:  ## Build the Django app image
	docker build -t djbo_app .

docker.app.shell:  ## Start the docker app standaloe
	docker run --name djbo_standalone -it djbo_app:latest /bin/bash


ds.up:  ## Start docker-composed devstack
	docker-compose up

ds.app.sh:  ## Shell into the Django app container
	docker exec -it $(DOCKER_APP_CONTAINER_NAME) /bin/bash

ds.app.collectstatic:  ## Collect static assets 
	docker-compose run djangoapp djangoboston/manage.py collectstatic --no-input

ds.nginx.sh:  ## Shell into the database container
	docker exec -it $(DOCKER_NGINX_CONTAINER_NAME) /bin/bash

ds.db.sh:  ## Shell into the database container
	docker exec -it $(DOCKER_DB_CONTAINER_NAME) /bin/bash




# ds.prune
# docker-compose run --rm djangoapp /bin/bash -c "cd djangoboston; ./manage.py migrate"

