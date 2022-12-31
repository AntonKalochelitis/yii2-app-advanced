up:
	mkdir -p ./.docker/mysql
	docker network create anton-kalochelitis-network || docker-compose \
		-f docker-compose.yml \
		--env-file=.env.local \
		up -d --build --remove-orphans
	docker exec -t anton-kalochelitis-frontend-yii2 bash -c '/app/init --env=Development --overwrite=y'
	docker exec -t anton-kalochelitis-frontend-yii2 bash -c 'composer install'
	docker exec -t anton-kalochelitis-frontend-yii2 bash -c '/app/yii cache/flush-all'
	sleep 60
	docker exec -t anton-kalochelitis-frontend-yii2 bash -c '/app/yii migrate --interactive=0'
	#docker exec -t anton-kalochelitis-frontend-yii2 bash -c '/app/yii_test migrate --interactive=0'

prod:
	mkdir -p ./.docker/mysql
	docker network create anton-kalochelitis-network || docker-compose \
		-f ./docker-compose.yml \
		--env-file=./.env.prod \
		up -d --build --remove-orphans
	docker exec -t anton-kalochelitis-frontend-yii2 bash -c '/app/init --env=Production --overwrite=y'
	docker exec -t anton-kalochelitis-frontend-yii2 bash -c 'composer install'
	docker exec -t anton-kalochelitis-frontend-yii2 bash -c '/app/yii cache/flush-all'
	sleep 60
	docker exec -t anton-kalochelitis-frontend-yii2 bash -c '/app/yii migrate --interactive=0'
	#docker exec -t anton-kalochelitis-frontend-yii2 bash -c '/app/yii_test migrate --interactive=0'

frontend:
	docker exec -it anton-kalochelitis-frontend-yii2 bash

backend:
	docker exec -it anton-kalochelitis-backend-yii2 bash

stop:
	docker stop anton-kalochelitis-frontend-yii2
	docker stop anton-kalochelitis-backend-yii2
	docker stop anton-kalochelitis-mysql
	docker stop anton-kalochelitis-redis
	docker stop anton-kalochelitis-phpmyadmin

rm:
	docker rm anton-kalochelitis-frontend-yii2
	docker rm anton-kalochelitis-backend-yii2
	docker rm anton-kalochelitis-mysql
	docker rm anton-kalochelitis-redis
	docker rm anton-kalochelitis-phpmyadmin
