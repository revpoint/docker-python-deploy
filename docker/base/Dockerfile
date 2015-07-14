# base.docker
#
# Contains shell, pyenv, git and curl ready to use

FROM buildpack-deps:jessie

COPY .python-version /app/.python-version

# Install pyenv, and the python version for this app
RUN curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer -o /pyenv-installer && \
    /bin/bash /pyenv-installer && \
    rm /pyenv-installer && \
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.profile && \
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.profile && \
    echo 'eval "$(pyenv init -)"' >> ~/.profile && \
    echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.profile && \
    cd app && \
    /root/.pyenv/bin/pyenv install $(cat .python-version) && \
    /root/.pyenv/bin/pyenv global $(cat .python-version)

ENV HOME  /root
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

WORKDIR /app
RUN curl -L https://bootstrap.pypa.io/get-pip.py -o /dev/stdout | python
