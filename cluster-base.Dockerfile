# Same as spark docker image
ARG jre_version=11.0.10-jre-slim-buster
FROM openjdk:${jre_version}

# Add Python. Spark 3 supports >= 3.6
ARG shared_workspace=/opt/workspace
RUN mkdir -p ${shared_workspace} && \
    apt-get update -y && \
    apt-get install -y python3 && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    rm -rf /var/lib/apt/lists/*

# Shared volume simulates HDFS
ENV SHARED_WORKSPACE=${shared_workspace}
VOLUME ${shared_workspace}
CMD ["bash"]