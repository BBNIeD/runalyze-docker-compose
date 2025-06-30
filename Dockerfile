# Dockerfile
FROM php:7.4-apache

# Install extensions
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev \
    libxml2-dev libzip-dev unzip git mariadb-client \
 && docker-php-ext-install gd mysqli xml zip mbstring

# Enable Apache rewrite
RUN a2enmod rewrite

# Copy source
COPY . /var/www/html/

# Set permissions
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80
