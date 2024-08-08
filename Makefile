.PHONY: help date
help:
	@echo "Usage: make [target]\n"

start_playground:
	@echo "Starting playground..."
	docker-compose -f operations-playground/docker-compose.yaml up -d --build

stop_playground:
	@echo "Stopping playground..."
	docker-compose -f operations-playground/docker-compose.yaml down