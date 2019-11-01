ARG PHP_VERSION
FROM php:${PHP_VERSION}-cli-alpine

ARG NODE_VERSION

RUN set -ex \
  && cd /tmp \
  && apk add --no-cache libstdc++ \
  && apk add --no-cache --virtual .build-deps \
    binutils-gold \
    curl \
    g++ \
    gcc \
    gnupg \
    libgcc \
    linux-headers \
    make \
    python \
  && curl --fail --show-error --silent --remote-name "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}.tar.xz" \
  && curl --fail --show-error --silent --remote-name "https://nodejs.org/dist/v${NODE_VERSION}/SHASUMS256.txt" \
  && grep " node-v${NODE_VERSION}.tar.xz\$" SHASUMS256.txt | sha256sum -c - \
  && tar -xf "node-v${NODE_VERSION}.tar.xz" \
  && cd "node-v${NODE_VERSION}" \
  && ./configure \
  && make -j$(nproc) \
  && make install \
  && cd /tmp \
  && rm -r "node-v${NODE_VERSION}" "node-v${NODE_VERSION}.tar.xz" SHASUMS256.txt \
  && apk del .build-deps \
  && npm i -g gulp-cli
