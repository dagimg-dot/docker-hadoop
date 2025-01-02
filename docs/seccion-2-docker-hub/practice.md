# Practice 2: Running a Container with an Image from Docker Hub

## Start the container

In a terminal, run the following command:

```bash
docker run ubuntu
```

You will see that on the first run, since the image does not exist locally, it will be automatically downloaded from Docker Hub.

## Check running containers

If we run the following command:

```bash
docker ps
```

We will see that no containers are running. Why is that?

## Start the container in interactive mode

Now let's restart the previous container, but this time we'll add the `-it` flag in front:

```bash
docker run -it ubuntu
```

The terminal prompt will change. Where are we?

## Check active containers

Without doing anything else, open a parallel terminal and run:

```bash
docker ps
```

Now you should see the Ubuntu container running.

## Confirm we are inside a Linux system

In the terminal with the Linux prompt, run:

```bash
cat /etc/os_release
```

You will see that we are indeed inside a Linux system.

## End the session with `exit`

To end the Linux session, type the following in that terminal:

```bash
exit
```

## Check active containers

In the parallel terminal, if we check the running containers again, there will now be none:

```bash
docker ps
```
