FROM php:7.4-cli

RUN apt-get update -y && apt-get install -y libmcrypt-dev zip unzip

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /app
COPY . /app
# Install unzip utility and libs needed by zip PHP extension 
RUN composer install

EXPOSE 8000
CMD php artisan serve