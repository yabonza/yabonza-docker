#!/usr/bin/env bash

TRAVIS_BRANCH="develop"
TRAVIS_COMMIT="abcd1234abcd1234abcd1234abcd1234abcd1234"
TRAVIS_JOB_NUMBER="42.1"
TRAVIS_REPO_SLUG="yabonza/yabonza-test"

# Determine the env
source docker-env.sh
SPEC_YABONZA_ENV="$(get-env)"

# Check that the env is correct
echo "$YABONZA_ENV"

# Run all of the other functions
SPEC_BUILD_TASK="$(get-env-build-task)"
SPEC_BUMP_TASK="$(get-env-bump-task)"
SPEC_LOCALE_LOWER="$(get-env-locale-lower)"
SPEC_RELEASE_TASK="$(get-env-release-task)"
SPEC_UI_TAG="$(get-env-ui-tag)"
SPEC_UI="$(get-env-ui)"

# Check that they are all correct
echo "$SPEC_BUILD_TASK"
echo "$SPEC_BUMP_TASK"
echo "$SPEC_LOCALE_LOWER"
echo "$SPEC_RELEASE_TASK"
echo "$SPEC_UI_TAG"
echo "$SPEC_UI"

# vim: set syn=sh :
