FROM debian:bullseye

RUN apt-get update && apt-get install -y \
	php-fpm \
	php-mysql \
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

# Create working directory
WORKDIR /var/www/html

# Copy startup script into container
COPY ./tools/init.sh /usr/local/bin/setup-wordpress.sh
RUN chmod +x /usr/local/bin/setup-wordpress.sh

# Expose PHP-FPM port (usually through a Unix socket or port 9000)
EXPOSE 9000

# Set entrypoint to our WordPress setup script
ENTRYPOINT ["setup-wordpress.sh"]