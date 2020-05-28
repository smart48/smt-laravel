# laravel App Image

Laravel Dockerfile to build image on Docker Hub

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