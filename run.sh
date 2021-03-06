#!/bin/bash -ev

HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DATA=${HERE}/data

docker build -t gijzelaerr/discobase build/base
docker build -t gijzelaerr/discomaster build/master
docker build -t gijzelaerr/discotest build/test

# make sure the old one is gone
docker stop discomaster || true
docker rm discomaster || true

docker run \
    -d \
    -t \
    -p 2222:22 \
    -p 8989:8989 \
    -v ${DATA}:/data:ro \
    --name discomaster \
    gijzelaerr/discomaster

docker port discomaster 22
docker port discomaster 8989

docker run \
    --link=discomaster:discomaster \
    --volumes-from discomaster \
    gijzelaerr/discotest \
    /bin/sh /test.sh
