#!/usr/bin/env bash

TRAVIS_BRANCH="develop"
TRAVIS_COMMIT="abcd1234abcd1234abcd1234abcd1234abcd1234"
TRAVIS_JOB_NUMBER="42.1"
TRAVIS_REPO_SLUG="yabonza/yabonza-test"

# Determine the args
source docker-args.sh
DOCKER_ARGS="$(get-args)"

# Check that the args are correct
echo "$DOCKER_ARGS"

# vim: set syn=sh :
