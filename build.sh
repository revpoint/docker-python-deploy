#!/bin/bash

set -x
set -e
mkdir -p wheelhouse

# base image with our default python only, no build requirements
docker build -t jangl-docker-python -f 3-python-base.docker .

# a builder to build all application requirements
docker build -t jangl-integrations-email-builder -f 4-build.docker .
docker run --rm \
       -v "$(pwd)":/application \
       -v "$(pwd)"/wheelhouse:/wheelhouse \
       -v "$(pwd)"/.cache/pip:/root/.cache/pip \
       jangl-integrations-email-builder

# the final production image, base python plus pre-built wheels
docker build -t jangl-integrations-email -f 5-run.docker .

# a special image that includes many python versions for running tests
#docker build -t jangl-integrations-email-test -f 6-test.docker .
