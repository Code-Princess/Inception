FROM debian:bullseye

RUN apt-get update && \
	apt-get install -y nginx openssl && \
	apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY ./tools/init.sh .
COPY ./tools/certs.sh /tools/certs.sh
RUN chmod +x /tools/certs.sh && /tools/certs.sh
COPY ./conf/def.conf /etc/nginx/sites-available/.

EXPOSE 443

CMD ["bash", "init.sh"]
