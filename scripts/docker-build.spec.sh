#!/usr/bin/env bash

TRAVIS_BRANCH="develop"
TRAVIS_COMMIT="abcd1234abcd1234abcd1234abcd1234abcd1234"
TRAVIS_JOB_NUMBER="42.1"
TRAVIS_REPO_SLUG="yabonza/yabonza-test"

# Determine the env
source docker-env.sh
YABONZA_ENV="$(get-env)"

# The lowercase name of the environment
ENV="$(echo $YABONZA_ENV | tr '[:upper:]' '[:lower:]')"

# Get a short sha
SHORT_SHA=${TRAVIS_COMMIT::8}

# The current timestamp
TIMESTAMP="$(date +%s000)"

# Determine the env-tag
AWS_ENV_TAG="env-$ENV-$TIMESTAMP"

# Check that the sha displays correctly
echo "$SHORT_SHA"

# Check that the env-tag displays correctly
echo "$AWS_ENV_TAG"

# vim: set syn=sh :
