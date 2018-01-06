#Dockerfile for building VaporOS Desktop
#Based on Arch

FROM base/archlinux
MAINTAINER Wouter Wijsman

#Install archiso
RUN yes | pacman -Sy archiso
RUN mkdir -p /root/archlive/out

#set working dir, you'll have to mount something yourself here
WORKDIR /root/archlive

#Copy archiso files from this git repo
ADD archlive /root/archlive
