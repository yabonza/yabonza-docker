#!/usr/bin/env bash

TRAVIS_BRANCH="develop"
TRAVIS_COMMIT="abcd1234abcd1234abcd1234abcd1234abcd1234"
TRAVIS_JOB_NUMBER="42.1"
TRAVIS_REPO_SLUG="yabonza/yabonza-test"

# Determine the env
source docker-env.sh
YABONZA_ENV="$(get-env)"

# Check that the env is correct
echo "$YABONZA_ENV"

# vim: set syn=sh :
