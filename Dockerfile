FROM monokrome/mongrel2
MAINTAINER Brandon R. Stoner <monokrome@monokro.me>

ADD . /usr/local/share/monokro.me/

WORKDIR /usr/local/share/monokro.me/
RUN m2sh load -db production.sqlite -config production.sqlite

EXPOSE 6767

CMD ["start", "-db", "production.sqlite", "-host", "monokro.me"]
ENTRYPOINT ["m2sh"]
