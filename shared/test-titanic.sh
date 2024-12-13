#!/bin/bash

# Variables
HIVE_SERVER="localhost:10000/default"
DATABASE_NAME="titanic_db"
TABLE_NAME="titanic_passengers"
CSV_LOCATION="/test-hive/titanic.csv"

# Creamos directorios en HDFS
hadoop fs -mkdir /test-hive

# Subimos archivo CSV a HDFS
hadoop fs -put /shared/input/test-titanic.csv /test-hive/

# Comandos SQL para Hive
HIVE_SCRIPT=$(cat <<EOF

CREATE DATABASE IF NOT EXISTS ${DATABASE_NAME};

USE ${DATABASE_NAME};

CREATE EXTERNAL TABLE IF NOT EXISTS ${TABLE_NAME} (
    PassengerId INT,
    Survived INT,
    Pclass INT,
    Name STRING,
    Sex STRING,
    Age FLOAT,
    SibSp INT,
    Parch INT,
    Ticket STRING,
    Fare FLOAT,
    Cabin STRING,
    Embarked STRING
)

ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
    "separatorChar" = ",",
    "quoteChar" = "\""
)
TBLPROPERTIES (
    "skip.header.line.count"="1"
);

LOAD DATA INPATH '/test-hive/test-titanic.csv' INTO TABLE ${TABLE_NAME};

EOF
)

# Ejecutamos el script de Hive
beeline -u "jdbc:hive2://${HIVE_SERVER}" -e "${HIVE_SCRIPT}"
