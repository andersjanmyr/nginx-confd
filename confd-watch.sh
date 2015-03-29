#!/bin/bash

# Fail hard and fast
set -eo pipefail

export CONFD_NODE=${CONFD_NODE}:172.17.42.1:4001

echo "[nginx] booting container. CONFD_NODE: $CONFD_NODE"

# Loop until confd has updated the nginx config
until confd -onetime -node $CONFD_NODE -config-file /etc/confd/conf.d/nginx.toml; do
  echo "[nginx] waiting for confd to refresh nginx.conf"
  sleep 5
done

# Run confd in the background to watch the upstream servers
/usr/local/bin/confd -interval 10 -node $CONFD_NODE -config-file /etc/confd/conf.d/nginx.toml &
echo "[nginx] confd is listening for changes on etcd..."

# Start nginx
echo "[nginx] starting nginx service..."
service nginx start

# Tail all nginx log files
tail -f /var/log/nginx/*.log
