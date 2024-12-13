# Taller Introducción a Docker y Docker Compose

## ¿Qué es Docker?
Docker es una plataforma que permite crear, desplegar y ejecutar aplicaciones en contenedores. Los contenedores son entornos ligeros y portátiles que contienen todo lo necesario para ejecutar una aplicación.

## Objetivos del Taller
1. Entender qué es Docker y cómo funciona.
2. Aprender los comandos básicos de Docker.
3. Crear y gestionar contenedores.
4. Introducirse a Docker Compose.

---

## Instalación de Docker

Sigue las instrucciones para instalar Docker en tu sistema:
- [Docker Desktop (Windows/Mac)](https://www.docker.com/products/docker-desktop/)
- [Docker Engine (Linux)](https://docs.docker.com/engine/install/)

Una vez instalado, verifica que Docker funciona correctamente:
```bash
docker --version
```

Deberías ver la versión de Docker instalada.

---

## Primeros pasos con Docker

### Comando básico: `docker run`
Crea y ejecuta un contenedor basado en una imagen. Vamos a probarlo con una imagen oficial de Ubuntu.

Ejercicio:
```bash
docker run ubuntu echo "¡Hola, Docker!"
```
Este comando:
1. Descarga la imagen de Ubuntu (si no está en tu máquina).
2. Crea un contenedor.
3. Ejecuta el comando `echo "¡Hola, Docker!"` dentro del contenedor.
4. Finaliza el contenedor.

### Listar contenedores
- Contenedores en ejecución:
```bash
docker ps
```
- Todos los contenedores (incluidos los detenidos):
```bash
docker ps -a
```

### Ejercicio práctico
1. Ejecuta un contenedor interactivo de Ubuntu:
```bash
docker run -it ubuntu
```
2. Dentro del contenedor, prueba algunos comandos de Linux:
```bash
ls
pwd
exit
```
3. Observa el estado del contenedor con `docker ps -a`.

---

## Administrar imágenes y contenedores

### Listar imágenes locales
```bash
docker images
```

### Eliminar una imagen
```bash
docker rmi <nombre_imagen>
```

### Detener y eliminar contenedores
- Detener un contenedor:
```bash
docker stop <id_contenedor>
```
- Eliminar un contenedor:
```bash
docker rm <id_contenedor>
```

### Ejercicio práctico
1. Lista todas las imágenes y contenedores en tu máquina.
2. Detén un contenedor en ejecución.
3. Elimina un contenedor detenido y su imagen.

---

## Dockerfile: Crear tu propia imagen
Un `Dockerfile` es un archivo de texto que contiene instrucciones para construir una imagen de Docker personalizada.

### Ejemplo básico
Crea un archivo llamado `Dockerfile`:
```dockerfile
# Usar una imagen base
FROM ubuntu:latest

# Instalar paquetes necesarios
RUN apt-get update && apt-get install -y cowsay

# Establecer el comando predeterminado
CMD ["/usr/games/cowsay", "¡Hola, mundo desde Docker!"]
```

### Construir y ejecutar la imagen
1. Construye la imagen:
```bash
docker build -t mi-imagen-cowsay .
```
2. Ejecuta la imagen:
```bash
docker run mi-imagen-cowsay
```

### Ejercicio práctico
Modifica el `Dockerfile` para cambiar el mensaje de `cowsay` y reconstruye la imagen.

---

## Introducción a Docker Compose
Docker Compose es una herramienta para definir y ejecutar aplicaciones multicontenedor.

### Archivo `docker-compose.yml`
Ejemplo básico:
```yaml
version: '3.9'
services:
  web:
    image: nginx
    ports:
      - "8080:80"
```

### Comandos básicos
- Levantar los servicios:
```bash
docker-compose up
```
- Detener los servicios:
```bash
docker-compose down
```

### Ejercicio práctico
1. Crea el archivo `docker-compose.yml` anterior.
2. Ejecuta `docker-compose up` y abre [http://localhost:8080](http://localhost:8080) en tu navegador.
3. Detén los servicios con `docker-compose down`.

---

## Recursos adicionales
- [Documentación oficial de Docker](https://docs.docker.com/)
- [Docker Hub](https://hub.docker.com/)
