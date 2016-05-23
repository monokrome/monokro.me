FROM alpine
MAINTAINER Bailey Stoner <monokrome@limpidtech.com>


RUN apk update
RUN apk add python


CMD ["python", "-m", "SimpleHTTPServer"]
