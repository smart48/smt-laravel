# Laravel App Image

Laravel Dockerfile to build image on Docker Hub. This PHP FPM image uses the latest PHP 7.4 and add several PHP extensions including Opcache. We may add new bells and whistles later down the line.

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

## TODO

Add `ADD . /var/www ...` to add latest version of code to image. One will then have to publish image in a private repo doing that from project root.

We also may need to do a few `artisan` commands as well post adding code.