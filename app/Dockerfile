FROM python:3.9-slim-buster

# Instalar dependencias del sistema
RUN apt-get update && \
    apt-get install -y wget openjdk-11-jdk curl

# Instalar Hive
RUN wget https://downloads.apache.org/hive/hive-3.1.2/apache-hive-3.1.2-bin.tar.gz && \
    tar -xzf apache-hive-3.1.2-bin.tar.gz && \
    mv apache-hive-3.1.2-bin /opt/hive

# Configurar variables de entorno para Hive
ENV HIVE_HOME=/opt/hive
ENV PATH=$HIVE_HOME/bin:$PATH

# Instalar Hadoop Client
RUN wget https://downloads.apache.org/hadoop/common/hadoop-3.3.1/hadoop-3.3.1.tar.gz && \
    tar -xzf hadoop-3.3.1.tar.gz && \
    mv hadoop-3.3.1 /opt/hadoop

# Configurar variables de entorno para Hadoop
ENV HADOOP_HOME=/opt/hadoop
ENV PATH=$HADOOP_HOME/bin:$PATH

# Copiar los archivos de la API al contenedor
WORKDIR /app
COPY . /app

# Instalar dependencias de Python
RUN pip install -r requirements.txt

# Exponer el puerto de la API
EXPOSE 5000

# Comando para iniciar la API
CMD ["python", "app.py"]
