FROM php:7.4-alpine

ENV REVIEWDOG_VERSION=v0.10.2
ENV PHPCS_VERSION=3.5.6

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]

# hadolint ignore=DL3006
RUN apk --no-cache add git

RUN wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh | sh -s -- -b /usr/local/bin/ ${REVIEWDOG_VERSION}
RUN wget -P /usr/local/bin -q https://github.com/squizlabs/PHP_CodeSniffer/releases/download/${PHPCS_VERSION}/phpcs.phar
RUN chmod +x /usr/local/bin/phpcs.phar
RUN git clone -b master https://github.com/WordPress/WordPress-Coding-Standards.git /tmp/wpcs

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
