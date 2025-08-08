#!/bin/bash
set -e

# Railway provides PORT environment variable (should be 8080)
echo "Starting on port: ${PORT:-8080}"

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

# Set APP_URL if RAILWAY_STATIC_URL is available
if [ ! -z "$RAILWAY_STATIC_URL" ]; then
    export APP_URL="https://$RAILWAY_STATIC_URL"
    echo "Setting APP_URL to: $APP_URL"
fi

# Run migrations
echo "Running database migrations..."
php artisan migrate --force || echo "Migration failed, continuing..."

# Create symlink for storage
echo "Creating storage symlink..."
php artisan storage:link || echo "Storage link already exists"

# Clear and optimize
echo "Optimizing application..."
php artisan config:clear
php artisan cache:clear
php artisan route:clear
php artisan view:clear
# Clear translation cache to force reload Russian locale
php artisan lang:cache || true
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