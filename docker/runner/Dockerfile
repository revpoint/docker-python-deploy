FROM docker-python-deploy-python

# install app
ADD ./.wheelhouse /wheelhouse
RUN pip install --no-index -f wheelhouse DockerApp

EXPOSE 8081

ENTRYPOINT run-the-app
