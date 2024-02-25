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
    php8-pdo_pgsql \
    bash \
    curl

RUN curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.alpine.sh' | bash
RUN apk add symfony-cli

WORKDIR /var/www/html
EXPOSE 8000
ENTRYPOINT ["symfony", "server:start", "--no-tls", "--port=8000", "--allow-http"]