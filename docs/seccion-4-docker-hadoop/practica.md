# Práctica 4. Stack de Hadoop + Hive

## Arrancar el stack

Abrir un terminal y posicionarnos en el directorio raíz del repositorio. Lanzamos un:

```bash
docker-compose up -d
```

## Comprobar en Docker Desktop que los servicios están corriendo

En Docker Desktop, abrimos el interfaz principal y vemos los servicios corriendo.

Dentro de cada servicio podemos ver los logs, las variables de entorno y los archivos.

## Ver la interfaz principal de Hadoop

Abrimos un navegador y vamos a: (http://localhost:9870)[http://localhost:9870].

Comprobar el numero de datanodes que tiene el cluster.

## Parar el Stack

Paramos el stack con:

```bash
docker-compose stop
```

## Añadimos un nuevo datanode

Hay que editar el archivo `docker-compose.yml` y debajo del servicio `datanode-2` añadimos:

```bash
datanode-3:
  image: timveil/docker-hadoop-datanode:3.2.x
  container_name: datanode-3
  hostname: datanode-3
  environment:
    - SERVICE_PRECONDITION=namenode:9870
  env_file:
    - ./conf/core.env
    - ./conf/yarn-remote.env
  ports:
    - "9866:9864"
  networks:
    - hadoop_network
```

## Arrancar el Stack

Paramos el stack con:

```bash
docker-compose start
```

## Ver la interfaz principal de Hadoop

Abrimos un navegador y vamos a: (http://localhost:9870)[http://localhost:9870].

Comprobar el numero de datanodes que tiene el cluster.

## Parar el Stack

Paramos el stack con:

```bash
docker-compose stop
```