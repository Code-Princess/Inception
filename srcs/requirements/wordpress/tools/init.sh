#!/bin/sh
set -e

# Load secrets from files
export WORDPRESS_ROOT_PASSWORD=$(cat "$WORDPRESS_DB_PASSWORD_FILE")
export WORDPRESS_ADMIN_PASSWORD=$(cat "$WORDPRESS_ADMIN_PASSWORD_FILE")
export WORDPRESS_USER_PASSWORD=$(cat "$WORDPRESS_USER_PASSWORD_FILE")

echo "Admin user: $WORDPRESS_ADMIN_USER"
echo "Admin pass: $WORDPRESS_ADMIN_PASSWORD"
echo "User pass: $WORDPRESS_USER_PASSWORD"

# Download WordPress if not already present
if [ ! -f /var/www/html/index.php ]; then
    echo "Downloading WordPress..."
    curl -sSLO https://wordpress.org/latest.tar.gz
    tar -xzf latest.tar.gz
    cp -R wordpress/* /var/www/html/
    rm -rf wordpress latest.tar.gz
    chown -R www-data:www-data /var/www/html
fi

cd /var/www/html

# Download WP-CLI if not already present
if [ ! -f wp-cli.phar ]; then
    echo "Downloading WP-CLI..."
    curl -sSLO https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
fi

# Configure WordPress if needed
if [ ! -f wp-config.php ]; then
    echo "Creating wp-config.php..."
    ./wp-cli.phar config create \
        --dbname="$WORDPRESS_DB_NAME" \
        --dbuser="$WORDPRESS_ROOT" \
        --dbpass="$WORDPRESS_ROOT_PASSWORD" \
        --dbhost="$WORDPRESS_DB_HOST:$WORDPRESS_DB_PORT" \
        --allow-root
fi

# Install WordPress if not already installed
if ! ./wp-cli.phar core is-installed --allow-root; then
    echo "Installing WordPress..."
    ./wp-cli.phar core install \
        --url="$WORDPRESS_WEBSITE" \
        --title="inception" \
        --admin_user="$WORDPRESS_ADMIN_USER" \
        --admin_password="$WORDPRESS_ADMIN_PASSWORD" \
        --admin_email="$WORDPRESS_ADMIN_USER@gmail.com" \
        --allow-root
fi

# Create a user if not already created
if ! ./wp-cli.phar user get "$WORDPRESS_USER" --allow-root > /dev/null 2>&1; then
    echo "Creating additional WordPress user..."
    ./wp-cli.phar user create "$WORDPRESS_USER" "$WORDPRESS_USER@gmail.com" \
        --role=author \
        --user_pass="$WORDPRESS_USER_PASSWORD" \
        --allow-root
fi

# Launch PHP-FPM in foreground
exec php-fpm7.4 -F
