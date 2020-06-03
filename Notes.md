## Variables

We cannot use `.env` during build:

- The `.env` file, is only used during a pre-processing step when working with `docker-compose.yml` files. Dollar-notation variables like `$HI` are substituted for values contained in an “`.env`” named file in the same directory.
- `ARG` is only available during the build of a Docker image (`RUN` etc), not after the image is created and containers are started from it (`ENTRYPOINT`, `CMD`). You can use ARG values to set ENV values to work around that.
- `ENV` values are available to containers, but also `RUN`-style commands during the Docker build starting with the line where they are introduced.

https://vsupalov.com/docker-arg-env-variable-guide/

So we need to replace them all by fixed values or use `ARG`. Laradock added `ARG`s already. We just needed to define a few to get the proper manifest for chosen PHP version.