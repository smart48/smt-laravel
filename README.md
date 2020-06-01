# Laravel App Image

Laravel Dockerfile based on Laradock PHP FPM to build image on Docker Hub. This PHP FPM image uses the latest PHP 7.4 and add several PHP extensions including Opcache.

## Build

To build for our own Smart48 Docker Hub repository I use
```
docker build . -t smart48/laravel-app
```

## Push

And then to push you run:

```
docker image push smart48/laravel-app
```

## APP COPY

Add `COPY . /var/www/` after `WORKDIR /var/www` to add latest version of code to image. One will then have to publish image in a private repo doing that from project root. You can however decide not to do this and use other code deployment tools like PHP Deployer.

_A valid use case for ADD is when you want to extract a local tar file into a specific directory in your Docker image. If you're copying in local files to your Docker image, always use COPY because it's more explicit._
https://stackoverflow.com/a/51871487/460885

example: https://github.com/larastudio/laravel-docker-template

**NB** This you only use for the build used for production. For the local build with `docker-compose` you can just load from the container as the data is already threre on your local box.

## TODO

We also may need to do a few `artisan` commands as well post adding code.