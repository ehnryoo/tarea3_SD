sample_data = SAMPLE DATA 0.1;

-- Contar el número de filas
row_count = FOREACH (GROUP data ALL) GENERATE COUNT_STAR(data);

-- Filtrar las filas donde branch_type es 'conditional_jump'
filtered_data = FILTER data BY branch_type == 'conditional_jump';

-- Agrupar por branch_type y contar el número de elementos en cada grupo
grouped_data = GROUP data BY branch_type;
count_per_group = FOREACH grouped_data GENERATE group, COUNT(data);

-- Agrupar todos los datos para calcular el promedio
grouped_data = GROUP data ALL;
average_taken = FOREACH grouped_data GENERATE AVG(data.taken);

-- Ordenar los datos por branch_addr
sorted_data = ORDER data BY branch_addr;

-- Filtrar las filas donde branch_type es 'conditional_jump' y taken es 1
filtered_data = FILTER data BY branch_type == 'conditional_jump' AND taken == 1;

-- Contar el número de saltos condicionales tomados
taken_count = FOREACH (GROUP filtered_data ALL) GENERATE COUNT_STAR(filtered_data);