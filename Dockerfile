# Dockerizing nginx-RTMP: Dockerfile for building nginx-RTMP images
# Based on ubuntu:latest, installs nginx-RTMP

# Format: FROM    repository[:version]
FROM       ubuntu:latest

# Format: MAINTAINER Name <email@addr.ess>
MAINTAINER Andreas W. Prang <writeAmail@me.com>

# Installation:
RUN apt-get -y install wget
RUN apt-get -y install unzip
RUN apt-get update && apt-get install -y build-essential
RUN apt-get update && apt-get install -y libpcre3 libpcre3-dev libssl-dev

RUN mkdir ~/working && cd ~/working
RUN wget http://nginx.org/download/nginx-1.7.9.zip
RUN wget https://github.com/arut/nginx-rtmp-module/archive/master.zip

RUN unzip nginx-1.7.9.zip
RUN unzip master.zip

RUN cd nginx-1.7.9

