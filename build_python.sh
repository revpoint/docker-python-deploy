rm -rf .python/*

docker build -t python-builder -f python-build.docker .

docker run -rm --env PYBUILD_VERSION=2.7 -v "$(pwd)"/.python:/usr/python -it python-builder

docker run -rm --env PYBUILD_VERSION=3.4 -v "$(pwd)"/.python:/usr/python -it python-builder
