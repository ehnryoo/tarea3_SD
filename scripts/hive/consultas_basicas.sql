-- Consultas HiveQL para operaciones estadísticas básicas
-- 1. Obtener el número total de registros en el dataset
SELECT COUNT(*) AS total_records FROM dataset;

-- 2. Contar la frecuencia de cada tipo de branch_type
SELECT branch_type, COUNT(*) AS frequency FROM dataset GROUP BY branch_type;

-- 3. Calcular la proporción de registros con taken igual a 1 por cada tipo de branch_type
SELECT branch_type, SUM(CASE WHEN taken = 1 THEN 1 ELSE 0 END) / COUNT(*) AS proportion_taken FROM dataset GROUP BY branch_type;
-- Insertar resultados de conteo de branch_type en Hive
INSERT INTO TABLE branch_type_counts
SELECT * FROM branch_type_counts_pig;

-- Insertar resultados de relación branch_type y taken en Hive
INSERT INTO TABLE branch_type_taken_relation
SELECT * FROM branch_type_taken_count;

-- Insertar resultados de proporción de taken por branch_type en Hive
INSERT INTO TABLE branch_type_taken_proportion
SELECT * FROM branch_type_taken_proportion_pig;