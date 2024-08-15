# Estudo 2

Neste estudo sendo utilizado o Flink Kafka e Kafka Upsert Demo

- [![Youtube](https://img.youtube.com/vi/1ezf3OyLz3w/mqdefault.jpg)](https://youtu.be/1ezf3OyLz3w)
- [repo GIT](https://github.com/decodableco/examples/tree/main/flink-learn/2-kafka-upsert)
- [Upsert Kafka SQL Connector](https://nightlies.apache.org/flink/flink-docs-master/docs/connectors/table/upsert-kafka/)
- [Postgres CDC Connector](https://nightlies.apache.org/flink/flink-cdc-docs-release-3.1/docs/connectors/flink-sources/postgres-cdc/)


```sql
-- register a PostgreSQL table 'shipments' in Flink SQL
CREATE TABLE shipments (
  shipment_id INT,
  order_id INT,
  origin STRING,
  destination STRING,
  is_arrived BOOLEAN
) WITH (
  'connector' = 'postgres-cdc',
  -- ajustado para capturar o docker - by FK
  'hostname' = 'host.docker.internal',
  'port' = '5432',
  'username' = 'postgres',
  'password' = 'pwd',
  'database-name' = 'study',
  'schema-name' = 'public',
  'table-name' = 'shipments',
  'slot.name' = 'flink',
   -- experimental feature: incremental snapshot (default off)
  'scan.incremental.snapshot.enabled' = 'true'
);

-- read snapshot and binlogs from shipments table
SELECT * FROM shipments;
```