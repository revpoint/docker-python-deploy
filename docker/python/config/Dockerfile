FROM docker-python-deploy-base

ONBUILD ADD .python-version /app/.python-version
ONBUILD RUN cd app && \
/root/.pyenv/bin/pyenv install $(cat .python-version) && \
/root/.pyenv/bin/pyenv global $(cat .python-version)

ONBUILD RUN curl -L https://bootstrap.pypa.io/get-pip.py -o /dev/stdout | python
