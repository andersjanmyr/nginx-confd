FROM nginx:1.7.1
MAINTAINER anders@janmyr.com

ADD https://github.com/kelseyhightower/confd/releases/download/v0.8.0/confd-0.8.0-linux-amd64 /usr/bin/confd
RUN chmod +x /usr/bin/confd && \
  rm -f /etc/nginx/conf.d/* && \
  mkdir -p /etc/nginx/conf.d && \
  mkdir -p /etc/confd/conf.d && \
  mkdir -p /etc/confd/templates

COPY ./confd-watch.sh /usr/bin/confd-watch.sh
RUN chmod +x /usr/bin/confd-watch.sh

ONBUILD COPY ./confd /etc/confd

CMD /usr/bin/confd-watch.sh

