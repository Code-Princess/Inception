FROM debian:bullseye

RUN apt-get update && \
	apt-get install -y nginx openssl && \
	apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# debug 'print'
COPY ./Dockerfile /var/www/html/dockfile

COPY ./tools/certs.sh /tools/certs.sh
RUN chmod +x /tools/certs.sh && /tools/certs.sh

COPY ./conf/def.conf /etc/nginx/sites-available/.
RUN rm -f /etc/nginx/sites-enabled/default && \
    ln -s /etc/nginx/sites-available/def.conf /etc/nginx/sites-enabled/default

RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
