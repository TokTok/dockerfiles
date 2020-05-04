#!/bin/sh

set -eux

if [ "${1-}" = "/bin/sh" ]; then
  exec "$@"
fi

HOST="${1-code.tox.chat}"
PORT="${2-8980}"

sed -i -e "s/@HOST@/$HOST/g" /config/worker.config
sed -i -e "s/@PORT@/$PORT/g" /config/worker.config

exec java -Djava.util.logging.config.file=/config/logging.properties -jar /buildfarm-operationqueue-worker_deploy.jar /config/worker.config
