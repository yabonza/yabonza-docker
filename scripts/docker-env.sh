#!/usr/bin/env bash

get-env-aws-access-key() {
    if [ "$TRAVIS_BRANCH" == "master" ]; then
        echo $AWS_PROD_ACCESS_KEY_ID
    elif [ "$TRAVIS_BRANCH" == "develop" ]; then
        echo $AWS_DEV_ACCESS_KEY_ID
    elif [ "$TRAVIS_BRANCH" == *"release"* ]; then
        echo $AWS_DEV_ACCESS_KEY_ID
    else
        echo $AWS_SANDBOX_ACCESS_KEY_ID
    fi
}

get-env-aws-access-secret() {
    if [ "$TRAVIS_BRANCH" == "master" ]; then
        echo $AWS_PROD_SECRET_ACCESS_KEY
    elif [ "$TRAVIS_BRANCH" == "develop" ]; then
        echo $AWS_DEV_SECRET_ACCESS_KEY
    elif [ "$TRAVIS_BRANCH" == *"release"* ]; then
        echo $AWS_DEV_SECRET_ACCESS_KEY
    else
        echo $AWS_SANDBOX_SECRET_ACCESS_KEY
    fi
}

get-env() {
    if [ "$TRAVIS_BRANCH" == "master" ]; then
        echo "PROD"
    elif [ "$TRAVIS_BRANCH" == "develop" ]; then
        echo "DEV"
    elif [ "$TRAVIS_BRANCH" == *"release"* ]; then
        echo "DEV"
    else
        echo "SANDBOX"
    fi
}

get-env-lower() {
    if [ "$TRAVIS_BRANCH" == "master" ]; then
        echo "prod"
    elif [ "$TRAVIS_BRANCH" == "develop" ]; then
        echo "dev"
    elif [ "$TRAVIS_BRANCH" == *"release"* ]; then
            echo "dev"
    else
        echo "sandbox"
    fi
}

get-env-build-task() {
    YABONZA_ENV="$(get-env)"
    if [ "$YABONZA_ENV" == "PROD" ]; then
        echo "build:prod"
    elif [ "$YABONZA_ENV" == "DEV" ]; then
        echo "build:dev"
    elif [ "$TRAVIS_BRANCH" == *"release"* ]; then
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
    elif [ "$TRAVIS_BRANCH" == *"release"* ]; then
        echo "bump:dev"
    elif [ "$YABONZA_ENV" == "SANDBOX" ]; then
        echo "bump:sandbox"
    fi
}

get-env-e2e-task() {
    YABONZA_ENV="$(get-env)"
    if [ "$YABONZA_ENV" == "PROD" ]; then
        echo "e2e:prod"
    elif [ "$YABONZA_ENV" == "DEV" ]; then
        echo "e2e:dev"
    elif [ "$TRAVIS_BRANCH" == *"release"* ]; then
            echo "e2e:dev"
    elif [ "$YABONZA_ENV" == "SANDBOX" ]; then
        echo "e2e:sandbox"
    fi
}

get-env-locale-lower() {
    echo $YABONZA_LOCALE_ID | tr '[:upper:]' '[:lower:]'
}

get-env-release-task() {
    YABONZA_ENV="$(get-env)"
    if [ "$YABONZA_ENV" == "PROD" ]; then
        echo "release:prod"
    elif [ "$YABONZA_ENV" == "DEV" ]; then
        echo "release:dev"
    elif [ "$TRAVIS_BRANCH" == *"release"* ]; then
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
    YABONZA_LOCALE_ID_LOWER="$(get-env-locale-lower)"
    if [ "$YABONZA_ENV" == "PROD" ]; then
        echo "prod-$YABONZA_LOCALE_ID_LOWER"
    elif [ "$YABONZA_ENV" == "DEV" ]; then
        echo "dev-$YABONZA_LOCALE_ID_LOWER"
    elif [ "$YABONZA_ENV" == "SANDBOX" ]; then
        echo "sandbox-$YABONZA_LOCALE_ID_LOWER"
    fi
}

# vim: set syn=sh :
