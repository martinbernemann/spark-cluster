FROM cluster-base

# Latest Spark
ARG spark_version=3.0.2
# Latest JupyterLab
ARG jupyterlab_version=3.0.12
# JupyterLab 3 requires jl-git 0.3
ARG jupyterlab_git_version=0.30.0b2
# Pandas: leterst version
ARG pandas_version=1.2.3
# Latest Almod
#ARG almond_version=0.10.9
# Latest 12 supported for Almond, 12 is required from Spark 3.0.2:
#ARG scala_version=2.12.10

RUN apt-get update -y && \
    apt-get install -y vim curl && \
    apt-get install -y python3-pip && \
    pip3 install wget pyspark==${spark_version} jupyterlab==${jupyterlab_version} && \
    pip3 install pandas==${pandas_version} && \
    apt-get install -y git && \
    # Per default this debian will install nodejs 10, we need 12 for jupyterlab-git 
    curl -sL https://deb.nodesource.com/setup_12.x |  bash - && \
    apt-get install -y nodejs && \
    #
    pip3 install jupyterlab-git==${jupyterlab_git_version} && \
    jupyter lab build

#
#   Does not start: java.lang.NoClassDefFoundError: scala/App$class
#    pip3 install toree  && \
#    jupyter toree install --spark_home=${SPARK_HOME} --spark_opts='--master spark://spark-master:7077 --deploy-mode client --driver-memory 512m'
#
#    Needed ivy downloads in cell and did not bring auto-suggest
#    curl -Lo coursier https://git.io/coursier-cli && \
#    chmod +x coursier && \  
#    ./coursier launch --fork almond:${almond_version} --scala ${scala_version} -- --install -display-name "Scala (${scala_version})" && \
#    rm -f coursier
#
#    Works, Scala 2.11
RUN  pip3 install spylon-kernel==0.4.1 && \
     python -m spylon_kernel install



EXPOSE 8888
WORKDIR ${SHARED_WORKSPACE}
CMD jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.token=