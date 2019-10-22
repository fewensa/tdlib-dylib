#!/bin/sh
#
#
#

set -v

SOURCE=/source
BUILD_PATH=$SOURCE/build
DYLIB_PATH=/tmp/tdlib-dylib
ARCH=$(arch)
GH_TOKEN=$1


apk update
apk add gcc g++ cmake make zlib-dev openssl-dev linux-headers gperf git tree


mkdir -p $BUILD_PATH
cd $BUILD_PATH
cmake -DCMAKE_BUILD_TYPE=Release ..
cmake --build .

git clone https://github.com/fewensa/tdlib-dylib.git $DYLIB_PATH

echo "https://$(echo $GH_TOKEN)@github.com" > /root/.git-credentials
# echo -e "[credential]\n    helper = store\n[core]\n    autocrlf = input\n    saftcrlf = true\n    safecrlf = true\n[user]\n    name = fewensa\n    email = fewensa@protonmail.com" > /root/.gitconfig

git config --global credential.helper store
git config --global user.email fewensa@protonmail.com
git config --global user.name fewensa


TARGET_PATH=$DYLIB_PATH/linux/$VERSION/$ARCH
mkdir -p $TARGET_PATH

cp -d $BUILD_PATH/libtdjson.so $TARGET_PATH
cp -d $BUILD_PATH/libtdjson.so.${VERSION:1} $TARGET_PATH
# cp -d $BUILD_PATH/*so* $TARGET_PATH

ls -la $TARGET_PATH

cd $DYLIB_PATH

git add .
git commit -m "$VERSION - $ARCH"
git push origin master


