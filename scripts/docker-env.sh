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

get-env-bump-task() {
    YABONZA_ENV="$(get-env)"
    if [ "$YABONZA_ENV" == "PROD" ]; then
        echo "bump:prod"
    elif [ "$YABONZA_ENV" == "DEV" ]; then
        echo "bump:dev"
    elif [ "$YABONZA_ENV" == "SANDBOX" ]; then
        echo "bump:sandbox"
    fi
}

get-env-locale-lower() {
    echo $YABONZA_LOCALE | tr '[:upper:]' '[:lower:]'
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

get-env-ui() {
    YABONZA_ENV="$(get-env)"
    YABONZA_UI_TAG="$(get-env-ui-tag)"
    if [ "$YABONZA_ENV" == "PROD" ]; then
        echo "@yabonza/yabonza-ui@$YABONZA_UI_TAG"
    elif [ "$YABONZA_ENV" == "DEV" ]; then
        echo "@yabonza/yabonza-ui@$YABONZA_UI_TAG"
    elif [ "$YABONZA_ENV" == "SANDBOX" ]; then
        echo "@yabonza/yabonza-ui@$YABONZA_UI_TAG"
    fi
}

get-env-ui-tag() {
    YABONZA_ENV="$(get-env)"
    YABONZA_LOCALE_LOWER="$(get-env-locale-lower)"
    if [ "$YABONZA_ENV" == "PROD" ]; then
        echo "prod-$YABONZA_LOCALE_LOWER"
    elif [ "$YABONZA_ENV" == "DEV" ]; then
        echo "dev-$YABONZA_LOCALE_LOWER"
    elif [ "$YABONZA_ENV" == "SANDBOX" ]; then
        echo "sandbox-$YABONZA_LOCALE_LOWER"
    fi
}

# vim: set syn=sh :
