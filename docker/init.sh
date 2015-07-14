# base image with our default python from .python-version
docker build -t docker-python-deploy-base -f ./docker/base.docker .;
