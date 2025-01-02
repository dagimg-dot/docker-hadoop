# Practice 1: Creating an Image with Dockerfile

## Create the Dockerfile

Create a `Dockerfile` file with the following content:

```bash
FROM nginx:alpine
COPY ./index.html /usr/share/nginx/html
EXPOSE 80
```

## Build the image

In the directory where the above `Dockerfile` is located, run:

```bash
docker build -t my_server:1.0 .
```

Note: The `.` at the end is important.

## Run the container

Now that the image has been created, run a container. To do so, type the following in that directory:

```bash
docker run -p 80:80 my_server:1.0
```

You will see the container's log, and the process will remain running. To exit, press Ctrl+C.

## Run the container (detached mode)

If you don't want the terminal to be blocked, you can run the container in the background by adding the `-d` flag:

```bash
docker run -d -p 80:80 my_server:1.0
```

Now the terminal will remain free.

## List running containers

To view a list of running containers, enter:

```bash
docker ps
```

## Stop a container

To stop a running container, use the following command:

```bash
docker stop <CONTAINER_ID> | <CONTAINER_NAME>
```
