COMPOSE_REF?=./docker-compose.yaml
BOOTSTRAP_SERVER=--bootstrap-server host.docker.internal:29092

.PHONY: help date
help:
	@echo "Usage: make [target]\n"
#################################################################################
# DOCKER Clear																	#
#################################################################################

#################################################################################
# Playground																	#
#################################################################################
playground_up:
	@echo "Starting playground..."
	-docker-compose -f $(COMPOSE_REF) up -d --build

playground_down:
	@echo "Stopping playground..."
	-docker-compose -f $(COMPOSE_REF) down

ps:
	@echo "Listing containers..."
	-@docker-compose -f $(COMPOSE_REF) ps

playground_brower:
	@echo "Opening browser..."
# sudo apt-get install wslu 
# wslview http://localhost:8081
	open http://localhost:8081
