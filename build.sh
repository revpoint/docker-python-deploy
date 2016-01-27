#!/bin/bash

set -x
set -e
mkdir -p wheelhouse

# a builder to build all application requirements
docker build -t jangl-webleads-builder -f 4-build.docker .
docker run --rm \
       -v "$(pwd)":/app \
       -v "$(pwd)"/wheelhouse:/wheelhouse \
       -v "$(pwd)"/.cache/pip:/root/.cache/pip \
       jangl-webleads-builder

# the final production image, base python plus pre-built wheels
docker build -t jangl-webleads -f 5-run.docker .

# a special image that includes many python versions for running tests
#docker build -t jangl-integrations-email-test -f 6-test.docker .
