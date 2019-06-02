#!/bin/sh
#
#
#


SOURCE=/source

apk update
apk add gcc g++ cmake make zlib-dev openssl-dev gperf git


mkdir -p $SOURCE/build
cd $SOURCE/build
cmake -DCMAKE_BUILD_TYPE=Release ..
cmake --build .

