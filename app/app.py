from flask import Flask, request, jsonify
from pyhive import hive
import subprocess
import os

app = Flask(__name__)

# Configuración de Hive
hive_host = 'localhost'  # Cambia esto si tu servidor Hive está en otra dirección
hive_port = 10000
hive_database = 'default'

# Función para ejecutar comandos de Hive
def execute_hive_query(query):
    conn = hive.connect(host=hive_host, port=hive_port, database=hive_database)
    cursor = conn.cursor()
    cursor.execute(query)
    result = cursor.fetchall()
    cursor.close()
    conn.close()
    return result

# Endpoint para subir y ejecutar un script de Pig
@app.route('/upload_pig_script', methods=['POST'])
def upload_pig_script():
    if 'file' not in request.files:
        return jsonify({"error": "No file part"}), 400
    file = request.files['file']
    if file.filename == '':
        return jsonify({"error": "No selected file"}), 400
    if file:
        script_path = os.path.join('/app/uploads', file.filename)
        file.save(script_path)
        result = subprocess.run(['pig', script_path], capture_output=True, text=True)
        return jsonify({"output": result.stdout, "error": result.stderr})

# Endpoint para ejecutar una consulta de Hive
@app.route('/hive_query', methods=['POST'])
def hive_query():
    query = request.json['query']
    result = execute_hive_query(query)
    return jsonify({"result": result})

# Endpoint para ejecutar un script de Pig
@app.route('/pig_script', methods=['POST'])
def pig_script():
    if 'script' not in request.json:
        return jsonify({"error": "No script provided"}), 400
    
    pig_script = request.json['script']
    
    # Guardar el script en un archivo temporal (opcional)
    script_path = '/app/uploads/script.pig'  # Ruta donde se guardará el script
    with open(script_path, 'w') as f:
        f.write(pig_script)
    
    # Ejecutar el script de Pig
    result = subprocess.run(['pig', script_path], capture_output=True, text=True)
    
    # Retornar el resultado de la ejecución
    return jsonify({"output": result.stdout, "error": result.stderr})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
