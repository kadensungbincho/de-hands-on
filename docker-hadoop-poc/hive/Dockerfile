FROM bde2020/hadoop-base:2.0.0-hadoop3.2.1-java8

ARG HIVE_VERSION
# Set HIVE_VERSION from arg if provided at build, env if provided at run, or default
# https://docs.docker.com/engine/reference/builder/#using-arg-variables
# https://docs.docker.com/engine/reference/builder/#environment-replacement
ENV HIVE_VERSION=${HIVE_VERSION:-3.1.2}

ENV HIVE_HOME /opt/hive
ENV PATH $HIVE_HOME/bin:$PATH
ENV HADOOP_HOME /opt/hadoop-$HADOOP_VERSION

WORKDIR /opt

#Install Hive and MySQL JDBC
#RUN printf "deb http://archive.debian.org/debian/ jessie main\ndeb-src http://archive.debian.org/debian/ jessie main\ndeb http://security.debian.org jessie/updates main\ndeb-src http://security.debian.org jessie/updates main" > /etc/apt/sources.list && \
#    sed -i 's;http://archive.debian.org/debian;http://deb.debian.org/debian;' /etc/apt/sources.list && \
RUN	apt-get update && apt-get install -y wget procps && \
	wget https://archive.apache.org/dist/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz && \
	tar -xzvf apache-hive-$HIVE_VERSION-bin.tar.gz && \
	mv apache-hive-$HIVE_VERSION-bin hive && \
	wget https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.17/mysql-connector-java-8.0.17.jar -O $HIVE_HOME/lib/mysql-connector-java-8.0.17.jar && \
	rm apache-hive-$HIVE_VERSION-bin.tar.gz && \
	apt-get --purge remove -y wget && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

# https://issues.apache.org/jira/browse/HIVE-22915
RUN rm $HIVE_HOME/lib/guava-19.0.jar && \
    cp $HADOOP_HOME/share/hadoop/hdfs/lib/guava-27.0-jre.jar $HIVE_HOME/lib/

ADD hive/conf/hive-site.xml $HIVE_HOME/conf
ADD hive/conf/beeline-log4j2.properties $HIVE_HOME/conf
ADD hive/conf/hive-env.sh $HIVE_HOME/conf
ADD hive/conf/hive-exec-log4j2.properties $HIVE_HOME/conf
ADD hive/conf/hive-log4j2.properties $HIVE_HOME/conf
ADD hive/conf/ivysettings.xml $HIVE_HOME/conf
ADD hive/conf/llap-daemon-log4j2.properties $HIVE_HOME/conf

COPY hive/startup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/startup.sh

COPY hive/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 10000
EXPOSE 10002

ENTRYPOINT ["entrypoint.sh"]
CMD startup.sh
