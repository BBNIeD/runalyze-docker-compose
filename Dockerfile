FROM php:7.4-apache

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libxml2-dev \
    libzip-dev \
    unzip \
    git \
    mariadb-client \
 && docker-php-ext-configure gd \
    --with-freetype=/usr/include/ \
    --with-jpeg=/usr/include/ \
 && docker-php-ext-install -j$(nproc) gd mysqli xml zip mbstring \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Activation d'Apache rewrite
RUN a2enmod rewrite

# Copie du code source
COPY . /var/www/html
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80
