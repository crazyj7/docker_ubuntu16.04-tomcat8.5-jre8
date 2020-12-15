FROM ubuntu:16.04
MAINTAINER crazyj7@gmail.com
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y build-essential binutils libtool make gcc g++ openjdk-8-jdk git dos2unix vim wget 

# jre link
WORKDIR /usr/java
RUN /bin/ln -s /usr/lib/jvm/java-8-openjdk-amd64 /usr/java/latest

# install path ; /usr/local/tomcat
WORKDIR /usr/local
RUN wget https://downloads.apache.org/tomcat/tomcat-8/v8.5.61/bin/apache-tomcat-8.5.61.tar.gz && \
	tar xvfz apache-tomcat-8.5.61.tar.gz && \
	rm apache-tomcat-8.5.61.tar.gz && \
	mv apache-tomcat-8.5.61 tomcat

# env
WORKDIR /root
ENV CATALINA_HOME=/usr/local/tomcat
ENV JAVA_HOME=/usr/java/latest
ENV JRE_HOME=/usr/java/latest/jre
ENV LD_LIBRARY_PATH=.:/usr/local/lib:$JAVA_HOME/bin:$CATALINA_HOME/bin
ENV PATH=$PATH:/usr/java/latest/bin:/usr/local/tomcat/bin
ENV HOME /root

VOLUME ["/usr/local/tomcat/webapps","/usr/local/lib"]
EXPOSE 8080

CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]

