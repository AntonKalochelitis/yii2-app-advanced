up:
	mkdir -p ./.docker/mysql
	docker network create yii2-network || docker-compose \
		-f docker-compose.yml \
		--env-file=.env.local \
		up -d --build --remove-orphans
	docker exec -t yii2-frontend bash -c '/app/init --env=Development --overwrite=y'
	docker exec -t yii2-frontend bash -c 'composer install'
	docker exec -t yii2-frontend bash -c '/app/yii cache/flush-all'
	sleep 60
	sudo make migrate

prod:
	include ./.env.prod
	mkdir -p ./.docker/mysql
	docker network create yii2-network || docker-compose \
		-f ./docker-compose.yml \
		--env-file=./.env.prod \
		up -d --build --remove-orphans
	docker exec -t yii2-frontend bash -c '/app/init --env=Production --overwrite=y'
	docker exec -t yii2-frontend bash -c 'composer install'
	docker exec -t yii2-frontend bash -c '/app/yii cache/flush-all'
	sleep 60
	sudo make migrate

preprod:
	include ./.env.preprod
	mkdir -p ./.docker/mysql
	docker network create yii2-network || docker-compose \
		-f ./docker-compose.yml \
		--env-file=./.env.preprod \
		up -d --build --remove-orphans
	docker exec -t yii2-frontend bash -c '/app/init --env=Production --overwrite=y'
	docker exec -t yii2-frontend bash -c 'composer install'
	docker exec -t yii2-frontend bash -c '/app/yii cache/flush-all'
	sleep 60
	sudo make migrate

migrate:
	docker exec -t yii2-frontend bash -c '/app/yii migrate --interactive=0'
    #docker exec -t yii2-frontend bash -c '/app/yii_test migrate --interactive=0'

ssh-frontend:
	docker exec -it yii2-frontend bash

ssh-backend:
	docker exec -it yii2-backend bash

stop:
	docker stop yii2-frontend
	docker stop yii2-backend
	docker stop yii2-mysql
	docker stop yii2-redis
	docker stop yii2-phpmyadmin

rm:
	docker rm yii2-frontend
	docker rm yii2-backend
	docker rm yii2-mysql
	docker rm yii2-redis
	docker rm yii2-phpmyadmin
