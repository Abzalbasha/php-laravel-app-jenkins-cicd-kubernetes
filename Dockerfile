FROM alpine

ENV \
  APP_DIR="/app" \
  APP_PORT="80"

# the "app" directory (relative to Dockerfile) containers your Laravel app...
COPY app/ $APP_DIR

RUN apk add --update \
    curl \
    php \
    php-opcache \
    php-openssl \
    php-pdo \
    php-json \
    php-phar \
    php-dom \
    && rm -rf /var/cache/apk/*

RUN curl -sS https://getcomposer.org/installer | php -- \
  --install-dir=/usr/bin --filename=composer

RUN cd $APP_DIR && composer install

WORKDIR $APP_DIR
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