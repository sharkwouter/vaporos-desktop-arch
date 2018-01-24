#!/bin/bash

#Get the directory of this script
$work_dir=$PSScriptRoot 
$dockerfile="Dockerfile"
$output_dir="output"

#Create output directory if it doesn't exist
mkdir ${work_dir}/${output_dir}

#Build the docker container
docker build -f ${work_dir}/${dockerfile} -t vaporos-builder ${work_dir}

#Run container
docker run --privileged --rm -ti -v ${work_dir}/${output_dir}:/root/vaporos-live/out -h vaporos-builder vaporos-builder /bin/bash
