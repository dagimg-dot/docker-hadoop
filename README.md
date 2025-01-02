# INTRODUCTION

This repository contains a `docker-compose.yml` file that deploys a complete Hadoop cluster using Docker containers. Below, the included services, their purposes, and configurations are explained.

- [INTRODUCTION](#introduction)
- [How to Use This File](#how-to-use-this-file)
- [Services](#services)
  - [1. **Namenode**](#1-namenode)
  - [2. **Datanode-1**](#2-datanode-1)
  - [3. **Datanode-2**](#3-datanode-2)
  - [4. **ResourceManager**](#4-resourcemanager)
  - [5. **NodeManager**](#5-nodemanager)
  - [6. **HistoryServer**](#6-historyserver)
  - [7. **HiveServer**](#7-hiveserver)
  - [8. **Metastore**](#8-metastore)
  - [9. **Metastore DB**](#9-metastore-db)
- [TESTING](#testing)
  - [Running Mapreduce](#running-mapreduce)
  - [Running Hive](#running-hive)
- [TO-DO](#to-do)
- [Credits](#credits)
- [Links](#links)
  - [Building Docker Images](#building-docker-images)
  - [Hadoop Ports](#hadoop-ports)
    - [Step by Step](#step-by-step)
  - [Complete Course](#complete-course)

# How to Use This File

1. Clone the repository and navigate to the directory where the `docker-compose.yml` file is located.
2. Ensure that the configuration files (`.env`) mentioned are correctly configured in the `./conf` directory.
3. Start the containers:
   ```bash
   docker-compose up -d
   ```
4. Check the status of the services by accessing the exposed ports via your browser:

   - **Namenode**: [http://localhost:9870](http://localhost:9870)
   - **Datanode-1**: [http://localhost:9864](http://localhost:9864)
   - **Datanode-2**: [http://localhost:9865](http://localhost:9865)
   - **ResourceManager**: [http://localhost:8088](http://localhost:8088)
   - **NodeManager**: [http://localhost:8042](http://localhost:8042)
   - **HistoryServer**: [http://localhost:8188](http://localhost:8188)
   - **HiveServer**: [http://localhost:10000](http://localhost:10000) (and also at [http://localhost:10002](http://localhost:10002))

You can also run:

```bash
docker-compose ps
```

to see something like this:

```bash
NAME              IMAGE                                           COMMAND                  SERVICE           CREATED          STATUS                    PORTS
datanode-1        timveil/docker-hadoop-datanode:3.2.x            "/entrypoint.sh /run…"   datanode-1        13 minutes ago   Up 13 minutes (healthy)   0.0.0.0:9864->9864/tcp
datanode-2        timveil/docker-hadoop-datanode:3.2.x            "/entrypoint.sh /run…"   datanode-2        13 minutes ago   Up 13 minutes (healthy)   0.0.0.0:9865->9864/tcp
historyserver     timveil/docker-hadoop-historyserver:3.2.x       "/entrypoint.sh /run…"   historyserver     13 minutes ago   Up 13 minutes (healthy)   0.0.0.0:8188->8188/tcp
hiveserver        timveil/docker-hadoop-hive-hs2:3.1.x            "/entrypoint.sh /run…"   hiveserver        13 minutes ago   Up 13 minutes             0.0.0.0:10000->10000/tcp, 0.0.0.0:10002->10002/tcp
metastore         timveil/docker-hadoop-hive-metastore:3.1.x      "/entrypoint.sh /run…"   metastore         13 minutes ago   Up 13 minutes             10000/tcp, 10002/tcp
metastore-db      timveil/docker-hadoop-hive-metastore-db:3.1.x   "docker-entrypoint.s…"   metastore-db      13 minutes ago   Up 13 minutes             0.0.0.0:5432->5432/tcp
namenode          timveil/docker-hadoop-namenode:3.2.x            "/entrypoint.sh /run…"   namenode          13 minutes ago   Up 13 minutes (healthy)   0.0.0.0:9870->9870/tcp
nodemanager       timveil/docker-hadoop-nodemanager:3.2.x         "/entrypoint.sh /run…"   nodemanager       13 minutes ago   Up 13 minutes (healthy)   0.0.0.0:8042->8042/tcp
resourcemanager   timveil/docker-hadoop-resourcemanager:3.2.x     "/entrypoint.sh /run…"   resourcemanager   13 minutes ago   Up 13 minutes (healthy)   0.0.0.0:8088->8088/tcp
```

It is important that the `namenode`, `datanode`, and `resourcemanager` services are working correctly before running tasks on the cluster.

# Services

## 1. **Namenode**
- **Image:** `timveil/docker-hadoop-namenode:3.2.x`
- **Description:**
  - The NameNode is the master of the Hadoop cluster. It manages the distributed file system (HDFS) and maintains the hierarchical directory of files.
- **Exposed Ports:**
  - `9870`: Web interface for HDFS monitoring.
- **Volumes:**
  - `./shared:/shared`: Shared folder between services.
- **Environment Variables:**
  - `CLUSTER_NAME`: Cluster name.
  - Configuration files: `core.env`, `yarn-remote.env`.
- **URL:**
  - [http://localhost:9870](http://localhost:9870)

---

## 2. **Datanode-1**
- **Image:** `timveil/docker-hadoop-datanode:3.2.x`
- **Description:**
  - The DataNode stores the HDFS data blocks and performs data read and write operations.
- **Exposed Ports:**
  - `9864`: Port for communication with the NameNode.
- **Volumes:**
  - No exposed volumes.
- **Environment Variables:**
  - `SERVICE_PRECONDITION`: Indicates that the NameNode must be available.
  - Configuration files: `core.env`, `yarn-remote.env`.
- **URL:**
  - [http://localhost:9864](http://localhost:9864)

---

## 3. **Datanode-2**
- **Image:** `timveil/docker-hadoop-datanode:3.2.x`
- **Description:**
  - Similar to DataNode-1, this node stores data blocks and performs read and write operations in HDFS.
- **Exposed Ports:**
  - `9865`: Port for communication with the NameNode.
- **Volumes:**
  - No exposed volumes.
- **Environment Variables:**
  - `SERVICE_PRECONDITION`: Indicates that the NameNode must be available.
  - Configuration files: `core.env`, `yarn-remote.env`.
- **URL:**
  - [http://localhost:9865](http://localhost:9865)

---

## 4. **ResourceManager**
- **Image:** `timveil/docker-hadoop-resourcemanager:3.2.x`
- **Description:**
  - The ResourceManager manages computing resources in the Hadoop cluster and coordinates the execution of applications on the cluster.
- **Exposed Ports:**
  - `8088`: Web interface for monitoring and managing jobs in YARN.
- **Volumes:**
  - No exposed volumes.
- **Environment Variables:**
  - `SERVICE_PRECONDITION`: Indicates that the NameNode and DataNodes must be available.
  - Configuration files: `core.env`, `yarn-resource-manager.env`.
- **URL:**
  - [http://localhost:8088](http://localhost:8088)

---

## 5. **NodeManager**
- **Image:** `timveil/docker-hadoop-nodemanager:3.2.x`
- **Description:**
  - The NodeManager runs on each worker node and manages local resources and application execution on that node.
- **Exposed Ports:**
  - `8042`: Web interface for monitoring container status in YARN.
- **Volumes:**
  - No exposed volumes.
- **Environment Variables:**
  - `SERVICE_PRECONDITION`: Indicates that the NameNode, DataNodes, and ResourceManager must be available.
  - Configuration files: `core.env`, `yarn-node-manager.env`.
- **URL:**
  - [http://localhost:8042](http://localhost:8042)

---

## 6. **HistoryServer**
- **Image:** `timveil/docker-hadoop-historyserver:3.2.x`
- **Description:**
  - The HistoryServer allows viewing information about past jobs in the Hadoop cluster.
- **Exposed Ports:**
  - `8188`: Web interface to view the job history in YARN.
- **Volumes:**
  - No exposed volumes.
- **Environment Variables:**
  - `SERVICE_PRECONDITION`: Indicates that the NameNode, DataNodes, and ResourceManager must be available.
  - Configuration files: `core.env`, `yarn-timeline.env`.
- **URL:**
  - [http://localhost:8188](http://localhost:8188)

---

## 7. **HiveServer**
- **Image:** `timveil/docker-hadoop-hive-hs2:3.1.x`
- **Description:**
  - HiveServer2 allows interaction with Apache Hive to execute SQL queries on Hadoop.
- **Exposed Ports:**
  - `10000`: Port for the HiveServer2 interface.
  - `10002`: Port for the HiveServer2 interface (can be used by clients from different applications).
- **Volumes:**
  - `./shared:/shared`: Shared folder between services.
- **Environment Variables:**
  - `SERVICE_PRECONDITION`: Indicates that the metastore must be available.
  - Configuration files: `core.env`, `yarn-remote.env`, `hive.env`.
- **URL:**
  - [http://localhost:10000](http://localhost:10000) and [http://localhost:10002](http://localhost:10002)

---

## 8. **Metastore**
- **Image:** `timveil/docker-hadoop-hive-metastore:3.1.x`
- **Description:**
  - The Hive Metastore stores metadata for Hive tables and databases.
- **Exposed Ports:**
  - No direct HTTP ports exposed.
- **Volumes:**
  - `./shared:/shared`: Shared folder between services.
- **Environment Variables:**
  - `SERVICE_PRECONDITION`: Indicates that the NameNode, DataNodes, and Metastore DB must be available.
  - Configuration files: `core.env`, `yarn-remote.env`, `hive.env`, `metastore.env`.
- **URL:**
  - No direct web link exposed.

---

## 9. **Metastore DB**
- **Image:** `timveil/docker-hadoop-hive-metastore-db:3.1.x`
- **Description:**
  - The Metastore database stores metadata for Hive.
- **Exposed Ports:**
  - `5432`: Port for the PostgreSQL database.
- **Volumes:**
  - `./shared:/shared`: Shared folder between services.
- **Environment Variables:**
  - No specific web interface environment variables.
- **URL:**
  - No direct web link exposed.

---

# TESTING

## Running Mapreduce

Connected to the ResourceManager:

```bash
# Navigate to the shared directory
cd /shared
# Grant execution permissions to the file
chmod +x test-mapreduce.sh
# Run the file
./test-mapreduce.sh
```

## Running Hive

Connected to the HiveServer:

```bash
# Navigate to the shared directory
cd /shared
# Grant execution permissions to the file
chmod +x test-mapreduce.sh
# Run the file
./test-mapreduce.sh
```

---

# TO-DO

The previous stack has pending improvement points:

- Update Hadoop, Java, Hive versions.
- Add Spark.
- Persist data.

---

# Credits
This cluster uses Docker images maintained by [Tim Veil](https://hub.docker.com/u/timveil).

---

# Links

## Building Docker Images

- https://desarrollofront.medium.com/las-10-instrucciones-imprescindibles-para-crear-un-dockerfile-bb439ff836d9

## Hadoop Ports:

- https://www.stefaanlippens.net/hadoop-3-default-ports.html

## Step by Step

- https://www.writecode.es/2019-02-25-cluster_hadoop_docker/
- https://www.writecode.es/2019-03-08-cluster-hadoop-hive-docker/
- https://www.writecode.es/2019-04-30-cluster-hadoop-spark-docker/

## Complete Course

- https://www.youtube.com/watch?v=CV_Uf3Dq-EU