#!/bin/sh

set -eux

if [ "${1-}" = "/bin/sh" ]; then
  exec "$@"
fi

PORT="${1-8980}"

sed -i -e "s/@PORT@/$PORT/g" /config/server.config

exec java -Djava.util.logging.config.file=/config/logging.properties -jar /buildfarm-server_deploy.jar /config/server.config
