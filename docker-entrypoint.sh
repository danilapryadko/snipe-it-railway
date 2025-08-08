#!/bin/bash
set -e

# Wait for database to be ready
echo "Waiting for database connection..."
max_tries=30
counter=0
while ! mysqladmin ping -h"$MYSQLHOST" -P"$MYSQLPORT" --silent 2>/dev/null; do
    counter=$((counter+1))
    if [ $counter -gt $max_tries ]; then
        echo "Failed to connect to database after $max_tries attempts"
        exit 1
    fi
    echo "Waiting for database... (attempt $counter/$max_tries)"
    sleep 3
done
echo "Database is ready!"

# Run composer post scripts
echo "Running composer post-install scripts..."
composer run-script post-install-cmd --no-interaction || true

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