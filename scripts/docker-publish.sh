#!/usr/bin/env bash

# Download the required files
curl -s https://raw.githubusercontent.com/yabonza/yabonza-docker/master/scripts/docker-build.sh -o docker-build.sh
curl -s https://raw.githubusercontent.com/yabonza/yabonza-docker/master/scripts/docker-tools.sh -o docker-tools.sh

# Fix the file stat
chmod +x docker-build.sh
chmod +x docker-tools.sh

# Setup the docker related cli tools
./docker-tools.sh

# Run the builds
if [ $TRAVIS_BRANCH == "master" ]; then
    ./docker-build.sh "PROD" "$AWS_PROD_ACCOUNT_ID"       "$AWS_PROD_ACCESS_KEY_ID"    "$AWS_PROD_SECRET_ACCESS_KEY"
    ./docker-build.sh "PROD" "$AWS_DEV_ACCOUNT_ID"        "$AWS_DEV_ACCESS_KEY_ID"     "$AWS_DEV_SECRET_ACCESS_KEY"
    ./docker-build.sh "PROD" "$AWS_SANDBOX_ACCOUNT_ID"    "$AWS_SANDBOX_ACCESS_KEY_ID" "$AWS_SANDBOX_SECRET_ACCESS_KEY"
elif [ $TRAVIS_BRANCH == "develop" ]; then
    ./docker-build.sh "DEV" "$AWS_DEV_ACCOUNT_ID"         "$AWS_DEV_ACCESS_KEY_ID"     "$AWS_DEV_SECRET_ACCESS_KEY"
    ./docker-build.sh "DEV" "$AWS_SANDBOX_ACCOUNT_ID"     "$AWS_SANDBOX_ACCESS_KEY_ID" "$AWS_SANDBOX_SECRET_ACCESS_KEY"
else
    ./docker-build.sh "SANDBOX" "$AWS_SANDBOX_ACCOUNT_ID" "$AWS_SANDBOX_ACCESS_KEY_ID" "$AWS_SANDBOX_SECRET_ACCESS_KEY"
fi

# vim: set syn=sh :
