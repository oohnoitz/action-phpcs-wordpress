FROM php:8.2-alpine

# tools
ENV REVIEWDOG_VERSION=v0.15.0
ENV PHPCS_VERSION=3.7.2

# rulesets
# https://github.com/WordPress/WordPress-Coding-Standards
# https://github.com/automattic/vip-coding-standards
# https://github.com/sirbrillig/phpcs-variable-analysis/releases
ENV RULESET_WP_CODING_STANDARDS_VERSION=3.0.1 \
  RULESET_VIP_CODING_STANDARDS_VERSION=3.0.0 \
  RULESET_PHPCS_VARIABLE_ANALYSIS_VERSION=2.11.17

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]

# hadolint ignore=DL3006
RUN apk --no-cache add git
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

RUN composer global config allow-plugins.dealerdirect/phpcodesniffer-composer-installer true
RUN composer global require "squizlabs/php_codesniffer:^3.0"
RUN composer global require "wp-coding-standards/wpcs:^3.0"
RUN composer global require "phpcsstandards/phpcsextra:^1.1.0"
RUN composer global require "phpcsstandards/phpcsutils:^1.0"

# tools
RUN wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh | sh -s -- -b /usr/local/bin/ ${REVIEWDOG_VERSION}

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
