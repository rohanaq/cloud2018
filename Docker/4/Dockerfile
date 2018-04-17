FROM mysql:5.7

ENV MYSQL_ROOT_PASSWORD xyz

ENV MYSQL_USER userawan
ENV MYSQL_PASSWORD buayakecil
ENV MYSQL_DATABASE reservasi

COPY ./reservasi/reservasi.sql /docker-entrypoint-initdb.d
#RUN apt-get update && apt-get install -y apt-utils
##RUN apt-get install -y wget zip
##RUN wget https://cloud.fathoniadi.my.id/reservasi.zip
##RUN unzip reservasi.zip

##WORKDIR reservasi
#CMD mysql -uuserawan -pbuayakecil reservasi < /var/www/reservasi/reservasi.sql
