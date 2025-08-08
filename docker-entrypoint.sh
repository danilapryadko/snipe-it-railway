#!/bin/bash
set -e

# Wait for database to be ready
echo "Waiting for database connection..."
while ! mysqladmin ping -h"$MYSQLHOST" -P"$MYSQLPORT" --silent; do
    sleep 2
done
echo "Database is ready!"

# Generate APP_KEY if not set
if [ -z "$APP_KEY" ]; then
    echo "Generating APP_KEY..."
    php artisan key:generate --force
    export APP_KEY=$(grep APP_KEY .env | cut -d '=' -f2)
fi

# Run migrations
echo "Running database migrations..."
php artisan migrate --force

# Create symlink for storage
echo "Creating storage symlink..."
php artisan storage:link

# Clear and optimize
echo "Optimizing application..."
php artisan config:clear
php artisan cache:clear
php artisan route:clear
php artisan view:clear
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Set permissions
chown -R www-data:www-data /var/www/html/storage
chown -R www-data:www-data /var/www/html/bootstrap/cache
chmod -R 775 /var/www/html/storage
chmod -R 775 /var/www/html/bootstrap/cache

# Start Apache
echo "Starting Apache..."
exec "$@"