FROM docker-python-deploy-base

ADD . /app
ADD ./.wheelhouse /wheelhouse
WORKDIR /app

RUN pip install --no-index -f .wheelhouse -r /app/dev-requirements.txt

RUN virtualenv /py27
#RUN virtualenv -p $PYTHON_VERSIONS/3.4.3/bin/python /py34

ENTRYPOINT cd /app && \
    tox /app
