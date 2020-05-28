# Laravel App Image

Laravel Dockerfile to build image on Docker Hub. This PHP FPM image uses the latest PHP 7.4 and add several PHP extensions including Opcache. We may add new bells and whistles later down the line.

## Build

To build for my own temporary Docker Hub repository I use
```
docker build . -t smart48/laravel-app
```

## Push

And then to push you run:

```
docker image push smart48/laravel-app
```