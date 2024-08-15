# Estudo 2

Neste estudo sendo utilizado o Flink Kafka e Kafka Upsert Demo

- [![Youtube](https://img.youtube.com/vi/1ezf3OyLz3w/mqdefault.jpg)](https://youtu.be/1ezf3OyLz3w)
- [repo GIT](https://github.com/decodableco/examples/tree/main/flink-learn/2-kafka-upsert)
- [Postgres CDC Connector](https://nightlies.apache.org/flink/flink-cdc-docs-release-3.1/docs/connectors/flink-sources/postgres-cdc/)
- [Upsert Kafka SQL Connector](https://nightlies.apache.org/flink/flink-docs-master/docs/connectors/table/upsert-kafka/)



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
![alt text](image-1.png)


O Comando a seguir é para a execução no diretamente no Postgres.
```sql
INSERT INTO public.shipments
(shipment_id, order_id, origin, destination, is_arrived)
VALUES(nextval('shipments_shipment_id_seq'::regclass), nextval('shipments_order_id_seq'::regclass), 'Santos', 'Salvador', false);


UPDATE public.shipments
SET origin='Rio Grande', destination='Panama', is_arrived=false
WHERE shipment_id=1004;

DELETE from public.shipments
WHERE shipment_id=1004;
```

> Observe o mecanismo de changelog. Apareceu Insert, Update e Delete (coluna 1)
![alt text](image-2.png)


> Quando tentei inserir pelo SQL Flink obtive o seguinte erro.

![alt text](image.png)

## Propagando Dados do Flink para o Kafka

```sql
CREATE TABLE shipments_output_upsert (
  shipment_id INT,
  order_id INT,
  origin STRING,
  destination STRING,
  is_arrived BOOLEAN,
  db_name STRING,
  operation_ts TIMESTAMP_LTZ(3),
  PRIMARY KEY (shipment_id) NOT ENFORCED
 )
WITH (
  'connector' = 'upsert-kafka',
  'topic' = 'shipments',
  'properties.bootstrap.servers' = 'redpanda:29092',
  'key.format' = 'json', 'value.format' = 'json'
);
```


