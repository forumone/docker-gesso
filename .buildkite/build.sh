#!/bin/bash

set -euo pipefail

repository=forumone/gesso

php_version="$1"
node_version="$2"
ancillary_tags="$3"

echo "--- Build"
docker build . \
  --tag "$repository:latest" \
  --tag "$ancillary_tags" \
  --build-arg PHP_VERSION="$php_version" \
  --build-arg NODE_VERSION="$node_version"

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


# Usage: should-push
#
# This function determines if the built images should be pushed up to the Docker Hub.
# There are a few conditions:
#   1. This must not be a local build,
#   2. This must not be triggered by a pull request, and
#   3. The branch being built must be master.
should-push() {
  test "$BUILDKITE_PIPELINE_PROVIDER" != local &&
    test "$BUILDKITE_PULL_REQUEST" == false &&
    test "$BUILDKITE_BRANCH" == master
}

# if should-push; then
#   echo "--- Push"
#   docker push "$repository"
# fi
