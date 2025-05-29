
setup:
	mkdir -p ../data/wordpress
	mkdir -p ../data/mariadb

build: setup
	docker compose -f ./srcs/docker-compose.yml build

up:
	docker compose -f ./srcs/docker-compose.yml up

down:
	docker compose -f ./srcs/docker-compose.yml down

fclean: down
	rm -rf ../data

# build, up, down rm clean 


# production:
# setup:
# 	mkdir -p /home/llacsivy/data/wordpress
# 	mkdir -p /home/llacsivy/data/mariadb
#
#

.PHONY: all build up down start stop clean fclean re logs