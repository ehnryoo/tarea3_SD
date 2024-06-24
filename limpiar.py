import pandas as pd
import glob

# Ruta a los archivos CSV
files = glob.glob('./data/*.csv')

# Limpiar cada archivo
for file in files:
    # Leer el archivo CSV
    df = pd.read_csv(file)
    
    # Realizar limpieza básica
    df.dropna(inplace=True)  # Eliminar filas con valores nulos
    df.drop_duplicates(inplace=True)  # Eliminar filas duplicadas
    
    # Guardar el archivo limpio
    clean_file = file.replace('.csv', '_clean.csv')
    df.to_csv(clean_file, index=False)
    print(f"Archivo limpio guardado como {clean_file}")
