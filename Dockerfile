ARG NODE_VERSION
ARG PHP_VERSION

FROM node:${NODE_VERSION}-bookworm as nodeJs

USER root

RUN chown -R root:root /opt

FROM public.ecr.aws/forumone/php-cli:${PHP_VERSION}

## This is needed for the time being since node module: fiber is being used in gesso
## https://github.com/forumone/gesso/issues/626
# Base persistent dependencies
RUN set -eux \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
    python3 \
  && rm -rf /var/lib/apt/lists/*

# Instead of building NodeKS from source, just pulling a compiled version already.
COPY --from=nodeJs /usr/local/bin/node /usr/local/bin/node
COPY --from=nodeJs /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=nodeJs /opt /opt

# Making the correct symlinks needed for NodeJS.
RUN set -eux \
  && ln -s ../lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm \
  && ln -s ../lib/node_modules/npm/bin/npx-cli.js /usr/local/bin/npx \
  && ln -s /opt/*/bin/yarn /usr/local/bin/yarn \
  && ln -s /opt/*/bin/yarnpkg /usr/local/bin/yarnpkg

# Install required global NPM packages.
RUN npm i -g envinfo gulp-cli pm2

# Default working directory to /app - this gives folks a predicable location for builds
# and artifacts.
WORKDIR /app

RUN apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false

# Due to https://github.com/tabrindle/envinfo/issues/81, we have to make sure that --system
# isn't passed since the command will hang indefinitely otherwise.
CMD [ "envinfo", "--title=Tools in this container", "--npmGlobalPackages", "--languages", "--managers", "--binaries" ]
