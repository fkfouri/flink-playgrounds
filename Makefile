COMPOSE_REF?=operations-playground/docker-compose.yaml
BOOTSTRAP_SERVER=--bootstrap-server host.docker.internal:29092

.PHONY: help date
help:
	@echo "Usage: make [target]\n"
#################################################################################
# DOCKER Clear																	#
#################################################################################
clear-i: 
	-docker rmi $(shell docker images --filter "dangling=true" -q --no-trunc) --force

clear-c:
	-docker rm $(shell docker ps -a -q)

clear-all-c:
	-docker container rm $(shell docker container ls -aq)

clear-all-i:
	-docker rmi $(shell docker images -a -q) --force

#https://docs.docker.com/engine/reference/commandline/images/#format-the-output
clear-date-i:
	-docker rmi $(shell docker images "*/*/*/*:20*" --format "{{.Repository}}:{{.Tag}}") --force

clear-volume:
# -docker volume rm $(shell docker volume ls -q)
	docker volume prune

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


########################
# Kafka
########################
topics_list:
	docker-compose -f $(COMPOSE_REF) run kafka kafka-topics $(BOOTSTRAP_SERVER) --list

topics_create:
	-docker-compose -f $(COMPOSE_REF) run kafka kafka-topics $(BOOTSTRAP_SERVER) --create --topic compras --partitions 1 --replication-factor 1
	-docker-compose -f $(COMPOSE_REF) run kafka kafka-topics $(BOOTSTRAP_SERVER) --create --topic usuarios --partitions 1 --replication-factor 1
	-docker-compose -f $(COMPOSE_REF) run kafka kafka-topics $(BOOTSTRAP_SERVER) --create --topic simple_test
	make topics_list

topics_delete:
	-docker-compose -f $(COMPOSE_REF) run kafka kafka-topics $(BOOTSTRAP_SERVER) --delete --topic compras
	-docker-compose -f $(COMPOSE_REF) run kafka kafka-topics $(BOOTSTRAP_SERVER) --delete --topic usuarios
	-docker-compose -f $(COMPOSE_REF) run kafka kafka-topics $(BOOTSTRAP_SERVER) --delete --topic simple_test
	make topics_list

kafka_produce:
	docker-compose -f $(COMPOSE_REF) run kafka kafka-console-producer $(BOOTSTRAP_SERVER) --topic simple_test

kafka_consume:
	docker-compose -f $(COMPOSE_REF) run kafka kafka-console-consumer $(BOOTSTRAP_SERVER) --from-beginning --topic simple_test

########################
# python
########################
python_bash:
	docker-compose -f $(COMPOSE_REF) run --no-deps -it python_service bash

python_compras:
	@echo "Produzindo mensagens no topico compras..."
	docker-compose -f $(COMPOSE_REF) run --no-deps python_service python3 ./src/produtor_compras.py 

python_usuarios:
	@echo "Produzindo mensagens no topico usuarios..."
	docker-compose -f $(COMPOSE_REF) run --no-deps python_service python3 ./src/produtor_usuarios.py 

########################
# Flink
########################
flink:
	@echo "Executa comando CLI Flink..."
	docker-compose -f $(COMPOSE_REF) run --no-deps client flink $(OPTIONS)

fk_flink_bash:
	@echo "Entrando no container base_flink..."
	docker-compose -f $(COMPOSE_REF) run --no-deps -it base_flink bash

flink_bash:
	@echo "Entrando no container client..."
	docker-compose -f $(COMPOSE_REF) run --no-deps -it client bash

sql_client:
	@echo "Entering Flink SQL Client..."
	docker-compose -f $(COMPOSE_REF) run --no-deps client ./bin/sql-client.sh


job_1:
	@echo "Running job 1..."
	docker-compose -f $(COMPOSE_REF) run --no-deps client flink run examples/streaming/WordCount.jar

job_2:
	@echo "Running job 2, Exemplo Table_api em python"
	docker-compose -f $(COMPOSE_REF) run --no-deps -it -v \
	$$(pwd)/docker/python:/opt/flink/python client python ./python/src/table_api.py 	