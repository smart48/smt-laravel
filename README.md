# Laravel App Image

Laravel Dockerfile is a custom PHP FPM Image. Is is still pretty barren , but we will add more elements as time goes by.

## Docker Build

To build for our own Smart48 Docker Hub repository we use
```
docker build . -t smart48/smt-laravel
```
This will build with the tag using our organization's name and name for the image.

## Test

You can test the build image using:

```
docker run --name smt-laravel -d smart48/smt-laravel:latest
```
And then you can check it using

```
docker exec -it smt-laravel ash 
```

## Docker Push

And then to push the built image you run:

```
docker image push smart48/smt-laravel
```

We connected this repository to Docker Hub so on every change / `git push` Docker Hub does an automatic build. The image is currently located at https://hub.docker.com/r/smart48/laravel-app . 


**NB** This you only use for the build used for production. For the local build with `docker-compose` you can just load from the container as the data is already threre on your local box.

## TODO

Add information to other images for Nginx, PHP Worker, Horizon et cetera and Laradock version for local development will be added in the near future.