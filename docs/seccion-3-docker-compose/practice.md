# Practice 3: Creating a Stack with Docker Compose

## Create the environment file

Create a `.env` file with the following content:

```bash
# Docker
COMPOSE_PROJECT_NAME=mongo-stack

# MongoDB
MONGODB_ROOT_USER=root
MONGODB_ROOT_PASS=pass
MONGODB_USER=user
MONGODB_PASS=pass
```

## Create the `docker-compose.yml` file

Create a `docker-compose.yml` file in the same directory as the `.env` file.

### Add the MongoDB image

Edit the file and add the following:

```bash
services:

  mongodb:
    image: mongo:5.0
    container_name: "${COMPOSE_PROJECT_NAME}-mongodb"
    environment:
        - MONGO_INITDB_ROOT_USERNAME=${MONGODB_USER}
        - MONGO_INITDB_ROOT_PASSWORD=${MONGODB_PASS}
    restart: unless-stopped
    ports:
      - "27017:27017"
    volumes:
      - ./data/mongodb:/data
```

In that directory, run the following command:

```bash
docker-compose up -d
```

Now we have a MongoDB server running on our machine.

### Add Mongo Express

Next, edit the `docker-compose.yml` file again and add the following section below the MongoDB service:

```bash
  mongo-express:
    container_name: "${COMPOSE_PROJECT_NAME}-mongoexpress"
    image: mongo-express:latest
    ports:
      - "8081:8081"
    links:
      - mongodb
    environment:
      ME_CONFIG_BASICAUTH_PASSWORD: ${MONGODB_PASS}
      ME_CONFIG_BASICAUTH_USERNAME: ${MONGODB_USER}
      ME_CONFIG_MONGODB_ADMINPASSWORD: ${MONGODB_PASS}
      ME_CONFIG_MONGODB_ADMINUSERNAME: ${MONGODB_USER}
      ME_CONFIG_MONGODB_URL: "mongodb://${MONGODB_USER}:${MONGODB_PASS}@mongodb:27017/?authSource=admin"
```

In the same directory, run the following command:

```bash
docker-compose up -d
```

Now we have a MongoDB server running on our machine. Additionally, if we navigate to [http://localhost:8081](http://localhost:8081) and log in with `user` and `pass`, we will see a simple administration interface.
