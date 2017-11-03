#!/usr/bin/env node

const fs = require(`fs`);
const path = require(`path`);

const {
    AWS_DEFAULT_REGION,
    AWS_SANDBOX_ACCOUNT_ID,
    YABONZA_POSTGRES_PASSWORD,
    YABONZA_POSTGRES_USER,
} = process.env;

const DOCKER_COMPOSE_VERSION = `2`;

const YABONZA_ENV = `SANDBOX`;

const YABONZA_API_NAME = `api`;
const YABONZA_API_PORT = `4000`;

const YABONZA_FUND_NAME = `fund`;
const YABONZA_FUND_PORT = `8080`;

const YABONZA_MONGODB_NAME = `mongodb`;
const YABONZA_MONGODB_IMAGE = `mongo`;
const YABONZA_MONGODB_PORT = `27017`;

const YABONZA_PERMIT_NAME = `permit`;
const YABONZA_PERMIT_PORT = `8111`;

const YABONZA_POSTGRES_IMAGE = `postgres`;
const YABONZA_POSTGRES_NAME = `postgres`;
const YABONZA_POSTGRES_PORT = `5432`;

const YABONZA_UI_NAME = `ui`;
const YABONZA_UI_PORT = `4200`;

const YABONZA_WEB_NAME = `web`;
const YABONZA_WEB_PORT = `3000`;

const data = `
version: "${DOCKER_COMPOSE_VERSION}"
services:

  ${YABONZA_API_NAME}:
    build: yabonza-${YABONZA_API_NAME}
    environment:
      - YABONZA_ENV=${YABONZA_ENV}
    links:
      - ${YABONZA_FUND_NAME}
      - ${YABONZA_MONGODB_NAME}
    ports:
      - "${YABONZA_API_PORT}:${YABONZA_API_PORT}"

  ${YABONZA_FUND_NAME}:
    # build: yabonza-${YABONZA_FUND_NAME}
    environment:
      - YABONZA_ENV=${YABONZA_ENV}
    image: ${AWS_SANDBOX_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/yabonza/yabonza-${YABONZA_FUND_NAME}:latest
    links:
      - ${YABONZA_POSTGRES_NAME}
    ports:
      - "${YABONZA_FUND_PORT}:${YABONZA_FUND_PORT}"

  ${YABONZA_MONGODB_NAME}:
    environment:
      - YABONZA_ENV=${YABONZA_ENV}
    image: ${YABONZA_MONGODB_IMAGE}
    ports:
      - "${YABONZA_MONGODB_PORT}:${YABONZA_MONGODB_PORT}"

  ${YABONZA_PERMIT_NAME}:
    # build: yabonza-${YABONZA_PERMIT_NAME}
    environment:
      - YABONZA_ENV=${YABONZA_ENV}
    image: ${AWS_SANDBOX_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/yabonza/yabonza-${YABONZA_PERMIT_NAME}:latest
    links:
      - ${YABONZA_POSTGRES_NAME}
    ports:
      - "${YABONZA_PERMIT_PORT}:${YABONZA_PERMIT_PORT}"

  ${YABONZA_POSTGRES_NAME}:
    environment:
      - POSTGRES_PASSWORD=${YABONZA_POSTGRES_PASSWORD}
      - POSTGRES_USER=${YABONZA_POSTGRES_USER}
      - YABONZA_ENV=${YABONZA_ENV}
    image: ${YABONZA_POSTGRES_IMAGE}
    ports:
      - "${YABONZA_POSTGRES_PORT}:${YABONZA_POSTGRES_PORT}"

  ${YABONZA_UI_NAME}:
    build: yabonza-${YABONZA_UI_NAME}
    environment:
      - YABONZA_ENV=${YABONZA_ENV}
    ports:
      - "${YABONZA_UI_PORT}:${YABONZA_UI_PORT}"

  ${YABONZA_WEB_NAME}:
    build: yabonza-${YABONZA_WEB_NAME}
    environment:
      - YABONZA_ENV=${YABONZA_ENV}
    links:
      - ${YABONZA_API_NAME}
    ports:
      - "${YABONZA_WEB_PORT}:${YABONZA_WEB_PORT}"
`;

fs.writeFileSync(path.join(__dirname, `..`, `..`, `docker-compose.yml`), data.trimLeft());
