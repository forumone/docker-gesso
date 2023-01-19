# About this Image

This image is intended to be used as a base for building [Gesso](https://github.com/forumone/gesso/). For local development, the project's sources can be bind-mounted. During production builds, this image is meant to be used as part of a multi-stage build.

## Tags and Included Tools

### Gesso 3 & 4

Image tags for Gesso 3 & 4 are derived from a set of the following components:

#### Node Version

* 12
* 14
* 16

#### PHP Version

* 7.4
* 8.0

#### Gesso Version

* 3
* 4

#### Linux distro

* alpine
* debian

These components are used to derive the image tag thusly:

`forumone/gesso:{gesso-version}-node-v{node-version}-php-{php-version}-{linux-distro}`

For instance an image with Gesso 4, Node 12, php 7.4, and alpine would have the following image tag:

`forumone/gesso:4-node-v12-php-7.4-alpine`

### Gesso 2

We provide a large number of images for Gesso 2.x due to the increased variation in configurations.

| Node Version | PHP Version | Image                             |
| ------------ | ----------- | --------------------------------- |
| v4           | 5.6         | forumone/gesso:2-node-v4-php-5.6  |
| v4           | 7.0         | forumone/gesso:2-node-v4-php-7.0  |
| v4           | 7.1         | forumone/gesso:2-node-v4-php-7.1  |
| v4           | 7.2         | forumone/gesso:2-node-v4-php-7.2  |
| v4           | 7.3         | forumone/gesso:2-node-v4-php-7.3  |
| v4           | 7.4         | forumone/gesso:2-node-v4-php-7.4  |
| v6           | 5.6         | forumone/gesso:2-node-v6-php-5.6  |
| v6           | 7.0         | forumone/gesso:2-node-v6-php-7.0  |
| v6           | 7.1         | forumone/gesso:2-node-v6-php-7.1  |
| v6           | 7.2         | forumone/gesso:2-node-v6-php-7.2  |
| v6           | 7.3         | forumone/gesso:2-node-v6-php-7.3  |
| v6           | 7.4         | forumone/gesso:2-node-v6-php-7.4  |
| v8           | 5.6         | forumone/gesso:2-node-v8-php-5.6  |
| v8           | 7.0         | forumone/gesso:2-node-v8-php-7.0  |
| v8           | 7.1         | forumone/gesso:2-node-v8-php-7.1  |
| v8           | 7.2         | forumone/gesso:2-node-v8-php-7.2  |
| v8           | 7.3         | forumone/gesso:2-node-v8-php-7.3  |
| v8           | 7.4         | forumone/gesso:2-node-v8-php-7.4  |
| v10          | 5.6         | forumone/gesso:2-node-v10-php-5.6 |
| v10          | 7.0         | forumone/gesso:2-node-v10-php-7.0 |
| v10          | 7.1         | forumone/gesso:2-node-v10-php-7.1 |
| v10          | 7.2         | forumone/gesso:2-node-v10-php-7.2 |
| v10          | 7.3         | forumone/gesso:2-node-v10-php-7.3 |
| v10          | 7.4         | forumone/gesso:2-node-v10-php-7.4 |
| v12          | 5.6         | forumone/gesso:2-node-v12-php-5.6 |
| v12          | 7.0         | forumone/gesso:2-node-v12-php-7.0 |
| v12          | 7.1         | forumone/gesso:2-node-v12-php-7.1 |
| v12          | 7.2         | forumone/gesso:2-node-v12-php-7.2 |
| v12          | 7.3         | forumone/gesso:2-node-v12-php-7.3 |
| v12          | 7.4         | forumone/gesso:2-node-v12-php-7.4 |

## Source

Images here are built from two repositories:

* Gesso 3.x & 4.x uses [forumone/docker-gesso](https://github.com/forumone/docker-gesso) on GitHub.
* Gesso 2.x uses [forumone/docker-f1ux](https://github.com/forumone/docker-f1ux) on GitHub.
