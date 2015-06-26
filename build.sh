#!/bin/bash

set -x;
set -e;
mkdir -p wheelhouse;

docker build -t docker-python-deploy-base -f base.docker .;
docker build -t docker-python-deploy-builder -f build.docker .;
docker run --rm \
       -v "$(pwd)":/application -v "$(pwd)"/wheelhouse:/wheelhouse \
       docker-python-deploy-builder;
docker build -t docker-python-deploy-run -f run.docker .;
