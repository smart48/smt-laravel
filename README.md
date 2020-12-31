# Laravel App Image

Laravel Dockerfile is a custom PHP FPM Image. Is is still pretty barren , but we will add more elements as time goes by.

## Docker Build

To build for our own Smart48 Docker Hub repository we use
```
docker build . -t smart48/smt-laravel
```
This will build with the tag using our organization's name and name for the image. Make sure Docker is running or see something like `Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?`

## Test

You can test the build image using:

```
docker run --name smt-laravel -d smart48/smt-laravel:latest
```
And then you can check it using

```
docker exec -it smt-laravel bash
```

To check PHP running for example

```
smt-laravel git:(master) docker exec -it smt-laravel bash
root@780405b59479:/code# php --version
PHP 7.4.12 (cli) (built: Nov 18 2020 09:41:41) ( NTS )
Copyright (c) The PHP Group
Zend Engine v3.4.0, Copyright (c) Zend Technologies
    with Zend OPcache v7.4.12, Copyright (c), by Zend Technologies
```

## Docker Tag


To tag the latest stabele build you can use `docker tag <repo/image> <repo/image:version>`:

```
docker tag smart48/smt-laravel smart48/smt-laravel:2.0.5
```

You will on listing then see the newly added version:

```
docker images                                         
REPOSITORY                     TAG                 IMAGE ID            CREATED             SIZE
smart48/smt-mysql              latest              9aae819f7c46        6 days ago          545MB
smart48/smt-horizon            latest              cb443bc93f92        7 days ago          422MB
smart48/smt-laravel            1.0                 4f6ffbe3b4ec        11 days ago         654MB
smart48/smt-laravel            latest              4f6ffbe3b4ec        11 days ago         654MB
...

```
## Docker Push

And then to push the built image you run:

```
docker image push smart48/smt-laravel:2.0.5
```

Or if you did tag the image

```
docker image push smart48/smt-laravel:version
```

and you will see something like

```
docker image push smart48/smt-laravel
The push refers to repository [docker.io/smart48/smt-laravel]
e76ec036953e: Pushed 
34f94e6c4059: Pushed 
4df1b456805c: Pushed 
e045a4a21068: Pushed 
42898d89ae59: Pushed
127e2c9a33c1: Pushed 
4ea3c65c023d: Layer already exists 
dfc9a25aec65: Layer already exists 
f88ec9b10e54: Layer already exists 
600219b5f5b8: Layer already exists 
d31ca1f001ca: Layer already exists 
57fbdd49fe27: Layer already exists
dfad4a4c6fc6: Layer already exists 
7a17eb00e8b7: Layer already exists 
3855c00ce1fc: Layer already exists 
f5600c6330da: Layer already exists 
latest: digest: sha256:39e5dbe398536e787255d4376d3202b7872c2a23e00377468fa6294c4495ec6b size: 3659
```

We connected this repository to Docker Hub so on every change / `git push` Docker Hub does an automatic build. The image is currently located at https://hub.docker.com/r/smart48/laravel-app . 


**NB** This you only use for the build used for production. For the local build with `docker-compose` you can just load from the container as the data is already threre on your local box.

**MBB** Better to push the latest by tag, especially for production usage

## TODO

Add information to other images for Nginx, PHP Worker, Horizon et cetera and Laradock version for local development will be added in the near future.