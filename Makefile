COMPOSE_REF?=operations-playground/docker-compose.yaml
BOOTSTRAP_SERVER=--bootstrap-server host.docker.internal:9092

.PHONY: help date
help:
	@echo "Usage: make [target]\n"

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


########################
# Kafka
########################
list_topics:
	docker-compose -f $(COMPOSE_REF) run kafka kafka-topics.sh $(BOOTSTRAP_SERVER) --list

create_topics:
	-docker-compose -f $(COMPOSE_REF) run kafka kafka-topics.sh $(BOOTSTRAP_SERVER) --create --topic compras --partitions 1 --replication-factor 1
	-docker-compose -f $(COMPOSE_REF) run kafka kafka-topics.sh $(BOOTSTRAP_SERVER) --create --topic usuarios --partitions 1 --replication-factor 1
	make list_topics

########################
# python
########################
python_bash:
	docker-compose -f $(COMPOSE_REF) run --no-deps -it python bash

########################
# Flink
########################
flink:
	docker-compose -f $(COMPOSE_REF) run --no-deps client flink $(OPTIONS)

fk_flink_bash:
	docker-compose -f $(COMPOSE_REF) run --no-deps -it apache/fk-flink-base bash

flink_bash:
	docker-compose -f $(COMPOSE_REF) run --no-deps -it client bash

sql_client:
	@echo "Entering Flink SQL Client..."
	docker-compose -f $(COMPOSE_REF) run --no-deps client ./bin/sql-client.sh


job_1:
	@echo "Running job 1..."
	docker-compose -f $(COMPOSE_REF) run --no-deps client flink run examples/streaming/WordCount.jar
