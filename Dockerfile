#Dockerfile for building VaporOS Desktop
#Based on Arch

FROM base/archlinux
MAINTAINER Wouter Wijsman

#Install archiso
RUN yes | pacman -Sy archiso
RUN mkdir -p /root/vaporos-live/out

#set working dir, you'll have to mount something yourself here
WORKDIR /root/vaporos-live

#Copy archiso files from this git repo
ADD vaporos-live /root/vaporos-live
