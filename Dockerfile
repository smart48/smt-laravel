FROM php:7.4-fpm

WORKDIR /app

# https://learnk8s.io/blog/kubernetes-deploy-laravel-the-easy-way
# COPY . app to copy all laravel app files to this working directory
# Only use this option when this container is in a private repository

RUN apt-get update && apt-get install -y libmcrypt-dev zip unzip git \
    libmagickwand-dev --no-install-recommends \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && docker-php-ext-install pdo_mysql pcntl bcmath \
    && docker-php-ext-install opcache

# Configure non-root user.
ARG PUID=1000
ENV PUID ${PUID}
ARG PGID=1000
ENV PGID ${PGID}

RUN groupmod -o -g ${PGID} www-data && \
    usermod -o -u ${PUID} -g www-data www-data

COPY ./laravel.ini /usr/local/etc/php/conf.d
COPY ./opcache.ini /usr/local/etc/php/conf.d
COPY ./xlaravel.pool.conf /usr/local/etc/php-fpm.d/
