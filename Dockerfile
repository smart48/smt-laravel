FROM php:7.4-fpm

# Install Composer
COPY --from=composer /usr/bin/composer /usr/bin/composer 

WORKDIR /code

#
#--------------------------------------------------------------------------
# Software's Installation
#--------------------------------------------------------------------------
#
# Installing tools and PHP extentions using "apt", "docker-php", "pecl",
#

# Install "curl", "libmemcached-dev", "libpq-dev", "libjpeg-dev",
#         "libpng-dev", "libfreetype6-dev", "libssl-dev", "libmcrypt-dev",
RUN set -eux; \
    apt-get update; \
    apt-get upgrade -y; \
    apt-get install -y --no-install-recommends \
            libmcrypt-dev \
            zip \
            unzip \
            git \
            libmagickwand-dev --no-install-recommends \
            curl \
            libmemcached-dev \
            libz-dev \
            libpq-dev \
            libjpeg-dev \
            libpng-dev \
            libfreetype6-dev \
            libssl-dev \
            libwebp-dev \
            libmcrypt-dev \
            libonig-dev; \
    rm -rf /var/lib/apt/lists/*

RUN set -eux; \
    # Install PHP Extensions
    docker-php-ext-install pdo_mysql; \
    # Install the PHP GD library
    docker-php-ext-configure gd \
            --prefix=/usr \
            --with-jpeg \
            --with-webp \
            --with-freetype; \
    docker-php-ext-install gd \
    && docker-php-ext-install pcntl \
    && docker-php-ext-install bcmath \
    && docker-php-ext-install opcache \
    && docker-php-ext-install mysqli \
    # PHP Redis Extension via PECL
    && pecl install -o -f redis \
    && docker-php-ext-enable redis

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

# Production Version PHP FPM 7.4
COPY ./php7.4.ini /usr/local/etc/php/php.ini

# Add code to temporary location on image
COPY laravel /var/www

# Install Composer Packages
RUN cd /var/www && composer install \
&& chown -R 1000:1000 /var/www
