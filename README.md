# docker-deploy-python

Based off of [glyph/deployme](https://github.com/glyph/deployme), which has background described in this post: [Deploying Python Applications with Docker - A Suggestion](https://glyph.twistedmatrix.com/2015/03/docker-deploy-double-dutch.html). The intent is to build upon this to develop a pattern for building, testing, and running the python app in minimally sized containers.

The base docker image used is [gliderlabs/docker-alpine](https://github.com/gliderlabs/docker-alpine), which drastically reduces the build time and size of the resulting images.

Other minimal distributions have been used in the past, but their move to musl c compiler complicates things. These images intend to allow you to build any python version that pyenv can build from source.

#### Comparison of Sizes

| image | size (MB) | status |
| ----- | -------- | ------- |
| python 2.7 | ~675 | active |
| elyase/conda | ~95 | no longer builds |
| docker-python-deploy-base | ~30 (no python) | active |
| docker-python-deploy-python | ~80.85 | active |
| docker-python-deploy-builder | ~280 | active |
| docker-python-deploy-test | ~170 (depends on python versions) | active |
| python-builder | ~162 (build dependencies only) | active |

## Quickstart

The building, testing, and running requirements are all handled in the docker images. However, you still need on the host machine, to be able to run bash scripts, and access to docker. Docker can be accessed locally, boot2docker, or docker-machine.

Init: `./init.sh` -> builds base image, python builder, and builds python versions to ./.python.

Build: `./build.sh` -> builds base python image, builder, tester, and runner

Test: `./test.sh` -> tests the app according to tox.ini

Run: `./run.sh` -> runs the app

Open `<host>:8081`

Note: `<host>` for boot2docker/kitematic is provided with `boot2docker ip` and `docker-machine ip`, respectively.

## Python App
Example app implements a small web server, responding with `Hello World!` when accessed.

## Docker

### Hierarchy

* base
* base -> python-builder
* base -> python-base -> builder
* base -> tester

### Base Image

* Initial setup of pyenv, git, curl

### Python Builder

* Inerits from base
* Adds build requirements for python
* Entrypoint of pyenv
* You pass it a volume and `install <python version>` and it builds it in your volume

### Python Base

* inherits from base
* Adds pre-built python, built by python builder
* Sets the python as the global/default python
* Doesn't include any build requirements, only runtime

### Builder
A heavier weight docker image, building off of the python base image, which installs all files necessary for compiling and building python application wheels.

* Install packages required for building python apps
* Install wheel via pip
* Create volumes to host the application and wheelhouse files
* Sets up entry point to run wheel on the application directory. This results in the wheelhouse folder containing all requirements needed to run the application.

### Test Image

* Builds off of base python image
* Adds in all pre-built (todo: do this by configuration) python versions, then runs tox
* This includes tests, tests with coverage, and pylint

### Run Image
Uses the base python image, installs and runs the application.

* Mounts the wheelhouse folder, now full of all pre-build application dependencies
* Installs the application using pip and the local wheelhouse folder
* Runs the application
