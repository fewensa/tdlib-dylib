#!/bin/sh
#
#
#


SOURCE=/source
BUILD_PATH=$SOURCE/build
DYLIB_PATH=/tmp/tdlib-dylib
ARCH=$(arch)


apk update
apk add gcc g++ cmake make zlib-dev openssl-dev linux-headers gperf git tree


mkdir -p $BUILD_PATH
cd $BUILD_PATH
cmake -DCMAKE_BUILD_TYPE=Release ..
cmake --build .

git clone https://github.com/fewensa/tdlib-dylib.git $DYLIB_PATH

echo 'https://$GH_TOKEN@github.com' > ~/.git-credentials
git config --global credential.helper store


TARGET_PATH=$DYLIB_PATH/linux/$VERSION/$ARCH
mkdir -p $TARGET_PATH
ls $BUILD_PATH -l
mv $BUILD_PATH/libtdjson* $TARGET_PATH
ls -la $TARGET_PATH

cd $DYLIB_PATH
git config --local user.email fewensa@protonmail.com
git config --local user.name fewensa

tree

git add .
git commit -m "$VERSION - $ARCH"
git push origin master


