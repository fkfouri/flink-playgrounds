COMPOSE_REF?=../../operations-playground/docker-compose.yaml
BOOTSTRAP_SERVER=--bootstrap-server host.docker.internal:29092


.PHONY: help date
help:
	@echo "Usage: make [target]\n"


postgres_bash:
	docker-compose -f $(COMPOSE_REF) run --no-deps -it -u postgres postgres_service bash


########################
# Kafka
########################
topics_list:
	docker-compose -f $(COMPOSE_REF) run kafka kafka-topics $(BOOTSTRAP_SERVER) --list

topics_create:
	-docker-compose -f $(COMPOSE_REF) run kafka kafka-topics $(BOOTSTRAP_SERVER) --create --topic shipments --partitions 1 --replication-factor 1
	-docker-compose -f $(COMPOSE_REF) run kafka kafka-topics $(BOOTSTRAP_SERVER) --create --topic shipments-cdc --partitions 1 --replication-factor 1
	make topics_list

topics_delete:
	-docker-compose -f $(COMPOSE_REF) run kafka kafka-topics $(BOOTSTRAP_SERVER) --delete --topic shipments
	-docker-compose -f $(COMPOSE_REF) run kafka kafka-topics $(BOOTSTRAP_SERVER) --delete --topic shipments-cdc
	make topics_list

topics_consume_shipments:
	-docker-compose -f $(COMPOSE_REF) run kafka kafka-console-consumer $(BOOTSTRAP_SERVER) --topic shipments --from-beginning

topics_consume_cdc:
	-docker-compose -f $(COMPOSE_REF) run kafka kafka-console-consumer $(BOOTSTRAP_SERVER) --topic shipments-cdc --from-beginning
