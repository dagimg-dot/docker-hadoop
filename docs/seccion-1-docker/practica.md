# Práctica 1. Creación de Imagen con Dockerfile

## Crear el Dockerfile

Crear un archivo `Dockerfile` con el siguiente contenido:

```bash
FROM nginx:alpine
COPY ./index.html /usr/share/nginx/html
EXPOSE 80
```

## Crear la imagen

En la ruta donde está el  `Dockerfile` anterior, ejecutar:

```bash
docker build -t mi_servidor:1.0 .
```

Ojo, el . del final es importante.

## Crear el contenedor

Ahora con la imagen creada, ejecutamos un contenedor. Para ello en esa ruta tecleamos:

```bash
docker run -p 80:80 mi_servidor:1.0
```

Veremos el log del contenedor y se quedará el proceso corriendo, para salir, pulsamos Ctrl+C

## Crear el contenedor (detached)

Si no queremos que nos bloquee la terminal, podemos correr el contenedor en segundo plano, para ello añadimos el -d

```bash
docker run -d -p 80:80 mi_servidor:1.0
```

Ahora la terminal no se queda ocupada.

## Ver los contenedores corriendo

Para ver una lista de contenedores corriendo, introducimos:

```bash
docker ps
```

## Parar un contenedor

Para finalizar la ejecución de un contenedor, lo hacemos con:

```bash
docker stop <CONTAINER_ID> | <CONTAINER_NAME>
```