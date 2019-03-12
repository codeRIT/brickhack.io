#!/bin/bash

# Ensure all gems installed. Add binstubs to bin which has been added to PATH in Dockerfile.
bundle check || bundle install --binstubs="$BUNDLE_BIN"

# Clean up a potential leftover Rails pid file
rm -f /tmp/rails-server.pid

# Finally call command issued to the docker service
exec "$@"
