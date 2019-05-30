#!/bin/bash
echo "docker ps -a"
docker ps -a
export DOCKERID=`docker ps -alq`
echo "docker cp $DOCKERID:/source/BiobaseHTTPTools.tar.gz ."
docker cp $DOCKERID:/source/BiobaseHTTPTools.tar.gz .
