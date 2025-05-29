rm -f /etc/nginx/sites-enabled/default && \
ln -s /etc/nginx/sites-available/def.conf /etc/nginx/sites-enabled/default

chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

nginx -g 'daemon off;'