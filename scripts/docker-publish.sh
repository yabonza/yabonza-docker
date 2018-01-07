#!/usr/bin/env bash

# Download the required files
curl -s -O https://raw.githubusercontent.com/yabonza/yabonza-docker/master/scripts/docker-args.sh
curl -s -O https://raw.githubusercontent.com/yabonza/yabonza-docker/master/scripts/docker-build.sh
curl -s -O https://raw.githubusercontent.com/yabonza/yabonza-docker/master/scripts/docker-env.sh
curl -s -O https://raw.githubusercontent.com/yabonza/yabonza-docker/master/scripts/docker-tools.sh

# Fix the file stat
chmod +x docker-args.sh
chmod +x docker-build.sh
chmod +x docker-env.sh
chmod +x docker-tools.sh

# Determine the env
source docker-env.sh
YABONZA_ENV="$(get-env)"

# Setup the docker related cli tools
./docker-tools.sh

# Run the builds
if [ $YABONZA_ENV == "PROD" ]; then
    ./docker-build.sh "$AWS_PROD_ACCOUNT_ID"    "$AWS_PROD_ACCESS_KEY_ID"    "$AWS_PROD_SECRET_ACCESS_KEY"
elif [ $YABONZA_ENV == "DEV" ]; then
    ./docker-build.sh "$AWS_DEV_ACCOUNT_ID"     "$AWS_DEV_ACCESS_KEY_ID"     "$AWS_DEV_SECRET_ACCESS_KEY"
elif [ $YABONZA_ENV == "SANDBOX" ]; then
    ./docker-build.sh "$AWS_SANDBOX_ACCOUNT_ID" "$AWS_SANDBOX_ACCESS_KEY_ID" "$AWS_SANDBOX_SECRET_ACCESS_KEY"
fi

# vim: set syn=sh :
