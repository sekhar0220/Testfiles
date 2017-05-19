#The base image to use in the build
FROM centos:centos6
MAINTAINER Sobhan Kumar Samantaray <sobhansoak@gmail.com>
#Install the MongoDB server from epel-release
RUN yum -y update;yum clean all
RUN yum -y install epel-release; yum clean all
RUN yum -y install mongodb-server; yum clean all
RUN mkdir -p /data/db
#Opens a port for linked containers
EXPOSE 27017
ENTRYPOINT ["/usr/bin/mongod"] 
#Install python
RUN yum -y install python-pip;yum clean all
#To install Apache Tomcat 7
#Install WGET
RUN yum install -y wget
#Install tar
RUN yum install -y tar
#For Apache-Tomcat7 we need to install OpenJDK7
RUN yum update -y && \
yum install -y wget && \
yum install -y java-1.7.0-openjdk java-1.7.0-openjdk-devel && \
yum clean all
#Download Apache Tomcat 7
RUN cd /tmp;wget http://redrockdigimark/apachemirror/tomcat/tomcat-7/v7.0.73/bin/apache-tomcat-7.0.73.tar.gz
#untar and move to proper location
RUN cd /tmp;gunzip apache-tomcat-7.0.73.tar.gz
RUN cd /tmp;tar -xvf apache-tomcat-7.0.73.tar
RUN cd /tmp;mv apache-tomcat-7.0.73 /opt/tomcat7
RUN chmod -R 755 /opt/tomcat7
#Sets JAVA_HOME environment variable in the new container for jdk
ENV JAVA_HOME /opt/jdk1.7.0_79
#Opens a port for linked container
EXPOSE 8080
#The following script that runs after the container starts. catalina.sh used to start Tomcat7 after the container boots
CMD ["catalina.sh", "run"]
