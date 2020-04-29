#!/bin/bash

set -eux

exec /opt/kythe/tools/http_server \
  --serving_table /data/kythe_tables \
  --public_resources /data/resources/public \
  --listen "0.0.0.0:$PORT" \
  "$@"
