# Práctica 2. Correr un contenedor con imagen de Docker Hub.

## Arrancar el contenedor

En una terminal, lanzamos el siguiente comando:

```bash
docker run ubuntu
```

Veremos como en el primer arranque, al no existir la imagen en local, se descarga automáticamente desde Docker Hub.

## Comprobar contenedores en ejecución

Si lanzamos el siguiente comando:

```bash
docker ps
```

Veremos que no hay contenedores en ejecución. ¿Por que?

## Arrancar el contenedor en modo interactivo

Ahora vamos a volver a arrancar el contenedor de antes, pero añadimos `-it` delante.

```bash
docker run -it ubuntu
```

Nos cambiará el prompt del terminal. ¿Dónde estamos?

## Comprobar contenedores activos

Sin tocar nada más, abrimos un terminal paralelo y lanzamos:

```bash
docker ps
```

Ahora si debe salir el contenedor de ubuntu en ejecución.

## Podemos ver que estamos dentro de un Linux

En la terminal con el prompt de Linux, lanzamos un:

```bash
cat /etc/os_release
```

Podemos ver que efectivamente estamos dentro de un Linux.

## Terminamos la ejecución con exit.

Para finalizar la sesión de Linux, tecleamos en esa terminal

```bash
exit
```

## Comprobar contenedores activos

En el terminal paralelo, si comprobamos los contenedores en ejecución, ahora no tendremos nada.

```bash
docker ps
```