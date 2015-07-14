FROM docker-pydeploy-miniconda

COPY build_conda_deps.sh /app/build_conda_deps.sh

WORKDIR /app
RUN conda install conda-build && \
    ./build_conda_deps.sh

RUN conda build ./conda-recipe && \
    conda install --use-local dockerapp

CMD ["python"]
