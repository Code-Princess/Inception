FROM debian:bullseye

RUN apt-get update && apt-get install -y \
	php-fpm \
	php-mysql \
	# php-curl \
	# php-gd \
	php-mbstring \
	php-xml \
	php-zip \
	curl \
	unzip \
	wget \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*

# Create required directory for PHP-FPM
RUN mkdir -p /run/php

# Configure PHP-FPM to listen on TCP instead of Unix socket
RUN sed -i 's|^listen = .*|listen = 0.0.0.0:9000|' /etc/php/*/fpm/pool.d/www.conf

# # Configure PHP-FPM to run in foreground
# RUN sed -i 's/;daemonize = yes/daemonize = no/' /etc/php/*/fpm/php-fpm.conf

# Create working directory
WORKDIR /var/www/html

# Copy startup script into container
COPY ./tools/init.sh /usr/local/bin/setup-wordpress.sh
RUN chmod +x /usr/local/bin/setup-wordpress.sh

# # Download and extract WordPress
# RUN curl -o /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz && \
#     tar -xzf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1 && \
#     rm /tmp/wordpress.tar.gz

# # Set permissions
# RUN chown -R www-data:www-data /var/www/html && \
#     find /var/www/html -type d -exec chmod 755 {} \; && \
#     find /var/www/html -type f -exec chmod 644 {} \;

# Expose PHP-FPM port (usually through a Unix socket or port 9000)
EXPOSE 9000

# # Run PHP-FPM in the foreground
# CMD ["php-fpm7.4", "-F"]

# Set entrypoint to our WordPress setup script
ENTRYPOINT ["setup-wordpress.sh"]