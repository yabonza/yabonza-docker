#!/usr/bin/env bash

get-env() {
    if [ "$TRAVIS_BRANCH" == "master" ]; then
        echo "PROD"
    elif [ "$TRAVIS_BRANCH" == "develop" ]; then
        echo "DEV"
    else
        echo "SANDBOX"
    fi
}

get-env-build-task() {
    YABONZA_ENV="$(get-env)"
    if [ "$YABONZA_ENV" == "PROD" ]; then
        echo "build:prod"
    elif [ "$YABONZA_ENV" == "DEV" ]; then
        echo "build:dev"
    elif [ "$YABONZA_ENV" == "SANDBOX" ]; then
        echo "build:sandbox"
    fi
}

get-env-release-task() {
    YABONZA_ENV="$(get-env)"
    if [ "$YABONZA_ENV" == "PROD" ]; then
        echo "release:prod"
    elif [ "$YABONZA_ENV" == "DEV" ]; then
        echo "release:dev"
    elif [ "$YABONZA_ENV" == "SANDBOX" ]; then
        echo "release:sandbox"
    fi
}

# vim: set syn=sh :
