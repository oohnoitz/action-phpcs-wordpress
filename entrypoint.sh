#!/bin/sh

if [ -n "${GITHUB_WORKSPACE}" ] ; then
  cd "${GITHUB_WORKSPACE}/${INPUT_WORKDIR}" || exit
fi

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

/usr/local/bin/phpcs.phar --config-set installed_paths /tmp/wpcs

/usr/local/bin/phpcs.phar \
  --report-checkstyle \
  ${INPUT_PHPCS_ARGS:-\.} \
  | reviewdog -f="checkstyle" \
      -name="phpcs" \
      -reporter="${INPUT_REPORTER:-github-pr-check}" \
      -filter-mode="${INPUT_FILTER_MODE}" \
      -fail-on-error="${INPUT_FAIL_ON_ERROR}" \
      -level="${INPUT_LEVEL}" \
      ${INPUT_REVIEWDOG_FLAGS}
