#!/bin/bash


sed -i -E "s/^ *bind +.*$/bind 0.0.0.0/g" /usr/local/etc/redis/redis.conf



if [ -n "${REDIS_TIMEOUT}" ]; then
	sed -i -E "s/^[ #]*timeout .*$/timeout ${REDIS_TIMEOUT}/" /usr/local/etc/redis/redis.conf
fi


  sed -i -E "s/^.*requirepass +.*$/requirepass $REDIS_PASSWORD/g" /usr/local/etc/redis/redis.conf
    sed -i -E "s/^.*protected-mode +.*$/protected-mode no/g" /usr/local/etc/redis/redis.conf
exec docker-entrypoint.sh "$@"
