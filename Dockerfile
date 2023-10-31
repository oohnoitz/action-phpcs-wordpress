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

# tools
RUN wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh | sh -s -- -b /usr/local/bin/ ${REVIEWDOG_VERSION}
RUN wget -P /usr/local/bin -q https://github.com/squizlabs/PHP_CodeSniffer/releases/download/${PHPCS_VERSION}/phpcs.phar
RUN chmod +x /usr/local/bin/phpcs.phar

# rulesets
RUN mkdir -p /tmp/rulesets
RUN wget -O - -q https://github.com/WordPress/WordPress-Coding-Standards/archive/${RULESET_WP_CODING_STANDARDS_VERSION}.tar.gz | tar zxv -C /tmp/rulesets --strip-components 1 --wildcards-match-slash --wildcards '*/WordPress*'
RUN wget -O - -q https://github.com/Automattic/VIP-Coding-Standards/archive/${RULESET_VIP_CODING_STANDARDS_VERSION}.tar.gz | tar zxv -C /tmp/rulesets --strip-components 1 --wildcards-match-slash --wildcards '*/WordPress*'
RUN wget -O - -q https://github.com/sirbrillig/phpcs-variable-analysis/archive/v${RULESET_PHPCS_VARIABLE_ANALYSIS_VERSION}.tar.gz | tar zxv -C /tmp/rulesets --strip-components 1 --wildcards-match-slash --wildcards '*/VariableAnalysis*'

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
