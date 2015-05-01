FROM ubuntu
MAINTAINER Mahesh Vangala <vangalamaheshh@gmail.com>

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10

RUN echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list

RUN apt-get update && apt-get upgrade -y
RUN apt-get install git python build-essential wget screen tmux curl vim mongodb-org -y
RUN sudo service mongod start

RUN mkdir /data
RUN mkdir /data/db

RUN mkdir /Development
RUN cd /Development && git clone git://github.com/joyent/node

RUN cd /Development/node && ./configure && make && make install
RUN rm -rf /Development/node
RUN chmod 777 -R /Development

RUN npm install -g bower grunt-cli yo generator-meanjs express

EXPOSE 80:80
EXPOSE 443:443
EXPOSE 3000:3000


