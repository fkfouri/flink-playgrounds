# Flink

- Conceitos: https://nightlies.apache.org/flink/flink-docs-release-1.14/docs/learn-flink/overview/
- Playground - https://nightlies.apache.org/flink/flink-docs-release-1.14/docs/try-flink/flink-operations-playground/
- Conectores Kafka: https://mvnrepository.com/artifact/org.apache.flink/flink-connector-kafka
- Configurações Flink:  https://nightlies.apache.org/flink/flink-docs-release-1.20/docs/deployment/config/
- Configurações Flink Docker: https://nightlies.apache.org/flink/flink-docs-release-1.20/docs/deployment/resource-providers/standalone/docker/

- bUILTIN Function: https://nightlies.apache.org/flink/flink-docs-release-1.20/docs/dev/table/sql/queries/overview/#syntax
- DataTypes: https://nightlies.apache.org/flink/flink-docs-release-1.19/docs/dev/table/types/



- SQL_CLIENT: https://nightlies.apache.org/flink/flink-docs-master/docs/dev/table/sqlclient/

TODO:

- Ver continuação do video Episodio 2 (https://www.youtube.com/watch?v=doP_xrnyvts)
- Ver essa introdução (https://www.youtube.com/watch?v=gbcxBptrlCI)


- Estudo Linkedin (https://www.linkedin.com/learning/apache-flink-real-time-data-engineering/setting-up-the-flink-environment)
- Estudo 3
    - 3 containers Kafka
    - testar o Flink com Kafka caindo
- Estudo 4
    - Avro

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


## Python

Configurando python para rodar local.
```bash
python3 -m venv .venv

source myenv/bin/activate

pip install -r docker/python/requirements.txt
```