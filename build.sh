#!/bin/sh
#
#
#


BIN_PATH=$(dirname $(readlink -f $0))
BUILD_PATH=/tmp/tdlib/td
ARCH=$(arch)


USER=fewensa
REPO=tdlib-dylib


build() {
  VERSION=$1
  sudo rm -rf $BUILD_PATH

  git clone https://github.com/tdlib/td.git $BUILD_PATH
  cd $BUILD_PATH
  git checkout -b $VERSION origin/$VERSION

  docker run --rm -dit --name alpine \
    -v $BUILD_PATH:/source \
    -v $BIN_PATH/tdbuild.sh:/tdbuild.sh \
    --env GH_TOKEN=$GH_TOKEN \
    --env VERSION=$VERSION \
    alpine:edge
  docker exec -it alpine sh -f /tdbuild.sh $GH_TOKEN
  docker stop alpine

  cd $BIN_PATH
  sudo rm -rf $BUILD_PATH
}


main() {
  ALL_VERSION=$(echo -e $(curl https://github.com/tdlib/td/releases | pup '.release-entry .commit-title a text{}'))

  # for V in $ALL_VERSION
  # do
  #   build $V
  # done
  build v1.4.0


}

main

