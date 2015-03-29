FROM nginx:1.7.1
MAINTAINER anders@janmyr.com

# 2015-02-11 16:15

ADD https://github.com/kelseyhightower/confd/releases/download/v0.8.0/confd-0.8.0-linux-amd64 /usr/local/bin/confd
RUN rm -f /etc/nginx/sites-enabled/default \
  chmod +x /usr/local/bin/confd && \
  mkdir -p /etc/confd/conf.d && \
  mkdir -p /etc/confd/templates

COPY ./confd-watch.sh /usr/local/bin/confd-watch.sh
RUN chmod +x /usr/local/bin/confd-watch.sh

ONBUILD COPY ./confd /etc/confd

CMD /usr/local/bin/confd-watch.sh

