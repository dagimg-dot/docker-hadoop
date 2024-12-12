#!/bin/bash

# Variables
HIVE_SERVER="localhost:10000/default"
DATABASE_NAME="sales_db"
TABLE_NAME="sales_data"
CSV_LOCATION="/test-hive/test-hive.csv"

# Creamos directorios
hadoop fs -mkdir /test-hive

# Subimos archivo
hadoop fs -put /shared/input/test-hive.csv /test-hive/

# Comandos SQL para Hive
HIVE_SCRIPT=$(cat <<EOF

CREATE DATABASE IF NOT EXISTS ${DATABASE_NAME};

USE ${DATABASE_NAME};

CREATE EXTERNAL TABLE IF NOT EXISTS ${TABLE_NAME} (
    transaction_id INT,
    customer_name STRING,
    product STRING,
    quantity INT,
    price FLOAT,
    transaction_date DATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';

LOAD DATA INPATH '/test-hive/test-hive.csv' INTO TABLE sales_data;

EOF
)

# Creamos tabla en Hive
beeline -u "jdbc:hive2://${HIVE_SERVER}" -e "${HIVE_SCRIPT}"