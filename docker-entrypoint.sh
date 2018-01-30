#!/bin/bash

# Ensure we don't have two containers simultaneously running "bundle install"
until [ ! -f .bundle-install-lock ]; do
  >&2 echo "Another container is running 'bundle install' - waiting"
  sleep 5
done

touch .bundle-install-lock
# Ensure all gems installed. Add binstubs to bin which has been added to PATH in Dockerfile.
bundle check || bundle install --binstubs="$BUNDLE_BIN"
rm -f .bundle-install-lock

# Clean up a potential leftover Rails pid file
rm -f /tmp/rails-server.pid

# Finally call command issued to the docker service
exec "$@"
