FROM php:8.2-fpm

# Instalar dependencias
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libpq-dev \
    zip \
    unzip \
    nginx

# Limpiar cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Instalar extensiones PHP (incluyendo pdo_pgsql para PostgreSQL)
RUN docker-php-ext-install pdo_mysql pdo_pgsql mbstring exif pcntl bcmath gd

# Obtener Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Configurar directorio de trabajo
WORKDIR /var/www/html

# Copiar código del proyecto
COPY . /var/www/html

# Instalar dependencias del proyecto
RUN composer install --no-interaction --prefer-dist --no-dev --no-scripts

# Generar archivo .env si no existe
RUN if [ ! -f ".env" ]; then \
    cp .env.example .env || echo "No .env.example file found"; \
    sed -i 's/APP_KEY=.*/APP_KEY=base64:PLACEHOLDER/' .env; \
fi

# Crear directorios de almacenamiento
RUN mkdir -p /var/www/html/storage/logs
RUN mkdir -p /var/www/html/storage/framework/cache
RUN mkdir -p /var/www/html/storage/framework/sessions
RUN mkdir -p /var/www/html/storage/framework/views
RUN touch /var/www/html/storage/logs/laravel.log

# Configurar permisos
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache
RUN chmod -R 777 /var/www/html/storage /var/www/html/bootstrap/cache

# Copiar configuración Nginx
COPY docker/nginx.conf /etc/nginx/sites-available/default

# Copiar script de inicio
COPY docker/start.sh /start.sh
RUN chmod +x /start.sh

# Exponer puerto
EXPOSE 8080

# Ejecutar script de inicio
CMD ["/start.sh"]