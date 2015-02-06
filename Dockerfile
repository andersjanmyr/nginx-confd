FROM ubuntu:14.04
MAINTAINER anders@janmyr.com

# 2015-02-06 12:42
RUN apt-get update && apt-get install nginx curl -y
RUN rm -f /etc/nginx/sites-enabled/default

RUN curl -L https://github.com/kelseyhightower/confd/releases/download/v0.6.3/confd-0.6.3-linux-amd64 -o /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd

RUN mkdir -p /etc/confd/{conf.d,templates}
COPY ./confd-watch.sh /usr/local/bin/confd-watch.sh
RUN chmod +x /usr/local/bin/confd-watch.sh

ONBUILD COPY ./confd /etc/confd

CMD /usr/local/bin/confd-watch.sh

