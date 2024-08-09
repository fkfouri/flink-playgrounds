# Estudo 1

Neste estudo sendo aberto o SQL do Flink e vendo os dados do Kafka.

```bash
# Sobe o playground
make playground_up

# cria os topicos
make topics_create

# entra no SQL Client
make sql_client
```


## Flink SQL Client
```sql

-- Config de saida (mais bonita)
set sql-client.execution.result-mode = tableau;

-- https://nightlies.apache.org/flink/flink-docs-release-1.14/docs/connectors/table/kafka/
-- Cria tabela usuarios
CREATE TABLE usuarios (
    cidade      STRING,
    nome        STRING,
    bairro      STRING,
    id_compra   INTEGER
) WITH (
    'connector' = 'kafka',
    'topic' = 'usuarios',
    'properties.bootstrap.servers' = 'host.docker.internal:29092',
    'properties.group.id' = 'group.usuarios',
    'scan.startup.mode' = 'earliest-offset',
    'format' = 'json'
);

-- Cria tabela compras
CREATE TABLE compras (
    id_compra   INTEGER,
    produto     STRING,
    preco       STRING,
    data        STRING,
    valor       INTEGER
) WITH (
    'connector' = 'kafka',
    'topic' = 'compras',
    'properties.bootstrap.servers' = 'host.docker.internal:29092',
    'properties.group.id' = 'group.compras',
    'scan.startup.mode' = 'earliest-offset',
    'format' = 'json'
);

-- exibe tabelas
show tables;

SELECT * FROM usuarios;
SELECT * FROM compras;
```


## Python

Configurando python para rodar local.
```bash
python3 -m venv .venv

source myenv/bin/activate

pip install -r docker/python/requirements.txt
```