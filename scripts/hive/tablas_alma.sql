-- Crear tabla para conteo de branch_type
CREATE TABLE IF NOT EXISTS branch_type_counts (
    branch_type STRING,
    count BIGINT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE;

-- Crear tabla para relación de branch_type y taken
CREATE TABLE IF NOT EXISTS branch_type_taken_relation (
    branch_type STRING,
    taken INT,
    count BIGINT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE;

-- Crear tabla para proporción de taken por branch_type
CREATE TABLE IF NOT EXISTS branch_type_taken_proportion (
    branch_type STRING,
    total_records BIGINT,
    proportion_taken DOUBLE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE;