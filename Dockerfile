FROM monokrome/node
FROM monokrome/mongrel2

MAINTAINER Brandon R. Stoner <monokrome@monokro.me>

ADD . /usr/local/share/monokro.me/
WORKDIR /usr/local/share/monokro.me/

RUN apt-get install -y python-software-properties python g++ make
RUN make && m2sh load -db production.sqlite -config production.sqlite
RUN apt-get purge -y python-software-properties python g++ make

EXPOSE 6767

CMD ["start", "-db", "production.sqlite", "-host", "monokro.me"]
ENTRYPOINT ["m2sh"]
