#!/bin/bash

if [[ -f /bowerbird-test/tmp/pids/server.pid ]]; then
  rm -f /bowerbird-test/tmp/pids/server.pid
fi

exec "$@"