-- Crear base de datos si no existe
CREATE DATABASE IF NOT EXISTS branch_trace;
USE branch_trace;

-- Crear tabla en Hive para almacenar el dataset
CREATE TABLE IF NOT EXISTS dataset (
    branch_addr STRING,
    branch_type STRING,
    taken INT,
    target STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE;

-- Cargar datos desde HDFS a la tabla Hive
LOAD DATA INPATH 'hdfs:///user/hdoop/dataset/branch_trace_clean.csv' INTO TABLE dataset;

