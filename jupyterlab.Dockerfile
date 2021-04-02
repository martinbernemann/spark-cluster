FROM cluster-base

ARG spark_version=3.1.1
ARG jupyterlab_version=3.0.12

RUN apt-get update -y && \
    apt-get install -y python3-pip && \
    pip3 install wget pyspark==${spark_version} jupyterlab==${jupyterlab_version} && \
    pip3 install pandas==1.2.3 && \
    pip3 install spylon-kernel==0.4.1 && \
    python -m spylon_kernel install

# -- Runtime

EXPOSE 8888
WORKDIR ${SHARED_WORKSPACE}
CMD jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.token=