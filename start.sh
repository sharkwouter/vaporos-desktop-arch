#!/bin/bash

#Get the directory of this script
DIR="$(realpath $0|rev|cut -d '/' -f2-|rev)"
DOCKERFILE="$DIR/builder"
BUILDDIR="$DIR/archlive"

#Create archlive directory if it doesn't exist
mkdir -p $BUILDDIR

#Build the docker container
cd $DOCKERFILE
docker build -t vaporos-builder .
cd $DIR

#Run container
docker run -t -i -v $BUILDDIR:/root/archlive vaporos-builder /bin/bash
