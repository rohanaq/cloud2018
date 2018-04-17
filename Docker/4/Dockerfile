FROM mysql:5.7

ENV MYSQL_ROOT_PASSWORD xyz

ENV MYSQL_USER userawan
ENV MYSQL_PASSWORD buayakecil
ENV MYSQL_DATABASE reservasi

COPY ./reservasi.sql /docker-entrypoint-initdb.d
