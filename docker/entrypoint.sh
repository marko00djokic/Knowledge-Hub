#!/usr/bin/env bash
set -e

# Remove Vite hot file only when not in local (e.g. staging/production).
# In local/Docker dev we keep public/hot so the node container can write it and the app can use it.
if [ "${APP_ENV:-local}" != "local" ] && [ -f /var/www/html/artisan ]; then
    php /var/www/html/artisan app:clear-vite-hot --ansi || true
fi

chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache 2>/dev/null || true

exec "$@"
