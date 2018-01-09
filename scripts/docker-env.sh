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

get-env-tag() {
    YABONZA_ENV="$(get-env)"
    if [ "$YABONZA_ENV" == "PROD" ]; then
        echo "prod"
    elif [ "$YABONZA_ENV" == "DEV" ]; then
        echo "dev"
    elif [ "$YABONZA_ENV" == "SANDBOX" ]; then
        echo "sandbox"
    fi
}

get-env-ui() {
    YABONZA_ENV="$(get-env)"
    if [ "$YABONZA_ENV" == "PROD" ]; then
        echo "@yabonza/yabonza-ui@prod"
    elif [ "$YABONZA_ENV" == "DEV" ]; then
        echo "@yabonza/yabonza-ui@dev"
    elif [ "$YABONZA_ENV" == "SANDBOX" ]; then
        echo "@yabonza/yabonza-ui@sandbox"
    fi
}

get-env-version-task() {
    YABONZA_ENV="$(get-env)"
    if [ "$YABONZA_ENV" == "PROD" ]; then
        echo "version:prod"
    elif [ "$YABONZA_ENV" == "DEV" ]; then
        echo "version:dev"
    elif [ "$YABONZA_ENV" == "SANDBOX" ]; then
        echo "version:sandbox"
    fi
}

# vim: set syn=sh :
