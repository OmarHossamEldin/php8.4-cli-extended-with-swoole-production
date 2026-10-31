FROM php:8.5.12-cli-alpine3.24

RUN apk add vim zip unzip tzdata curl gettext git btop bash

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

RUN install-php-extensions \
    pdo_mysql \
    pdo_pgsql \
    redis \
    zip \
    bcmath \
    intl \
    sockets \
    gd \
    pcntl \
    openswoole \
    uv \
    @composer

COPY ./phpconfigs/* /usr/local/etc/php/conf.d/

WORKDIR /var/www/html
COPY index.php .

EXPOSE 3000

CMD ["php", "index.php"]