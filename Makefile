# vim: set tabstop=8 softtabstop=8 noexpandtab:
run: 
    @docker-compose up -d

stop:
    @docker-compose stop

restart:
    @docker-compose restart

logs:
    @docker-compose logs -f

install:
    @docker-compose exec client-lawyer /bin/sh -c 'chown -R php:php /home/php/.composer/cache'
    @docker-compose exec --user="php" client-lawyer composer install

enter:
    @docker-compose exec --user="php" client-lawyer /bin/sh

destroy:
    @docker-compose down --rmi local
