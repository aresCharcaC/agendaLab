#!/bin/bash

# Configurar variables de entorno para PostgreSQL
if [ ! -z "$DATABASE_URL" ]; then
    # Parsear DATABASE_URL para variables de entorno
    regex="^postgres://([^:]+):([^@]+)@([^:]+):([0-9]+)/(.+)$"
    if [[ $DATABASE_URL =~ $regex ]]; then
        export DB_CONNECTION=pgsql
        export DB_HOST=${BASH_REMATCH[3]}
        export DB_PORT=${BASH_REMATCH[4]}
        export DB_DATABASE=${BASH_REMATCH[5]}
        export DB_USERNAME=${BASH_REMATCH[1]}
        export DB_PASSWORD=${BASH_REMATCH[2]}
    fi
fi

# Generar clave si no existe
if [ "$APP_KEY" = "base64:PLACEHOLDER" ]; then
    php artisan key:generate --force
fi

# Iniciar servicios
service nginx start
php-fpm