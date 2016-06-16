FROM alpine
MAINTAINER Bailey Stoner <monokrome@monokro.me>


RUN apk update


WORKDIR /opt/
RUN apk add git build-base
RUN git clone https://github.com/sass/sassc


WORKDIR /opt/sassc
RUN git clone https://github.com/sass/libsass
RUN SASS_LIBSASS_PATH=/opt/sassc/libsass make
RUN mv bin/sassc /usr/bin/sass


WORKDIR /opt/
RUN rm -rf sassc


RUN apk add python
RUN apk add nodejs


ADD . /opt/monokro.me
WORKDIR /opt/monokro.me


RUN npm install


RUN apk del git build-base
RUN apk add libstdc++
RUN rm -rf /var/cache/apk/*


RUN make


EXPOSE 8000


WORKDIR /opt/monokro.me/dist
CMD ["python", "-m", "SimpleHTTPServer"]
