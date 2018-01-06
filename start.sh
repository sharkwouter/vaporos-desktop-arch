#!/bin/bash

#Get the directory of this script
work_dir="$(realpath $0|rev|cut -d '/' -f2-|rev)"
dockerfile="Dockerfile"
build_dir="archlive"

#Create archlive directory if it doesn't exist
mkdir -p ${work_dir}/${build_dir}/out #ISOs will be build here

#Build the docker container
docker build -f ${work_dir}/${dockerfile} -t vaporos-builder .

#Run container
docker run --privileged --rm -ti -v ${work_dir}/${build_dir}:/root/archlive -h vaporos-builder vaporos-builder ./build.sh -v
