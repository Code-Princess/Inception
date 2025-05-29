#!/bin/sh
if [ ! -d "./certs" ]; then
  mkdir -p /etc/nginx/
  openssl req -x509 -newkey rsa:2048 -nodes \
    -keyout /etc/ssl/private/key.pem \
    -out /etc/ssl/certs/cert.pem \
    -days 365 \
    -subj "/C=FR/ST=Ile-de-France/L=Paris/O=42/CN=llacsivy.42.fr"
fi
