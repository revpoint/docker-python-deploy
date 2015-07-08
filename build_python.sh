#!/bin/bash

set -x;
set -e;

rm -rf .python/*

docker build -t python-builder -f python-build.docker .

docker run --rm -v "$(pwd)"/.python:/root/.pyenv/versions -it python-builder install -v 2.7.10
docker run --rm -v "$(pwd)"/.python:/root/.pyenv/versions -it python-builder install -v 3.4.3
