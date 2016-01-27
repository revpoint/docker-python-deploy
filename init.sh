#!/bin/bash

set -x;
set -e;

# remove previous python versions
rm -rf .python/*

# build the base file with pyenv
docker build -t jangl-docker-base -f 1-base.docker .

# build a master python builder for building versions of python for testing
docker build -t python-builder -f 2-python-build.docker .

# build each version of python that we may use
# todo: parameterize this via config file
docker run --rm -v "$(pwd)"/.python:/root/.pyenv/versions \
  -v "$(pwd)"/.cache/python:/root/.pyenv/cache -it python-builder install -v 2.7.10
#docker run --rm -v "$(pwd)"/.python:/root/.pyenv/versions -it python-builder install -v pypy-2.6.0-src

# cleanup extras that double the size of python
# todo: make generic to python versions
USERPYTHON=.python/2.7.10
ln -sf $USERPYTHON/lib/libpython2.7.a $USERPYTHON/lib/python2.7/config/libpython2.7.a
ln -sf $USERPYTHON/lib/libpython2.7.a $USERPYTHON/lib/python2.7/config/libpython2.7.a

for test in sqlite3/test email/test ctypes/test test unittest/test lib-tk/test \
            bsddb/test json/tests lib2to3/tests distutils/tests tests ; do
	rm -rf "$USERPYTHON"/lib/python2.7/"$test"
done

find "$USERPYTHON"/lib/python2.7/ -name '*.pyo' -or -name '*.pyc' -exec rm {} \;
