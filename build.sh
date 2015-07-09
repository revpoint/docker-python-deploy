#!/bin/bash

set -x;
set -e;
mkdir -p wheelhouse;

# base image with our default python only, no build requirements
docker build -t docker-python-deploy-python -f python-base.docker .;

# a builder to build all application requirements
docker build -t docker-python-deploy-builder -f build.docker .;
docker run --rm \
       -v "$(pwd)":/application -v "$(pwd)"/wheelhouse:/wheelhouse \
       docker-python-deploy-builder;

# the final production image, base python plus pre-built wheels
docker build -t docker-python-deploy-run -f run.docker .;

# a special image that includes many python versions for running tests
docker build -t docker-python-deploy-test -f test.docker .;
