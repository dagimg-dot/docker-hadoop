# Práctica 3. Creación de Stack con Docker Compose

## Crear el archivo de entorno

Crear un archivo `.env` con el siguiente contenido:

```bash
# Docker
COMPOSE_PROJECT_NAME=mongo-stack

# MongoDB
MONGODB_ROOT_USER=root
MONGODB_ROOT_PASS=pass
MONGODB_USER=user
MONGODB_PASS=pass
```

## Crear el archivo docker-compose.yml

Creamos un archivo `docker-compose.yml` al mismo nivel que el archivo `.env` de antes.

### Añadir la imagen de MongoDB

Editamos el archivo anterior y añadimos:

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

En ese directorio, lanzamos:

```bash
docker-compose up -d
```

Ahora tenemos un servidor de MongoDB corriendo en nuestro equipo.

### Añadir Mongo Express

Ahora editamos el archivo anterior, y añadimos debajo del servicio anterior:

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

En ese directorio, lanzamos:

```bash
docker-compose up -d
```

Ahora tenemos un servidor de MongoDB corriendo en nuestro equipo y además si vamos a (http:localhost:8081)[http:localhost:8081] y nos identificamos con `user` y `pass`, veremos una interfaz sencilla de administración.