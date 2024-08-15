# FROM postgres:11-alpine
FROM quay.io/debezium/example-postgres:2.7

ENV POSTGRES_USER=postgres \
    POSTGRES_DB=study \
    POSTGRES_PASSWORD=pwd

COPY init.sql /docker-entrypoint-initdb.d/
COPY conf/custom-postgresql.conf /etc/postgresql/postgresql.conf

RUN postgres -c config_file=/etc/postgresql/postgresql.conf
