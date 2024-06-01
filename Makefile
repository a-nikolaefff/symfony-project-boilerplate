.PHONY: help

CONTAINER_PHP=php

COMMANDS_WITH_ARGUMENTS := debug migration

GIT_USER_NAME := $(shell git config --global user.name)
GIT_USER_EMAIL := $(shell git config --global user.email)

ifneq (,$(filter $(firstword $(MAKECMDGOALS)),$(COMMANDS_WITH_ARGUMENTS)))
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
endif

help: ## Print help
	@awk 'BEGIN {FS = ":.*##"; printf "\nCommands:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

#--------------------------------------------- New project init command -----------------------------------------------#

init: ## Init new symfony web app project
	@docker compose run --rm php sh -c "\
	if [ -f /var/www/composer.json ]; then \
		echo 'Project is already initialized. Skipping...'; \
	else \
		symfony new temp-symfony && \
		mv -n temp-symfony/* temp-symfony/.[!.]* /var/www/ && \
		rm -rf temp-symfony; \
	fi"

init-web: ## Init new symfony web app project
	@docker compose run --rm php sh -c "\
	if [ -f /var/www/composer.json ]; then \
		echo 'Project is already initialized. Skipping...'; \
	else \
		symfony new --webapp temp-symfony && \
		mv -n temp-symfony/* temp-symfony/.[!.]* /var/www/ && \
		rm -rf temp-symfony; \
	fi"

#------------------------------------------------- Docker commands ----------------------------------------------------#

build: ## Build all containers
	docker compose build --build-arg GIT_USER_NAME="$(GIT_USER_NAME)" --build-arg GIT_USER_EMAIL="$(GIT_USER_EMAIL)"

up: ## Start all containers
	docker compose up -d

down: ## Stop all containers
	docker compose down

php: ## Enter PHP container
	docker compose exec ${CONTAINER_PHP} /bin/bash

#---------------------------------------------------- NPM commands ----------------------------------------------------#

watch: ## Watch assets
	npm run dev

prod: ## Build assets
	npm run build