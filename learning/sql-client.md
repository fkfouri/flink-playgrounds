# SQL-Client


```sql
show tables;

-- Config de saida (mais bonita)
set sql-client.execution.result-mode = tableau;

CREATE TABLE usuarios (
    cidade      STRING,
    nome        STRING,
    bairro      STRING,
    id_compra   INTEGER
) WITH (
    'connector' = 'kafka',
    'topic' = 'usuarios',
    'properties.bootstrap.servers' = 'localhost:9092',
    'properties.group.id' = 'group.usuarios',
    'scan.startup.mode' = 'earliest-offset',
    'format' = 'json'
);

-- https://nightlies.apache.org/flink/flink-docs-release-1.14/docs/connectors/table/kafka/
CREATE TABLE compras (
    id_compra   INTEGER,
    produto     STRING,
    preco       STRING,
    data        STRING,
    valor       INTEGER
) WITH (
    'connector' = 'kafka',
    'topic' = 'compras',
    'properties.bootstrap.servers' = 'localhost:9092',
    'properties.group.id' = 'group.compras',
    'scan.startup.mode' = 'earliest-offset',
    'format' = 'json'
);

show tables;

SELECT * FROM usuarios;
``` 