# Hadoop Cluster with Docker Compose

Este repositorio contiene un archivo `docker-compose.yml` que despliega un clúster Hadoop completo utilizando contenedores Docker. A continuación, se explican los servicios incluidos, sus propósitos y configuraciones.

## Servicios

### 1. **Namenode**
- **Imagen:** `timveil/docker-hadoop-namenode:3.2.x`
- **Descripción:**
  - El NameNode es el maestro del clúster Hadoop. Administra el sistema de archivos distribuido (HDFS) y mantiene el directorio jerárquico de archivos.
- **Puertos expuestos:**
  - `9870`: Interfaz web para monitoreo del HDFS.
- **Volúmenes:**
  - `./shared:/shared`: Carpeta compartida entre los servicios.
- **Variables de entorno:**
  - `CLUSTER_NAME`: Nombre del clúster.
  - Archivos de configuración: `core.env`, `yarn-remote.env`.

### 2. **Datanode-1**
- **Imagen:** `timveil/docker-hadoop-datanode:3.2.x`
- **Descripción:**
  - Los DataNodes almacenan los bloques de datos reales del HDFS.
- **Puertos expuestos:**
  - `9864`: Puerto para comunicaciones del DataNode.
- **Variables de entorno:**
  - `SERVICE_PRECONDITION`: Verifica que el NameNode esté disponible antes de iniciar.
  - Archivos de configuración: `core.env`, `yarn-remote.env`.

### 3. **Datanode-2**
- **Configuración similar a Datanode-1**, con la diferencia de que expone el puerto `9865:9864`.

### 4. **Resourcemanager**
- **Imagen:** `timveil/docker-hadoop-resourcemanager:3.2.x`
- **Descripción:**
  - Coordina la ejecución de trabajos en el clúster utilizando YARN (Yet Another Resource Negotiator).
- **Puertos expuestos:**
  - `8088`: Interfaz web del ResourceManager.
- **Variables de entorno:**
  - `SERVICE_PRECONDITION`: Verifica la disponibilidad de NameNode, DataNodes y otros servicios esenciales.
  - Archivos de configuración: `core.env`, `yarn-resource-manager.env`.

### 5. **Nodemanager**
- **Imagen:** `timveil/docker-hadoop-nodemanager:3.2.x`
- **Descripción:**
  - Gestiona los recursos y las tareas en nodos individuales del clúster.
- **Puertos expuestos:**
  - `8042`: Interfaz web del NodeManager.
- **Variables de entorno:**
  - `SERVICE_PRECONDITION`: Verifica la disponibilidad de servicios dependientes.
  - Archivos de configuración: `core.env`, `yarn-node-manager.env`.

### 6. **Historyserver**
- **Imagen:** `timveil/docker-hadoop-historyserver:3.2.x`
- **Descripción:**
  - Proporciona una interfaz para revisar los trabajos YARN completados.
- **Puertos expuestos:**
  - `8188`: Interfaz web del HistoryServer.
- **Variables de entorno:**
  - `SERVICE_PRECONDITION`: Verifica la disponibilidad de servicios dependientes.
  - Archivos de configuración: `core.env`, `yarn-timeline.env`.

### 7. **Hiveserver**
- **Imagen:** `timveil/docker-hadoop-hive-hs2:3.1.x`
- **Descripción:**
  - Proporciona un servicio SQL interactivo para ejecutar consultas sobre datos almacenados en Hadoop.
- **Puertos expuestos:**
  - `10000`: Puerto para clientes Hive.
  - `10002`: Puerto opcional para conexiones adicionales.
- **Volúmenes:**
  - `./shared:/shared`: Carpeta compartida para datos y configuraciones.
- **Variables de entorno:**
  - `SERVICE_PRECONDITION`: Verifica la disponibilidad del metastore.
  - Archivos de configuración: `core.env`, `yarn-remote.env`, `hive.env`.

### 8. **Metastore**
- **Imagen:** `timveil/docker-hadoop-hive-metastore:3.1.x`
- **Descripción:**
  - Gestiona el almacenamiento de metadatos para Hive.
- **Volúmenes:**
  - `./shared:/shared`: Carpeta compartida para configuraciones.
- **Variables de entorno:**
  - `SERVICE_PRECONDITION`: Verifica la disponibilidad de NameNode, DataNodes y Metastore DB.
  - Archivos de configuración: `core.env`, `yarn-remote.env`, `hive.env`, `metastore.env`.

### 9. **Metastore-DB**
- **Imagen:** `timveil/docker-hadoop-hive-metastore-db:3.1.x`
- **Descripción:**
  - Base de datos PostgreSQL para el almacenamiento de metadatos del Metastore.
- **Puertos expuestos:**
  - `5432`: Puerto para conexiones PostgreSQL.
- **Volúmenes:**
  - `./shared:/shared`: Carpeta compartida para persistencia.

## Red
- **Red:** `hadoop_network`
  - Tipo: `bridge`.
  - Todos los servicios comparten esta red para facilitar la comunicación interna.

## Cómo usar este archivo

1. Clona el repositorio y navega al directorio donde se encuentra el archivo `docker-compose.yml`.
2. Asegúrate de que los archivos de configuración mencionados (`.env`) estén correctamente configurados en el directorio `./conf`.
3. Inicia los contenedores:
   ```bash
   docker-compose up -d
   ```
4. Verifica el estado de los servicios accediendo a los puertos expuestos a través de tu navegador o herramientas CLI.

## Notas adicionales
- Es importante que los servicios `namenode`, `datanode`, y `resourcemanager` estén funcionando correctamente antes de ejecutar tareas en el clúster.
- Los volúmenes compartidos (`./shared`) permiten persistir datos entre reinicios de los contenedores.

## Créditos
Este clúster utiliza imágenes Docker mantenidas por [Tim Veil](https://hub.docker.com/u/timveil).

## Enlaces

- https://www.writecode.es/2019-02-25-cluster_hadoop_docker/
- https://www.writecode.es/2019-03-08-cluster-hadoop-hive-docker/
- https://www.writecode.es/2019-04-30-cluster-hadoop-spark-docker/