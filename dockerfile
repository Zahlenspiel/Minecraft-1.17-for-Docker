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

RUN groupadd -g ${gid} -o ${group}
RUN useradd -M -d /minecraft -u ${uid} -g ${gid} -o -s /bin/bash ${user}
RUN chown -R ${user}:${group} /minecraft
RUN chmod -R ug+rwx /minecraft

RUN mkdir -p /usr/share/man/man1 /usr/share/man/man2

RUN apt-get update
RUN apt-get install -y --no-install-recommends openjdk-11-jre-headless
RUN apt-get install -y wget

USER ${user}
WORKDIR /minecraft
RUN wget https://papermc.io/ci/job/Paper-1.17/lastSuccessfulBuild/artifact/paperclip.jar -O paper.jar
RUN echo "java -Xms${XMS} -Xmx${XMX} -jar paper.jar -nogui" > start.sh

CMD start.sh