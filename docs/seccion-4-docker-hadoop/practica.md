# Practice 4: Hadoop + Hive Stack

## Start the stack

Open a terminal, navigate to the root directory of the repository, and run:

```bash
docker-compose up -d
```

## Check in Docker Desktop that the services are running

In Docker Desktop, open the main interface and confirm the services are running.

Within each service, you can view logs, environment variables, and files.

## View the main Hadoop interface

Open a browser and go to [http://localhost:9870](http://localhost:9870).

Check the number of datanodes in the cluster.

## Stop the stack

Stop the stack with:

```bash
docker-compose stop
```

## Add a new datanode

Edit the `docker-compose.yml` file and, below the `datanode-2` service, add the following:

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

## Start the stack

Restart the stack with:

```bash
docker-compose start
```

## View the main Hadoop interface

Open a browser and go to [http://localhost:9870](http://localhost:9870).

Check the number of datanodes in the cluster.

## Stop the stack

Stop the stack with:

```bash
docker-compose stop
```
