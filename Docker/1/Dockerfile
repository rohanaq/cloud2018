# Asumsi: db ada di localhost. Belum dites

FROM ubuntu:16.04

RUN apt update && apt install -y zip python2.7 python-pip
RUN echo mysql-server mysql-server/root_password password xyz | debconf-set-selections
RUN echo mysql-server mysql-server/root_password_again password xyz | debconf-set-selections
RUN apt install mysql-server libmysqlclient-dev
RUN pip install --upgrade pip

RUN wget https://cloud.fathoniadi.my.id/reservasi.zip && unzip reservasi.zip

WORKDIR reservasi
RUN pip install -r req.txt
RUN mysql -uroot -pxyz -e "create database reservasi;" && mysql -uroot -pxyz reservasi < reservasi.sql
ENV DB_HOST localhost
ENV DB_USERNAME root
ENV DB_PASSWORD xyz
ENV DB_NAME reservasi

# Last part: run "python server.py"
