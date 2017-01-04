FROM alpine:latest
MAINTAINER Bailey Stoner <monokrome@monokro.me>


RUN apk update
RUN apk upgrade
RUN apk add ca-certificates
RUN apk add build-base linux-headers
RUN apk add libressl libressl-dev
RUN apk add libpcre32 pcre-dev
RUN apk add python3 python3-dev
RUN easy_install-3.5 pip


RUN pip install --upgrade pip


ADD . /opt/mk
WORKDIR /opt/mk


RUN pip install .


EXPOSE 6100


CMD ["uwsgi", "--ini", "etc/production.ini", "--plugin", "python"]
