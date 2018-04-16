FROM ubuntu:16.04

RUN apt update && apt install -y wget apt-utils zip python2.7 python-pip
RUN apt install -y libmysqlclient-dev
RUN pip install --upgrade pip

RUN wget https://cloud.fathoniadi.my.id/reservasi.zip && unzip reservasi.zip

WORKDIR reservasi
RUN pip install -r req.txt

CMD python server.py

