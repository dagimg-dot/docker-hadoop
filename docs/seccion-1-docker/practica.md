# Práctica

## Crear el Dockerfile

Crear un archivo `Dockerfile` con el siguiente contenido:

```
FROM nginx:alpine
COPY ./index.html /usr/share/nginx/html
EXPOSE 80
```

## Crear la imagen

En la ruta donde está el  `Dockerfile` anterior, ejecutar:

```
docker build -t mi_servidor:1.0 .
```

Ojo, el . del final es importante.

## Crear el contenedor

Ahora con la imagen creada, ejecutamos un contenedor. Para ello en esa ruta tecleamos:

```
docker run -p 80:80 mi_servidor:1.0
```

Veremos el log del contenedor y se quedará el proceso corriendo, para salir, pulsamos Ctrl+C

## Crear el contenedor (detached)

Si no queremos que nos bloquee la terminal, podemos correr el contenedor en segundo plano, para ello añadimos el -d

```
docker run -d -p 80:80 mi_servidor:1.0
```

Ahora la terminal no se queda ocupada.

## Ver los contenedores corriendo

Para ver una lista de contenedores corriendo, introducimos:

```
docker ps
```

## Terminar un contenedor

Para finalizar la ejecución de un contenedor, lo hacemos con:

```
docker stop <CONTAINER_ID> | <CONTAINER_NAME>
```
