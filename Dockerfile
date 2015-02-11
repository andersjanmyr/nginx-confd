FROM debian:jessie
MAINTAINER anders@janmyr.com

# 2015-02-11 16:15
RUN apt-get update && apt-get install nginx curl -y && \
  rm -f /etc/nginx/sites-enabled/default && \
  curl -L https://github.com/kelseyhightower/confd/releases/download/v0.7.1/confd-0.7.1-linux-amd64 -o /usr/local/bin/confd && \
  chmod +x /usr/local/bin/confd && \
  mkdir -p /etc/confd/conf.d && \
  mkdir -p /etc/confd/templates

COPY ./confd-watch.sh /usr/local/bin/confd-watch.sh
RUN chmod +x /usr/local/bin/confd-watch.sh

ONBUILD COPY ./confd /etc/confd

CMD /usr/local/bin/confd-watch.sh

