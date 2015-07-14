FROM docker-python-deploy-base

ADD . /app

RUN cd /app && \
    pip install wheel && \
    mkdir -p /root/.cache/pip

ENV WHEELHOUSE=/wheelhouse
ENV PIP_WHEEL_DIR=/wheelhouse
ENV PIP_FIND_LINKS=/wheelhouse

VOLUME /wheelhouse
VOLUME /app
VOLUME /root/.cache/pip

ENTRYPOINT cd /app && \
           pip wheel . -r requirements.txt \
              -r dev-requirements.txt
