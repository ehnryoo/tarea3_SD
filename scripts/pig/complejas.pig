-- Script PigLatin para transformaciones más complejas
-- Calcular la relación entre branch_type y taken
BRANCH_TYPE_TAKEN_RELATION = GROUP DATA BY (branch_type, taken);
BRANCH_TYPE_TAKEN_COUNT = FOREACH BRANCH_TYPE_TAKEN_RELATION GENERATE group.branch_type AS branch_type, group.taken AS taken, COUNT(DATA) AS frequency;
STORE BRANCH_TYPE_TAKEN_COUNT INTO '/user/hdoop/results/branch_type_taken_count' USING PigStorage(',');

-- Agrupar por tipo de rama y por si se tomó o no
grouped_data = GROUP data BY (branch_type, taken);

-- Contar el número de ocurrencias para cada grupo
count_per_group = FOREACH grouped_data GENERATE FLATTEN(group) AS (branch_type, taken), COUNT(data) AS count;

-- Filtrar para obtener solo los saltos condicionales
conditional_jumps = FILTER data BY branch_type == 'conditional_jump';

-- Agrupar por si se tomó o no y contar
grouped_conditional = GROUP conditional_jumps BY taken;
count_conditional = FOREACH grouped_conditional GENERATE group AS taken, COUNT(conditional_jumps) AS count;

-- Obtener el total de saltos condicionales
total_conditional = FOREACH (GROUP conditional_jumps ALL) GENERATE COUNT(conditional_jumps) AS total;

-- Unir los conteos con el total para calcular el porcentaje
joined_data = JOIN count_conditional BY 1, total_conditional BY 1;
percentage = FOREACH joined_data GENERATE count_conditional::taken, (count_conditional::count / total_conditional::total) * 100 AS percentage;
