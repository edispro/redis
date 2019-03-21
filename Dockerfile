FROM redis:5.0.4

MAINTAINER Edispro Active <support@edispro.com>

ARG GIDDYUP_VERSION=0.19.0

RUN apt-get update \
  && apt-get install -y curl openssl ca-certificates wget \
  && update-ca-certificates \
  && mkdir -p /usr/local/etc/redis \
  && cd /usr/local/etc/redis \
  && wget https://raw.githubusercontent.com/edispro/rancher-redis-cluster/master/redis.conf \
  && chown redis:redis /usr/local/etc/redis/redis.conf 


RUN rm -rf ~/* \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD docker-entrypoint.sh /
RUN chown root:root /docker-entrypoint.sh
RUN chmod 4755 /docker-entrypoint.sh
WORKDIR /data

EXPOSE 6379

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["redis-server", "/usr/local/etc/redis/redis.conf"]
