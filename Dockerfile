FROM alpine:latest

ENV \
  APP_DIR="/app" \
  APP_PORT="80"

# the "app" directory (relative to Dockerfile) containers your Laravel app...
WORKDIR $APP_DIR
COPY . $APP_DIR
RUN ls
COPY .env.example $APP_DIR/.env


# Essentials
RUN echo "UTC" > /etc/timezone
RUN apk add --no-cache zip unzip curl
# Installing bash
RUN apk add bash
RUN sed -i 's/bin\/ash/bin\/bash/g' /etc/passwd

# Installing PHP
RUN apk add --no-cache php8 \
    php8-common \
    php8-fpm \
    php8-pdo \
    php8-opcache \
    php8-zip \
    php8-phar \
    php8-iconv \
    php8-cli \
    php8-curl \
    php8-openssl \
    php8-mbstring \
    php8-tokenizer \
    php8-fileinfo \
    php8-json \
    php8-xml \
    php8-xmlwriter \
    php8-simplexml \
    php8-dom \
    php8-pdo_mysql \
    php8-pdo_sqlite \
    php8-tokenizer \
    php8-pecl-redis

# Installing composer
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN rm -rf composer-setup.php

RUN composer install
RUN php artisan key:generate

CMD php artisan serve --host=0.0.0.0 --port=$APP_PORT


# FROM php:8.1-cli

# RUN apt-get update -y && apt-get install -y libmcrypt-dev

# RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# WORKDIR /app
# COPY . /app

# # Install unzip utility and libs needed by zip PHP extension
# RUN apt-get update && apt-get install -y \
#     zlib1g-dev \
#     libzip-dev \
#     unzip
# #RUN docker-php-ext-install zip 
# RUN composer install

# EXPOSE 80
# CMD php artisan serve --host=0.0.0.0 --port=80