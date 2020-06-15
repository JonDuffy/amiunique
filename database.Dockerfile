FROM mariadb:10.4-bionic

RUN mysqld

COPY schema/combined.sql combined.sql

RUN mysql -u root < combined.sql




