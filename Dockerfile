FROM php:8.2-alpine

# tools
ENV REVIEWDOG_VERSION=v0.16.0
ENV PHPCS_VERSION=3.7.2
ENV COMPOSER_ALLOW_SUPERUSER=1

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]

# hadolint ignore=DL3006
RUN apk --no-cache add git
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

RUN composer global config allow-plugins.dealerdirect/phpcodesniffer-composer-installer true && \
  composer global require "squizlabs/php_codesniffer:^3.0" \
  "wp-coding-standards/wpcs:^3.0" \
  "phpcsstandards/phpcsextra:^1.1.0" \
  "phpcsstandards/phpcsutils:^1.0"

# tools
RUN wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh | sh -s -- -b /usr/local/bin/ ${REVIEWDOG_VERSION}

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
