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

INIT_CHECK = if [ -f /var/www/composer.json ]; then \
	echo 'Project is already initialized. Skipping...'; \
else \
	$(SYMFONY_NEW_COMMAND) temp-symfony && \
	mv -n temp-symfony/* temp-symfony/.[!.]* /var/www/ && \
	rm -rf temp-symfony; \
	rm compose.yaml compose.override.yaml; \
fi

init-symfony: ## Internal target, do not call directly, use init or init-web
	@docker compose run --rm php sh -c "$(INIT_CHECK)"

init: ## Init new symfony web app project
	$(MAKE) SYMFONY_NEW_COMMAND="symfony new" init-symfony

init-web: ## Init new symfony web app project
	$(MAKE) SYMFONY_NEW_COMMAND="symfony new --webapp" init-symfony

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