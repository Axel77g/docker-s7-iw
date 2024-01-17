FROM alpine

# update packages
RUN apk update && apk upgrade

# add postgresql server
RUN apk add postgresql
WORKDIR /run/postgresql
RUN chown postgres:postgres -R /run/postgresql

# change user to postgres
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /var/lib/postgresql/data
RUN chown postgres:postgres -R /var/lib/postgresql/data
RUN chmod 0700 /var/lib/postgresql/data

USER postgres

RUN initdb -D /var/lib/postgresql/data

#define env by default
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=postgres
ENV POSTGRES_DB=postgres

#authorize remote access
RUN sed -i -e 's/^#listen_addresses = .*$/listen_addresses = '\''*'\''/' /var/lib/postgresql/data/postgresql.conf
#authorize all hosts to connect
RUN echo "host all all 0.0.0.0/0 md5" >> /var/lib/postgresql/data/pg_hba.conf

EXPOSE 5432

ENTRYPOINT ["/bin/sh", "/usr/local/bin/entrypoint.sh"]

