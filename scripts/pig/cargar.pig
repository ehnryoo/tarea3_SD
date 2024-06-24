-- Cargar datos en Pig
DATA = LOAD '/user/hdoop/data/branch_trace_clean.csv' USING PigStorage(',') AS (branch_addr:chararray, branch_type:chararray, taken:int, target:chararray);

-- Visualizar una muestra de los datos
SAMPLE_DATA = LIMIT DATA 10;
DUMP SAMPLE_DATA;

-- Identificar patrones básicos (ejemplo de análisis)
-- Calcular la frecuencia de cada tipo de branch_type
BRANCH_TYPE_COUNT = FOREACH (GROUP DATA BY branch_type) GENERATE group AS branch_type, COUNT(DATA) AS frequency;
DUMP BRANCH_TYPE_COUNT;
