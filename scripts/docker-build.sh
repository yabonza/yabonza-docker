#!/usr/bin/env bash

# Determine the env
source docker-env.sh
YABONZA_ENV="$(get-env)"

# Set the aws variables accordingly
export AWS_ACCOUNT_ID="$1"
export AWS_ACCESS_KEY_ID="$2"
export AWS_SECRET_ACCESS_KEY="$3"

# Login to AWS
eval "$(aws ecr get-login --no-include-email --region $AWS_DEFAULT_REGION)"

# Check if the login succeeded
if [ $? != 0 ]; then
    echo "Could not log into AWS:$YABONZA_ENV"
    exit 1
fi

# The remote of where we are going to push this
AWS_REMOTE="$AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/$TRAVIS_REPO_SLUG"

# The lowercase name of the environment
ENV="$(echo $YABONZA_ENV | tr '[:upper:]' '[:lower:]')"

# Get a short sha
SHORT_SHA=${TRAVIS_COMMIT::8}

# The current timestamp
TIMESTAMP="$(date +%s000)"

# Get a unique env tag
export AWS_ENV_TAG="env-$ENV-$TIMESTAMP"

# Get the build args
source docker-args.sh
DOCKER_ARGS="$(get-args)"

# Compose the build script
DOCKER_BUILD="$(echo\
    docker build "$DOCKER_ARGS" \
    --tag "$AWS_REMOTE:$AWS_ENV_TAG" \
    --tag "$AWS_REMOTE:ci-$TRAVIS_JOB_NUMBER" \
    --tag "$AWS_REMOTE:locale-$YABONZA_LOCALE_ID" \
    --tag "$AWS_REMOTE:sha-$SHORT_SHA" \
    --tag "$AWS_REMOTE:latest" \
    .)"

# Build the image and add all of the tags
echo "$DOCKER_BUILD"
eval "$DOCKER_BUILD"

# Push all of the tags
docker push "$AWS_REMOTE:$AWS_ENV_TAG"
docker push "$AWS_REMOTE:ci-$TRAVIS_JOB_NUMBER"
docker push "$AWS_REMOTE:locale-$YABONZA_LOCALE_ID"
docker push "$AWS_REMOTE:sha-$SHORT_SHA"
docker push "$AWS_REMOTE:latest"

rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

# Invoke lambda for deployment
aws lambda invoke --function-name yabonza-deploy-lambda --payload "{\"Records\": [{\"Sns\": {\"Message\": {\"AlarmName\": \"$TRAVIS_REPO_SLUG-ecr-upload\", \"AWSAccountId\": \"$AWS_ACCOUNT_ID\"}}}]}" output.txt

# vim: set syn=sh :
