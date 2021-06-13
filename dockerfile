# Dockerfile for MC
FROM debian:buster-slim
MAINTAINER MarcJansen <jansenmarc1998@gmail.com>
VOLUME ["/minecraft"]
WORKDIR /minecraft
EXPOSE 25565

ARG XMS=4G
ARG XMX=4G
ARG user=minecraft
ARG group=minecraft
ARG uid=1000
ARG gid=1000

RUN apt-get -y update
RUN apt-get -y install openjdk-14-jre-headless
RUN apt-get -y install wget

RUN wget https://papermc.io/ci/job/Paper-1.17/lastSuccessfulBuild/artifact/paperclip.jar -O paper.jar
RUN echo "java -Xms$XMS -Xmx$XMX -jar paper.jar -nogui" > start.sh