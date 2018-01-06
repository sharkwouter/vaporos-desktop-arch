#Dockerfile for building VaporOS Desktop
#Based on Arch

FROM base/archlinux
MAINTAINER Wouter Wijsman

#Install archiso
RUN yes | pacman -Sy archiso
RUN mkdir /root/archlive

#set working dir, you'll have to mount something yourself here
WORKDIR /root/archlive
