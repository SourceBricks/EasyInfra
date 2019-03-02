FROM php:7.2.15-cli-alpine3.9 as builder

RUN set -ex \
   && apk add --update --no-cache \
       ${PHPIZE_DEPS} \
       # required for intl extension
       icu-dev \
       # required for zip extension
       zlib-dev \
       libzip-dev \
       libzip \
   && docker-php-ext-install bcmath intl opcache pdo_mysql zip 

# php-cli image
FROM php:7.2.15-cli-alpine3.9

LABEL maintainer="nikola@applycolo.rs"
LABEL version="7.2.15"
LABEL description="SourceBricks php-cli image."

# user build args
ARG PHP_USER_ID=1000
ARG PHP_GROUP_ID=1000

# copy built extensions
COPY --from=builder /usr/local/lib/php/extensions /usr/local/lib/php/extensions
# copy composer binary
COPY --from=composer:1.8.4 /usr/bin/composer /usr/bin/composer

RUN set -x \
   && addgroup -g $PHP_GROUP_ID -S php \
   && adduser -u $PHP_USER_ID -D -S -G php php \
   && mkdir -p /app \
   && chown -R php:php /app \
   && docker-php-ext-enable zip bcmath

USER php
WORKDIR /app

# install prestissimo (parallel composer install)
RUN composer global require hirak/prestissimo

USER root

ENV PATH="~/.composer/vendor/bin:./vendor/bin:${PATH}"
CMD ["php", "-a"]