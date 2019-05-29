#!/bin/bash
export DOCKERID=`docker ps -alq`
docker cp $DOCKERID:/source/BiobaseHTTPTools.tar.gz .
