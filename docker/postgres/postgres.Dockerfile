FROM alpine

RUN apk update --no-cache && apk upgrade --no-cache

RUN apk add postgresql

WORKDIR /run/postgresql

RUN chown postgres:postgres /run/postgresql/

USER postgres

WORKDIR /usr/app

COPY . .

RUN chmod 0700 /usr/app

WORKDIR /var/lib/postgresql

WORKDIR /var/lib/postgresql/data

RUN chmod 0700 /var/lib/postgresql/data

ENTRYPOINT [ "/bin/sh /usr/app/entrypoint.sh" ] 