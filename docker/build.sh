#!/bin/bash

set -x;
set -e;
mkdir -p ./.wheelhouse;

# a builder to build all application requirements
docker build -t docker-python-deploy-builder -f ./docker/build.docker .;
docker run --rm \
       -v "$(pwd)":/app \
       -v "$(pwd)"/.wheelhouse:/wheelhouse \
       -v "$(pwd)"/.cache/pip:/root/.cache/pip \
       docker-python-deploy-builder;

# the final production image, base python plus pre-built wheels
docker build -t docker-python-deploy-run -f ./docker/run.docker .;

# a special image that includes many python versions for running tests
docker build -t docker-python-deploy-test -f ./docker/test.docker .;
