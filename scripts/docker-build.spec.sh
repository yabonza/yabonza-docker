#!/usr/bin/env bash

TRAVIS_BRANCH="develop"
TRAVIS_COMMIT="abcd1234abcd1234abcd1234abcd1234abcd1234"
TRAVIS_JOB_NUMBER="42.1"
TRAVIS_REPO_SLUG="yabonza/yabonza-test"

# Determine the env
source docker-env.sh
YABONZA_ENV="$(get-env)"

# Get a short sha
SHORT_SHA=${TRAVIS_COMMIT::8}

# Check that the sha is correct
echo "$SHORT_SHA"

# Determine the env-tag
AWS_ENV_TAG="env-$(echo $YABONZA_ENV | tr '[:upper:]' '[:lower:]')-$(date +%s000)"

# Check that the env-tag is correct
echo "$AWS_ENV_TAG"

# vim: set syn=sh :
