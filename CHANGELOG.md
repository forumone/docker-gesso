06/02/2025
----------
- Changes the base PHP image to be the Forum One php-cli image.
  - Updates the image to no use `bookworm` instead of `bullseye`.
- Updates the `Dockerfile` to reduce build times and image sizes.
- Drops on-going support for PHP 8.0.
- Drops on-going support for NodeJS 14.
- Adds support for NodeJS 24.
- Drops no longer supported Python 2.

01/28/2025
----------
* Added `node 22`

03/19/2024
----------
* Removed package: `python2`
* Updated from `buster` to `bullseye`
  * This was changed since `buster` is going EOL in June
* Added `php 8.3`
* Added `node 20` since it is the new LTS
