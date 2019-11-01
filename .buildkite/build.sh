#!/bin/bash

set -euo pipefail

repository=forumone/gesso

php=7.3
node=12.13.0
node_major=12

echo "--- Build"
docker build . \
  --tag "$repository:latest" \
  --tag "$repository:php$php-node$node_major" \
  --build-arg PHP_VERSION="$php" \
  --build-arg NODE_VERSION="$node"

# Sanity check: Ensure built image is compatible with Gesso 3.x
echo "--- Test"
docker run --rm -it \
  "$repository:latest" \
  sh -c '
    curl -sSLO https://github.com/forumone/gesso/archive/8.x-3.x.zip &&
    unzip 8.x-3.x.zip &&
    cd gesso-8.x-3.x &&
    npm ci &&
    gulp build
  '

if test "$BUILDKITE_BRANCH" == master && test "$BUILDKITE_PULL_REQUEST" == false; then
  echo "--- Push"
  docker push "$repository"
fi
