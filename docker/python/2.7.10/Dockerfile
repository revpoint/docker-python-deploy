FROM docker-python-deploy-base

RUN /root/.pyenv/bin/pyenv install 2.7.10 && \
/root/.pyenv/bin/pyenv global 2.7.10

RUN curl -L https://bootstrap.pypa.io/get-pip.py -o /dev/stdout | python

WORKDIR /app
