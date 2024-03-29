#!/bin/sh

if [ -n "${GITHUB_WORKSPACE}" ]; then
  cd "${GITHUB_WORKSPACE}/${INPUT_WORKDIR}" || exit
  git config --global --add safe.directory "${GITHUB_WORKSPACE}" || exit 1
fi

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

/root/.composer/vendor/bin/phpcs \
  --report-checkstyle \
  --standard="${INPUT_PHPCS_STANDARD}" \
  ${INPUT_PHPCS_ARGS:-\.} |
  reviewdog -f="checkstyle" \
    -name="${INPUT_TOOL_NAME}" \
    -reporter="${INPUT_REPORTER:-github-pr-check}" \
    -filter-mode="${INPUT_FILTER_MODE}" \
    -fail-on-error="${INPUT_FAIL_ON_ERROR}" \
    -level="${INPUT_LEVEL}" \
    ${INPUT_REVIEWDOG_FLAGS}
