#!/bin/bash

set -euo pipefail

repository=forumone/gesso

php_version="$1"
node_version="$2"
gesso_pathname="$3"
ancillary_tags="$4"

echo "--- Build"

# Holds arguments to docker build
docker_args=()
tag=''

for tag in $ancillary_tags; do
  tag="$repository:$tag"
  docker_args+=(--tag $tag)
done

docker build . \
  "${docker_args[@]}" \
  --build-arg PHP_VERSION="$php_version" \
  --build-arg NODE_VERSION="$node_version"

# Sanity check: Ensure built image is compatible with Gesso 4.x
echo "--- Test"
docker run --rm -it \
  "$tag" \
  sh -c "
    curl -sSLO \"https://github.com/forumone/gesso/archive/${gesso_pathname}.zip\" &&
    unzip \"${gesso_pathname}.zip\" &&
    cd \"gesso-${gesso_pathname}\" &&
    npm ci &&
    gulp build
  "

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

if should-push; then
  echo "--- Push"
  docker push --all-tags "$repository"
fi
