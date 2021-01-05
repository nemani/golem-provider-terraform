
SHELL := /bin/bash
.DEFAULT_GOAL := help

include .env

.PHONY: help
help:		## Display this help message
	@echo -e "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\x1b[36m\1\\x1b[m:\2/' | column -c2 -t -s :)"

.PHONY: pull
pull: 		## Pull the latest image version
	docker-compose pull

.PHONY: up
up: 		## Start the node
	docker-compose up -d --remove-orphans

.PHONY: stop
stop: 		## Stop the node
	docker-compose stop

.PHONY: destroy
destroy: 	## Destroy the node (volumes are not removed)
	docker-compose down --remove-orphans

.PHONY: restart
restart: 	## Restart the node
	docker-compose restart

.PHONY: shell
shell: 		## Enter the container shell
	docker-compose exec node bash

.PHONY: logs
logs: 		## Display the container logs
	docker-compose logs -t --tail=10 -f

.PHONY: golem-logs
golem-logs: 		## Display the container logs
	docker-compose logs -t --tail=10 -f node

.PHONY: golem-setup
golem-setup: 		## Setup the node for the first time
	docker-compose run --rm node golemsp settings set --node-name provider-node-${hostname} --address ${wallet_address} --cpu-per-hour ${cpu_per_hour}

.PHONY: golem-status
golem-status: 	## Get the running node status
	docker-compose exec node golemsp status

docker: 
	sudo sh ./scripts/get-docker.sh
	sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-`uname -s`-`uname -m`" -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose

deps:
	sudo apt update
	sudo apt install -y git curl zip unzip
	make docker
	sudo sh ./scripts/setup-kvm.sh
