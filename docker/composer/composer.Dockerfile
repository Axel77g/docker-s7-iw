FROM alpine:3.16

RUN apk update && apk upgrade

RUN apk add php8 \
    php8-dom\
    php8-fpm \
    php8-intl \
    php8-iconv \
    php8-mysqli \
    php8-mbstring \
    php8-pdo \
    php8-phar \
    php8-pdo_mysql \
    php8-curl \
    php8-tokenizer \
    php8-simplexml \
    php8-ctype \
    php8-session \
    php8-posix \
    php8-xml \
    php8-zlib \
    php8-pdo_pgsql

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === 'dac665fdc30fdd8ec78b38b9800061b4150413ff2e3b6f88543c636f7cd84f6db9189d43a81e5503cda447da73c7e5b6') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer 

WORKDIR /var/www/html

ENTRYPOINT ["/usr/local/bin/composer", "install"]

