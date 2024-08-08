COMPOSE_REF?=operations-playground/docker-compose.yaml
BOOTSTRAP=--bootstrap-server host.docker.internal:9092 

.PHONY: help date
help:
	@echo "Usage: make [target]\n"

start_playground:
	@echo "Starting playground..."
	-docker-compose -f $(COMPOSE_REF) up -d --build

stop_playground:
	@echo "Stopping playground..."
	-docker-compose -f $(COMPOSE_REF) down

ps:
	@echo "Listing containers..."
	-@docker-compose -f $(COMPOSE_REF) ps

open_brower:
	@echo "Opening browser..."
# sudo apt-get install wslu 
# wslview http://localhost:8081
	open http://localhost:8081

flink:
	docker-compose -f $(COMPOSE_REF) run --no-deps client flink

bash:
	docker-compose -f $(COMPOSE_REF) run --no-deps -it client bash

list_topics:
	docker-compose -f $(COMPOSE_REF) run kafka kafka-topics.sh $(BOOTSTRAP) --list

run_job_1:
	@echo "Running job 1..."
	docker-compose -f $(COMPOSE_REF) exec job1 python3 /app/job1.py