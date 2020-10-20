#!/bin/bash

set -euo pipefail
shopt -s extglob

gesso_version="2"

declare -A node_versions=(
  # TODO remove v10 after EOL: 2021-04-30
  [10.22.1]="node-v10"

  # TODO remove v12 after EOL: 2022-04-30
  [12.19.0]="node-v12 node-lts node-stable"

  # TODO remove v14 after EOL: 2023-04-30
  [14.14.0]="node-v14 node-current node-latest"
)

declare -A php_versions=(
  # TODO remove 7.3 after EOL: 2021-12-06
  [7.3]="php-7.3"

  # TODO remove 7.4 after EOL: 2022-11-28
  [7.4]="php-7.4 php-latest"
)

# Usage: create-step <php_version> <node_version> <tags> <label>
create-step() {
  local php_version="$1"
  local node_version="$2"
  local tags="$3 $4"
  local label="$4"

  # Output the Buildkite step for building this particular version
  cat <<YAML
  - label: ":docker: :docker-gesso: v$label"
    concurrency: 5
    concurrency_group: "f1/docker"
    commands:
      - bash .buildkite/build.sh $php_version $node_version $tags
YAML

  # Use authentication plugins if we're building somewhere other than on a local machine
  if test "${BUILDKITE_PROJECT_PROVIDER:-local}" != local; then
    cat <<YAML
    plugins:
      - seek-oss/aws-sm#v2.0.0:
          env:
            DOCKER_LOGIN_PASSWORD: buildkite/dockerhubid
      - docker-login#v2.0.1:
          username: f1builder
          password-env: DOCKER_LOGIN_PASSWORD
YAML
  fi
}

for node_version in "${!node_versions[@]}"; do
  for php_version in "${!php_versions[@]}"; do
    tags="${node_versions[$node_version]} ${php_versions[$php_version]}"
    label="${gesso_version}-$php_version-$node_version"
    create-step "$php_version" "$node_version" "$tags" "$label"
  done
done
