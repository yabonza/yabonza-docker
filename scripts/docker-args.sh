#!/usr/bin/env bash

get-args() {

    # Determine the env
    source docker-env.sh
    YABONZA_ENV="$(get-env)"

    # Grab the global args
    GLOBAL_ARGS="$(get-global-args)";

    # Grab the environment args
    ENV_ARGS="";
    if [ "$YABONZA_ENV" == "PROD" ]; then
        ENV_ARGS="$(get-prod-args)";
    elif [ "$YABONZA_ENV" == "DEV" ]; then
        ENV_ARGS="$(get-dev-args)";
    else
        ENV_ARGS="$(get-sandbox-args)";
    fi

    # Grab the service args
    SERVICE_ARGS="";
    if [ "$TRAVIS_REPO_SLUG" == "yabonza/yabonza-api" ]; then
        SERVICE_ARGS="$(get-api-args)";
    elif [ "$TRAVIS_REPO_SLUG" == "yabonza/yabonza-fund" ]; then
        SERVICE_ARGS="$(get-fund-args)";
    elif [ "$TRAVIS_REPO_SLUG" == "yabonza/yabonza-web" ]; then
        SERVICE_ARGS="$(get-web-args)";
    fi

    # Output the final arg list
    echo "$GLOBAL_ARGS $ENV_ARGS $SERVICE_ARGS"

}

get-global-args() {
    declare -a GLOBAL_ARGS_LIST=(
    )
    GLOBAL_ARGS=""
    for GLOBAL_ARG in "${GLOBAL_ARGS_LIST[@]}"
    do
        GLOBAL_ARGS="$GLOBAL_ARGS --build-arg ${GLOBAL_ARG}"
    done
    echo "$GLOBAL_ARGS"
}

get-prod-args() {
    declare -a PROD_ARGS_LIST=(
        "YABONZA_ENV=PROD" "AUTH0_CLIENT_SECRET=$AUTH0_PROD_CLIENT_SECRET"
    )
    PROD_ARGS=""
    for PROD_ARG in "${PROD_ARGS_LIST[@]}"
    do
        PROD_ARGS="$PROD_ARGS --build-arg ${PROD_ARG}"
    done
    echo "$PROD_ARGS"
}

get-dev-args() {
    declare -a DEV_ARGS_LIST=(
        "YABONZA_ENV=DEV" "AUTH0_CLIENT_SECRET=$AUTH0_DEV_CLIENT_SECRET"
    )
    DEV_ARGS=""
    for DEV_ARG in "${DEV_ARGS_LIST[@]}"
    do
        DEV_ARGS="$DEV_ARGS --build-arg ${DEV_ARG}"
    done
    echo "$DEV_ARGS"
}

get-sandbox-args() {
    declare -a SANDBOX_ARGS_LIST=(
        "YABONZA_ENV=SANDBOX" "AUTH0_CLIENT_SECRET=$AUTH0_SANDBOX_CLIENT_SECRET"
    )
    SANDBOX_ARGS=""
    for SANDBOX_ARG in "${SANDBOX_ARGS_LIST[@]}"
    do
        SANDBOX_ARGS="$SANDBOX_ARGS --build-arg ${SANDBOX_ARG}"
    done
    echo "$SANDBOX_ARGS"
}

get-api-args() {
    declare -a API_ARGS_LIST=(
    )
    API_ARGS=""
    for API_ARG in "${API_ARGS_LIST[@]}"
    do
        API_ARGS="$API_ARGS --build-arg ${API_ARG}"
    done
    echo "$API_ARGS"
    # Example: Add the fund args to the api args
    # FUND_ARGS="$(get-fund-args)";
    # echo "$FUND_ARGS $API_ARGS"
}

get-fund-args() {
    declare -a FUND_ARGS_LIST=(
        "SPRING_PROFILES_ACTIVE:$YABONZA_ENV"
    )
    FUND_ARGS=""
    for FUND_ARG in "${FUND_ARGS_LIST[@]}"
    do
        FUND_ARGS="$FUND_ARGS --build-arg ${FUND_ARG}"
    done
    echo "$FUND_ARGS"
}

get-web-args() {
    declare -a WEB_ARGS_LIST=(
        "NPM_TOKEN:$NPM_TOKEN"
    )
    WEB_ARGS=""
    for WEB_ARG in "${WEB_ARGS_LIST[@]}"
    do
        WEB_ARGS="$WEB_ARGS --build-arg ${WEB_ARG}"
    done
    echo "$WEB_ARGS"
}

# vim: set syn=sh :
