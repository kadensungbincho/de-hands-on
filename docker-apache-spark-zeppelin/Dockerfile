FROM bde2020/spark-worker:3.0.2-hadoop3.2

ARG ZEPPELIN_VERSION="0.9.0"

RUN mkdir /usr/zeppelin &&\
    curl -s https://mirror.navercorp.com/apache/zeppelin/zeppelin-${ZEPPELIN_VERSION}/zeppelin-${ZEPPELIN_VERSION}-bin-all.tgz | tar -xz -C /usr/zeppelin
RUN echo '{ "allow_root": true }' > /root/.bowerrc

ENV ZEPPELIN_PORT 8080
EXPOSE $ZEPPELIN_PORT

ENV ZEPPELIN_HOME /usr/zeppelin/zeppelin-${ZEPPELIN_VERSION}-bin-all
ENV ZEPPELIN_CONF_DIR $ZEPPELIN_HOME/conf
ENV ZEPPELIN_NOTEBOOK_DIR $ZEPPELIN_HOME/notebook
ENV ZEPPELIN_ADDR 0.0.0.0

RUN mkdir -p $ZEPPELIN_HOME \
  && mkdir -p $ZEPPELIN_HOME/logs \
  && mkdir -p $ZEPPELIN_HOME/run


RUN mkdir /workspace
WORKDIR /workspace

ENTRYPOINT $ZEPPELIN_HOME/bin/zeppelin-daemon.sh start; tail -f /dev/null
