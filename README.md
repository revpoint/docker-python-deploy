# docker-deploy-python

Based off of [glyph/deployme](https://github.com/glyph/deployme), which has background described in this post: [Deploying Python Applications with Docker - A Suggestion](https://glyph.twistedmatrix.com/2015/03/docker-deploy-double-dutch.html). The intent is to build upon this to develop a pattern for building, testing, and running the python app in minimally sized containers.

The base docker image used is [gliderlabs/docker-alpine](https://github.com/gliderlabs/docker-alpine), which drastically reduces the build time and size of the resulting images.

####Comparison of Sizes

| image | size (MB) | status |
| ----- | -------- | ------- |
| python 2.7 | ~675 | active |
| elyase/conda | ~95 | no longer builds |
| docker-python-deploy-base | ~65 | active |
| docker-python-deploy-build | ~225 | active |

## Python App
Example app implements a small web server, responding with `Hello World!` when accessed.

## Docker

### Base Image

* Initial setup of python, pip, and virtualenv.
* Creates virtualenv at /appenv
* Cleans up package information by using apk-install.


### Build Image
A heavier weight docker image, building off of the base image, which installs all files necessary for compiling and building python application wheels.

* Install packages required for building python apps
* Install wheel via pip
* Create volumes to host the application and wheelhouse files
* Sets up entry point to activate virtualenv and run wheel on the application directory. This results in the wheelhouse folder containing all requirements needed to run our application.

### Test Image

ToDo

### Run Image
Uses the base image, installs and runs the application.

* Mounts the wheelhouse folder, now full of all pre-build application dependencies
* Installs the application using pip and the local wheelhouse folder
* Runs the application
