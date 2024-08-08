# Flink

- Conceitos: https://nightlies.apache.org/flink/flink-docs-release-1.14/docs/learn-flink/overview/
- Playground - https://nightlies.apache.org/flink/flink-docs-release-1.14/docs/try-flink/flink-operations-playground/


```bash
cd operations-playground
docker-compose build

# Create directories
mkdir -p /tmp/flink-checkpoints-directory
mkdir -p /tmp/flink-savepoints-directory


# Run
docker-compose up -d

# Check
docker-compose ps

# Logs Job Manager
docker-compose logs -f jobmanager

# Logs Task Manager
docker-compose logs -f taskmanager

# Flink CLI (usando o service chamado Client)
docker-compose run --no-deps client flink --help
```


