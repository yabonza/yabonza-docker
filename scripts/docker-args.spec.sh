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

# Run all of the other functions
SPEC_GLOBAL_ARGS="$(get-global-args)"
SPEC_PROD_ARGS="$(get-prod-args)"
SPEC_DEV_ARGS="$(get-dev-args)"
SPEC_SANDBOX_ARGS="$(get-sandbox-args)"
SPEC_API_ARGS="$(get-api-args)"
SPEC_FUND_ARGS="$(get-fund-args)"
SPEC_WEB_ARGS="$(get-web-args)"

# Check that they are all correct
echo "$SPEC_GLOBAL_ARGS"
echo "$SPEC_PROD_ARGS"
echo "$SPEC_DEV_ARGS"
echo "$SPEC_SANDBOX_ARGS"
echo "$SPEC_API_ARGS"
echo "$SPEC_FUND_ARGS"
echo "$SPEC_WEB_ARGS"

# vim: set syn=sh :
