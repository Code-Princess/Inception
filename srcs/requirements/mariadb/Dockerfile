FROM debian:bullseye

RUN apt-get update && \
	apt-get install -y mariadb-server mariadb-client && \
	rm -rf /var/lib/apt/lists/*

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/init.sh .

RUN chmod +x init.sh
EXPOSE 3306
CMD ["./init.sh"]
