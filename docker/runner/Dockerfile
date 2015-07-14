FROM docker-python-deploy-python

RUN cd app && \
/root/.pyenv/bin/pyenv install $(cat .python-version) && \
/root/.pyenv/bin/pyenv global $(cat .python-version)

# install app
ADD ./.wheelhouse /wheelhouse
RUN pip install --no-index -f wheelhouse DockerApp

EXPOSE 8081

ENTRYPOINT run-the-app
