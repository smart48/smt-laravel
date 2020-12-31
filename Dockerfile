FROM php:7.4-fpm

# Install Composer
COPY --from=composer /usr/bin/composer /usr/bin/composer 

WORKDIR /code

# Add Necessary PHP Packages

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

# WORKDIR www-data
RUN groupmod -o -g ${PGID} www-data && \
    usermod -o -u ${PUID} -g www-data www-data

# Copy PHP config files
COPY ./laravel.ini /usr/local/etc/php/conf.d
COPY ./opcache.ini /usr/local/etc/php/conf.d
COPY ./xlaravel.pool.conf /usr/local/etc/php-fpm.d/

# Add code to temporary location on image
COPY laravel /var/www

# Install Composer Packages
RUN cd /var/www && composer install \
&& chown -R 1000:1000 /var/www
