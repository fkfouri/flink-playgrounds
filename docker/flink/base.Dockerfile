FROM apache/flink:1.18-scala_2.12-java11 

RUN wget -P /opt/flink/lib \
    https://repo.maven.apache.org/maven2/org/apache/flink/flink-sql-connector-kafka/3.2.0-1.18/flink-sql-connector-kafka-3.2.0-1.18.jar 


# RUN mkdir /opt/flink/usrlib/ && \
#     wget https://repo.maven.apache.org/maven2/org/apache/flink/flink-sql-connector-kafka/3.2.0-1.18/flink-sql-connector-kafka-3.2.0-1.18.jar \
#     -O /opt/flink/usrlib/flink-sql-connector-kafka-3.2.0-1.18.jar


# RUN mkdir /opt/flink/plugins/kakfa && \
#     wget https://repo.maven.apache.org/maven2/org/apache/flink/flink-sql-connector-kafka/3.2.0-1.18/flink-sql-connector-kafka-3.2.0-1.18.jar \
#     -O /opt/flink/plugins/kakfa/flink-sql-connector-kafka-3.2.0-1.18.jar


# FROM flink:1.17.0-scala_2.12-java11

# RUN wget -P /opt/flink/lib \
#     https://repo1.maven.org/maven2/org/apache/flink/flink-sql-connector-kafka/1.17.0/flink-sql-connector-kafka-1.17.0.jar



WORKDIR /opt/flink

RUN apt-get update && \
    apt-get install -y python3-pip python-is-python3

RUN pip3 install apache-flink 