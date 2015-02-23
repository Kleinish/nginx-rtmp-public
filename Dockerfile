# Dockerizing nginx-RTMP: Dockerfile for building nginx-RTMP images
# Based on ubuntu:latest, installs nginx-RTMP

# Format: FROM    repository[:version]
FROM       ubuntu:latest

# Format: MAINTAINER Name <email@addr.ess>
MAINTAINER Andreas W. Prang <writeAmail@me.com>

# Installation:
RUN apt-get update;\
	apt-get -y install wget;\
	apt-get -y install unzip;\ 
	apt-get install -y build-essential libpcre3 libpcre3-dev libssl-dev

# Install nginx with RTMP
RUN mkdir /tmp/working && cd /tmp/working;\
	wget http://nginx.org/download/nginx-1.7.9.tar.gz;\
	wget https://github.com/arut/nginx-rtmp-module/archive/master.zip;\
	tar -zxvf nginx-1.7.9.tar.gz;\
	unzip master.zip;\
	cd nginx-1.7.9;\
	./configure --with-http_ssl_module --add-module=../nginx-rtmp-module-master;\
	make install
	
RUN rm -r /tmp/working

# Install daemon
RUN wget https://raw.github.com/JasonGiedymin/nginx-init-ubuntu/master/nginx -O /etc/init.d/nginx;\
	chmod +x /etc/init.d/nginx;\
	update-rc.d nginx defaults

# Install additional decoder 
RUN apt-get -y install software-properties-common;\
	apt-add-repository ppa:jon-severinsson/ffmpeg;\
	apt-get update;\
	apt-get -y install ffmpeg