#!/usr/bin/env bash

get-branch-rp() {
    if [ "$TRAVIS_BRANCH" == "master" ]; then
        echo "master"
    elif [ "$TRAVIS_BRANCH" == "develop" ]; then
        echo "develop"
    else
        echo "feature/bastian"
    fi
}

trigger-build() {
    export RP_BRANCH=$(get-branch-rp)
    body="{
        \"request\": {
        \"branch\":\"$RP_BRANCH\"
    }}"

    curl -s -X POST \
    -H "Content-Type: application/json" \
    -H "Accept: application/json" \
    -H "Travis-API-Version: 3" \
    -H "Authorization: token $TRAVIS_TRIGGER_TOKEN"\
    -d "$body" \
    https://api.travis-ci.com/repo/yabonza%2Fyabonza-reverse-proxy/requests
}

trigger-build
