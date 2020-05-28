FROM php:7.4-fpm-buster

ENV COMPOSER_ALLOW_SUPERUSER=1

ARG BUILD_OPCACHE

RUN  sed -i 's/deb.debian.org/opensource.nchc.org.tw/g'  /etc/apt/sources.list

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libmemcached-dev \
        libz-dev \
        libpq-dev \
        libssl-dev \
        libmcrypt-dev \
        openssh-server \
        libmagickwand-dev \
        git \
        cron \
        nano \
        libxml2-dev \
        libzip-dev \
        unzip \
        && rm -r /var/lib/apt/lists/*

# Install the PHP pcntl extention
RUN docker-php-ext-install pcntl

# Install the PHP zip extention
RUN docker-php-ext-install zip

# Install the PHP pdo_mysql extention
RUN docker-php-ext-install pdo_mysql

# Install the PHP bcmath extension
RUN docker-php-ext-install bcmath

RUN docker-php-ext-install intl

#####################################
# OPCache:
#####################################

RUN if [ "$BUILD_OPCACHE" = "true" ]; then docker-php-ext-install opcache ; fi

COPY ./php/opcache.ini /usr/local/etc/php/conf.d/opcache.ini

#####################################
# Composer:
#####################################

# Install composer and add its bin to the PATH.
RUN curl -s http://getcomposer.org/installer | php && \
    echo "export PATH=${PATH}:/var/www/vendor/bin" >> ~/.bashrc && \
    mv composer.phar /usr/local/bin/composer
# Source the bash
RUN . ~/.bashrc

#install parallel composer install
RUN composer global require hirak/prestissimo

#
#--------------------------------------------------------------------------
# Final Touch
#--------------------------------------------------------------------------
#

ADD ./php/local.ini /usr/local/etc/php/conf.d

RUN usermod -u 1000 www-data && groupmod -g 1000 www-data

WORKDIR /var/www

COPY ./php/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
RUN ln -s /usr/local/bin/docker-entrypoint.sh /
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 9000
CMD ["php-fpm"]
