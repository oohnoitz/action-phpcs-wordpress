# action-phpcs-wordpress

[![Test](https://github.com/oohnoitz/action-phpcs-wordpress/workflows/Test/badge.svg)](https://github.com/oohnoitz/action-phpcs-wordpress/actions?query=workflow%3ATest)
[![reviewdog](https://github.com/oohnoitz/action-phpcs-wordpress/workflows/reviewdog/badge.svg)](https://github.com/oohnoitz/action-phpcs-wordpress/actions?query=workflow%3Areviewdog)
[![depup](https://github.com/oohnoitz/action-phpcs-wordpress/workflows/depup/badge.svg)](https://github.com/oohnoitz/action-phpcs-wordpress/actions?query=workflow%3Adepup)
[![release](https://github.com/oohnoitz/action-phpcs-wordpress/workflows/release/badge.svg)](https://github.com/oohnoitz/action-phpcs-wordpress/actions?query=workflow%3Arelease)
[![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/oohnoitz/action-phpcs-wordpress?logo=github&sort=semver)](https://github.com/oohnoitz/action-phpcs-wordpress/releases)
[![action-bumpr supported](https://img.shields.io/badge/bumpr-supported-ff69b4?logo=github&link=https://github.com/haya14busa/action-bumpr)](https://github.com/haya14busa/action-bumpr)

This action will run `phpcs` together with [reviewdog](https://github.com/reviewdog/reviewdog) to create a report for your pull requests. It was created by using the [action-template](https://github.com/reviewdog/action-template) created by the reviewdog team.

The WordPress rulesets are bundled and made available to `phpcs`.

## Input

```yaml
inputs:
  github_token:
    description: 'GITHUB_TOKEN'
    default: '${{ github.token }}'
  workdir:
    description: 'Working directory relative to the root directory.'
    default: '.'
  ### Flags for reviewdog ###
  level:
    description: 'Report level for reviewdog [info,warning,error]'
    default: 'error'
  tool_name:
    description: 'Tool name to use for reviewdog reporter'
    default: 'phpcs'
  reporter:
    description: 'Reporter of reviewdog command [github-pr-check,github-check,github-pr-review].'
    default: 'github-pr-check'
  filter_mode:
    description: |
      Filtering mode for the reviewdog command [added,diff_context,file,nofilter].
      Default is added.
    default: 'added'
  fail_on_error:
    description: |
      Exit code for reviewdog when errors are found [true,false]
      Default is `false`.
    default: 'false'
  reviewdog_flags:
    description: 'Additional reviewdog flags'
    default: ''
  ### Flags for phpcs-wordpress ###
  phpcs_args:
    description: 'Additional PHPCS flags'
    default: '.'
  phpcs_standard:
    description: 'Coding standard for PHPCS to use when checking files'
    default: 'WordPress'
```

## Usage

```yaml
name: reviewdog
on: [pull_request]
jobs:
  linter_name:
    name: runner / phpcs
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: oohnoitz/action-phpcs-wordpress@v1
        with:
          github_token: ${{ secrets.github_token }}
          # Change reviewdog reporter if you need [github-pr-check,github-check,github-pr-review].
          reporter: github-pr-review
          # Change reporter level if you need.
          # GitHub Status Check won't become failure with warning.
          level: warning
```

### PHPCS Coding Standards

The following sniffs are currently available. You can configure the standard(s) used by using the `phpcs_standard` input setting. By default, `WordPress` is used.

- MySource
- PEAR
- PHPCompatibility
- PHPCompatibilityWP
- PSR1
- PSR12
- PSR2
- Squiz
- Wordpress (default)
- WordPress-Core
- Wordpress-Docs
- WordPress-Extra
- WordPress-VIP-Go
- WordPressVIPMinimum
- Zend

## Development

### Release

#### [haya14busa/action-bumpr](https://github.com/haya14busa/action-bumpr)
You can bump version on merging Pull Requests with specific labels (bump:major,bump:minor,bump:patch).
Pushing tag manually by yourself also work.

#### [haya14busa/action-update-semver](https://github.com/haya14busa/action-update-semver)

This action updates major/minor release tags on a tag push. e.g. Update v1 and v1.2 tag when released v1.2.3.
ref: https://help.github.com/en/articles/about-actions#versioning-your-action

### Lint - reviewdog integration

This reviewdog action template itself is integrated with reviewdog to run lints
which is useful for Docker container based actions.

![reviewdog integration](https://user-images.githubusercontent.com/3797062/72735107-7fbb9600-3bde-11ea-8087-12af76e7ee6f.png)

Supported linters:

- [reviewdog/action-shellcheck](https://github.com/reviewdog/action-shellcheck)
- [reviewdog/action-hadolint](https://github.com/reviewdog/action-hadolint)
- [reviewdog/action-misspell](https://github.com/reviewdog/action-misspell)

### Dependencies Update Automation
This repository uses [haya14busa/action-depup](https://github.com/haya14busa/action-depup) to update
reviewdog version.

[![reviewdog depup demo](https://user-images.githubusercontent.com/3797062/73154254-170e7500-411a-11ea-8211-912e9de7c936.png)](https://github.com/reviewdog/action-template/pull/6)

