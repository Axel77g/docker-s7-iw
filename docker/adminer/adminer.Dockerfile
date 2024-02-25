# Définir l'image de base
FROM alpine:3.16

RUN apk update && apk upgrade

RUN apk add --no-cache wget

WORKDIR /var/www/html

RUN wget "https://www.adminer.org/latest.php" -O /var/www/html/adminer.php --no-check-certificate

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

EXPOSE 8080

CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/html"]
