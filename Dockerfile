FROM docker-pydeploy-miniconda

COPY . /app

WORKDIR /app
RUN conda install --file requirements.txt

RUN python setup.py install

CMD ["python"]
