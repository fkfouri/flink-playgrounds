FROM maven:3.8-eclipse-temurin-17 AS builder

COPY ./java/ /opt/solution
WORKDIR /opt/solution
RUN mvn clean verify


###############################################################################
# Build Operations Playground Image
###############################################################################

# FROM apache/flink:1.16.0-scala_2.12-java11
# by FK
# FROM apache/flink:1.20-scala_2.12-java11 
# # FROM apache/flink:1.18-scala_2.12-java11 
# FROM apache/fk-flink-base

# WORKDIR /opt/flink/bin

# # Copy Click Count Job
# COPY --from=builder /opt/flink-playground-clickcountjob/target/flink-playground-clickcountjob-*.jar /opt/ClickCountJob.jar
