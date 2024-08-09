FROM apache/flink:1.18-scala_2.12-java11 

WORKDIR /opt/flink

RUN mkdir /opt/flink/usrlib/ && \
    wget https://repo.maven.apache.org/maven2/org/apache/flink/flink-sql-connector-kafka/3.2.0-1.18/flink-sql-connector-kafka-3.2.0-1.18.jar \
    -O /opt/flink/usrlib/flink-sql-connector-kafka-3.2.0-1.18.jar
