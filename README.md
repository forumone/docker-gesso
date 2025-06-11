# About this Image

This image is intended to be used as a base for building [Gesso](https://github.com/forumone/gesso/). For local development, the project's sources can be bind-mounted. During production builds, this image is meant to be used as part of a multi-stage build.

## Tags

* Supported Node.js versions: 24, 22, 20, 18, 16, 14
* Supported PHP versions: 8.3, 8.2, 8.1

These components are used to derive the image tag thusly:

`forumone/gesso:node-v${NODE_VERSION}-php-${PHP_VERSION}`

For instance an image with Node.js 18, and PHP 8.2 would have the following image tag: `forumone/gesso:node-v18-php-8.2`

## Included Tools

In addition to the included npm and yarn package managers, we globally install the following:

* `envinfo`
* `gulp-cli`
* `pm2`
