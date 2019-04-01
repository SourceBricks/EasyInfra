# vim: set tabstop=8 softtabstop=8 noexpandtab:
include .env
export $(shell sed 's/=.*//' .env)

run:
	@docker-compose up -d

stop:
	@docker-compose stop

restart:
	@docker-compose restart

logs:
	@docker-compose logs -f

install:
	@docker-compose exec php-cli /bin/sh -c 'chown -R php:php /home/php/.composer/cache'
	@docker-compose exec --user="php" php-cli composer install

enter:
	@docker-compose exec --user="php" php-cli /bin/sh

destroy:
	@docker-compose down --rmi local
