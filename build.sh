#!/bin/sh
#
#
#


BIN_PATH=$(dirname $(readlink -f $0))
BUILD_PATH=/tmp/tdlib/td
SOURCE_PATH=/tmp/tdlib/source
ARCH=$(arch)


USER=fewensa
REPO=tdlib-dylib

mkdir -p $SOURCE_PATH

build() {
  VERSION=$1
  mkdir -p $BUILD_PATH

  git clone https://github.com/tdlib/td.git $BUILD_PATH
  cd $BUILD_PATH
  git checkout -b $VESION origin/$VERSION

  docker run --rm -dit --name alpine -v $BUILD_PATH:/source -v ./td_build.sh:/td_build.sh alpine:3.9
  docker exec -it alpine sh -f /td_build.sh



  # move_dylib $VERSION

  cd $BIN_PATH
  rm -rf $BUILD_PATH
}

move_dylib() {
  VERSION=$1
  git clone https://github.com/fewensa/tdlib-dylib.git $SOURCE_PATH

  TARGET_PATH=$SOURCE_PATH/linux/$VERSION/$ARCH
  mkdir -p $TARGET_PATH
  mv $BUILD_PATH/build/libtdjson.so* $TARGET_PATH

  cd $SOURCE_PATH
  # git config --local user.email fewensa@protonmail.com
  # git config --local user.name fewensa
  # git add .
  # git commit -m "td"
  # git push origin master

  ls -la $TARGET_PATH

  cd $BIN_PATH
}

main() {
  ALL_VERSION=$(echo -e $(curl https://github.com/tdlib/td/releases | pup '.release-entry .commit-title a text{}'))

  # rm -rf $BUILD_PATH
  # for V in $ALL_VERSION
  # do
  #   build $V
  # done
  build v1.4.0


#  git clone https://github.com/tdlib/td.git $BUILD_PATH


}

main

