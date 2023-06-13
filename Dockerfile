FROM php:8.1-fpm

# Установка Git и zip
RUN apt-get update \
    && apt-get install -y git zip unzip \
    && docker-php-ext-install pdo_mysql

# Устанавливаем Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Устанавливаем рабочую директорию внутри контейнера
WORKDIR /var/www/html

# Копируем файлы Laravel в контейнер
COPY html/ .

# Установка зависимостей
RUN composer install --no-scripts --no-autoloader

# Генерируем ключ приложения Laravel
RUN composer dump-autoload
RUN php artisan key:generate

# Запуск приложения
CMD ["php-fpm"]
