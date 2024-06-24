-- Cargar datos desde HDFS
data = LOAD '/user/yourusername/dataset/dataset.csv' USING PigStorage(',') AS (branch_addr:chararray, branch_type:chararray, taken:int, target:chararray);

-- Contar la frecuencia de cada tipo de branch_type
branch_type_counts = FOREACH (GROUP data BY branch_type) {
    generate group AS branch_type, COUNT(data) AS count;
};

-- Ordenar los resultados por frecuencia (descendente)
sorted_branch_type_counts = ORDER branch_type_counts BY count DESC;

-- proporción de registros con taken igual a 1 para cada tipo de branch_type.
branch_type_taken_proportion = FOREACH (GROUP data BY branch_type) {
    GENERATE group AS branch_type, 
             COUNT(data) AS total_records, 
             (double)SUM(data.taken == 1 ? 1 : 0) / COUNT(data) AS proportion_taken;
};

-- Almacenar resultados en HDFS
STORE sorted_branch_type_counts INTO '/user/yourusername/results/sorted_branch_type_counts' USING PigStorage(',');
