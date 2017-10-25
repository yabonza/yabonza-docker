#!/usr/bin/env bash

# Set the aws variables accordingly
export AWS_ENV="$1"
export AWS_ACCOUNT_ID="$2"
export AWS_ACCESS_KEY_ID="$3"
export AWS_SECRET_ACCESS_KEY="$4"

# Login to AWS
eval "$(aws ecr get-login --no-include-email --region $AWS_DEFAULT_REGION)"

# Check if the login succeeded
if [ $? != 0 ]; then
    echo "Could not log into AWS:$AWS_ENV"
    exit 0
fi

# The remote of where we are going to push this
AWS_REMOTE="$AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/$TRAVIS_REPO_SLUG"

# Get a short sha
SHORT_SHA=${TRAVIS_COMMIT::8}

# Get a unique env tag
export AWS_ENV_TAG="$(echo $AWS_ENV | tr '[:upper:]' '[:lower:]')-$(date +%s000)"

# Compose the build script
DOCKER_BUILD="$(echo \
    docker build \
    --tag "$AWS_REMOTE:$AWS_ENV_TAG" \
    --tag "$AWS_REMOTE:ci-$TRAVIS_JOB_NUMBER" \
    --tag "$AWS_REMOTE:sha-$SHORT_SHA" \
    --tag "$AWS_REMOTE:latest" \
    .)"

# Build the image and add all of the tags
echo "$DOCKER_BUILD"
eval "$DOCKER_BUILD"

# Push all of the tags
docker push "$AWS_REMOTE:$AWS_ENV_TAG"
docker push "$AWS_REMOTE:ci-$TRAVIS_JOB_NUMBER"
docker push "$AWS_REMOTE:sha-$SHORT_SHA"
docker push "$AWS_REMOTE:latest"

# vim: set syn=sh :
