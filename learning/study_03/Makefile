COMPOSE_REF?=./docker-compose.yaml
BOOTSTRAP_SERVER=--bootstrap-server host.docker.internal:29092

.PHONY: help date
help:
	@echo "Usage: make [target]\n"
#################################################################################
# Java																			#
#################################################################################
java_bash:
	@echo "Starting bash..."
	-docker-compose -f $(COMPOSE_REF) run solution bash

postgres_bash:
	docker-compose -f $(COMPOSE_REF) run --no-deps -it -u postgres postgres bash

redpanda_bash:
	docker-compose -f $(COMPOSE_REF) exec -it redpanda bash

postgres_tooling:
	docker run --tty --rm -i \
	--network array-agg-network \
	quay.io/debezium/tooling:1.2 \
	bash -c 'pgcli postgresql://postgres:pwd@postgres:5432/study'

#################################################################################
# redpanda																		#
#################################################################################
rpk_help:
	docker-compose -f $(COMPOSE_REF) exec redpanda rpk --help

topics_help:
	docker-compose -f $(COMPOSE_REF) exec redpanda rpk topic --help

topics_list: 
	docker-compose -f $(COMPOSE_REF) exec redpanda rpk topic list

topics_create:
	-docker-compose -f $(COMPOSE_REF) exec redpanda rpk topic create orders_with_lines orders_with_lines_and_customer
	make topics_list

topics_delete:
	-docker-compose -f $(COMPOSE_REF) exec redpanda rpk topic delete orders_with_lines orders_with_lines_and_customer
	make topics_list

topic_consume:
	-docker-compose -f $(COMPOSE_REF) exec redpanda rpk topic consume orders_with_lines

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
	-docker-compose -f $(COMPOSE_REF) ps

playground_brower:
	@echo "Opening browser..."
# sudo apt-get install wslu 
# wslview http://localhost:8081
	open http://localhost:8081


sql_client:
	@echo "Entering Flink SQL Client..."
	docker-compose -f $(COMPOSE_REF) run sql-client