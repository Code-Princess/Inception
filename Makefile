all: build up

setup:
	mkdir -p /home/llacsivy/data/wordpress
	mkdir -p /home/llacsivy/data/mariadb

build: setup
	docker compose -f ./srcs/docker-compose.yml build

up:
	docker compose -f ./srcs/docker-compose.yml up

down:
	docker compose -f ./srcs/docker-compose.yml down

re: fclean build up

fclean: down
	rm -rf /home/llacsivy/data

.PHONY: all build up down fclean re