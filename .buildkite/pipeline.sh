#!/bin/bash

set -euo pipefail
shopt -s extglob

declare -A node_versions=(
  # TODO remove v10 after EOL: 2021-04-30
  [10.22.1]="node-v10"

  # # TODO remove v12 after EOL: 2022-04-30
  [12.19.0]="node-v12"

  # TODO remove v14 after EOL: 2023-04-30
  [14.14.0]="node-v14"
)

declare -A php_versions=(
  # TODO remove 7.3 after EOL: 2021-12-06
  [7.3]="php-7.3"

  # TODO remove 7.4 after EOL: 2022-11-28
  [7.4]="php-7.4"
)

declare -A gesso_versions=(
  # Key is used for tagging while the value is used for the github archive
  # This is unforunately backwards from the above due to limitations on the key in shell
  [3]='8.x-3.x'
  [4]="4.x"
)

# Usage: create-step <php_version> <node_version> <gesso_pathname> <label>
create-step() {
  local php_version="$1"
  local node_version="$2"
  local gesso_pathname="$3"
  local label="$4"

  # Output the Buildkite step for building this particular version
  cat <<YAML
  - label: ":docker: :docker-gesso: v$label"
    agents:
      queue: docker-builders
    concurrency: 6
    concurrency_group: "f1/docker"
    commands:
      - bash .buildkite/build.sh $php_version $node_version $gesso_pathname $label
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

for gesso_version in "${!gesso_versions[@]}"; do
  for node_version in "${!node_versions[@]}"; do
    for php_version in "${!php_versions[@]}"; do
      tags="${gesso_version}-${node_versions[$node_version]}-${php_versions[$php_version]}"
      create-step "$php_version" "$node_version" "${gesso_versions[$gesso_version]}" "$tags"
    done
  done
done