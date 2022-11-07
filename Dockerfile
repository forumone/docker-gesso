ARG NODE_VERSION
ARG PHP_VERSION

FROM node:${NODE_VERSION}-alpine3.15 as nodeJs

USER root

RUN chown -R root:root /opt

FROM php:${PHP_VERSION}-cli-alpine3.15

RUN apk add --no-cache libstdc++ \
    python3 \
    python2 \
    make \
    g++

# This is needed forhte time being since node module: fiber is being used in gesso
# https://github.com/forumone/gesso/issues/626
RUN apk add --virtual .build-deps

RUN apk del .build-deps

# Instead of building node from source, just pulling a compiled version already
COPY --from=nodeJs /usr/local/bin/node /usr/local/bin/node
COPY --from=nodeJs /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=nodeJs /opt /opt

# Making the correct symlinks needed for node
RUN ln -s ../lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm
RUN ln -s ../lib/node_modules/npm/bin/npx-cli.js /usr/local/bin/npx
RUN ln -s /opt/*/bin/yarn /usr/local/bin/yarn
RUN ln -s /opt/*/bin/yarnpkg /usr/local/bin/yarnpkg

RUN npm i -g envinfo gulp-cli


# Default working directory to /app - this gives folks a predicable location for builds
# and artifacts.
WORKDIR /app

# Due to https://github.com/tabrindle/envinfo/issues/81, we have to make sure that --system
# isn't passed since the command will hang indefinitely otherwise.
CMD [ "envinfo", "--title=Tools in this container", "--npmGlobalPackages", "--languages", "--managers", "--binaries" ]
