# Laravel App Image

Laravel Dockerfile based on Laradock PHP FPM to build image on Docker Hub. This PHP FPM image uses the latest PHP 7.4 and add several PHP extensions including Opcache.

## Variables

We cannot use `.env` during build:

- The `.env` file, is only used during a pre-processing step when working with `docker-compose.yml` files. Dollar-notation variables like `$HI` are substituted for values contained in an “`.env`” named file in the same directory.
- `ARG` is only available during the build of a Docker image (`RUN` etc), not after the image is created and containers are started from it (`ENTRYPOINT`, `CMD`). You can use ARG values to set ENV values to work around that.
- `ENV` values are available to containers, but also `RUN`-style commands during the Docker build starting with the line where they are introduced.

https://vsupalov.com/docker-arg-env-variable-guide/

So we need to replace them all by fixed values or use `ARG`. Laradock added `ARG`s already. We just needed to define a few to get the proper manifest for chosen PHP version.

## Docker Build

To build for our own Smart48 Docker Hub repository we use
```
docker build . -t smart48/laravel-app
```
This will build with the tag using our organization's name and name for the image.

## Docker Push

And then to push the built image you run:

```
docker image push smart48/laravel-app
```

**NB** We connected this repository to Docker Hub so on every change / `git push` Docker Hub does an automatic build.

## Code Base Copy

Add `COPY . /var/www/` after `WORKDIR /var/www` to add latest version of code to image. One will then have to publish image in a private repo doing that from project root. You can however decide not to do this and use other code deployment tools like PHP Deployer.

_A valid use case for ADD is when you want to extract a local tar file into a specific directory in your Docker image. If you're copying in local files to your Docker image, always use COPY because it's more explicit._
https://stackoverflow.com/a/51871487/460885

example: https://github.com/larastudio/laravel-docker-template

**NB** This you only use for the build used for production. For the local build with `docker-compose` you can just load from the container as the data is already threre on your local box.

## TODO

Add information to other images for Nginx, PHP Worker, Horizon et cetera and Laradock version for local development will be added in the near future.