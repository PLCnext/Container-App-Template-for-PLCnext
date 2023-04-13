#!/bin/bash
APP_VERSION="2.2.3"
IMAGE_NAME="nodered"

#arm env
IMAGE_NAME_ARM=nodered/node-red
IMAGE_VERSION_ARM=2.2.3
IMAGE_DIGEST_ARM=sha256:7b5ceb0b4a789857daefd3efceafb04ac6b4107299a50eefe0d947ab6c466160
FULL_IMAGE_NAME_ARM=$IMAGE_NAME_ARM:$IMAGE_VERSION_ARM@$IMAGE_DIGEST_ARM

#x86 env
IMAGE_NAME_X86=nodered/node-red
IMAGE_VERSION_X86=2.2.3
IMAGE_DIGEST_X86=sha256:7b807ec331ea42cd7c15a83f8df8e1a876959abca5ae4c4751590e91a1da4a1e
FULL_IMAGE_NAME_X86=$IMAGE_NAME_X86:$IMAGE_VERSION_X86@$IMAGE_DIGEST_X86


file="test_build/.env"

if grep -q "IMAGE_NAME" "$file"; then
    sed -i 's|IMAGE_NAME.*|IMAGE_NAME='${IMAGE_NAME_X86}'|g' "$file"
else
    sed -i -e '$a\IMAGE_NAME='${IMAGE_NAME_X86}'' "$file"
fi

if grep -q "IMAGE_VERSION" "$file"; then
    sed -i 's|IMAGE_VERSION.*$|IMAGE_VERSION='${IMAGE_VERSION_X86}'|g' "$file"
else
    sed -i -e '$a\IMAGE_VERSION='${IMAGE_VERSION_X86} "$file"
fi

if grep -q "IMAGE_DIGEST" "$file"; then
    sed -i 's|IMAGE_DIGEST.*$|IMAGE_DIGEST='${IMAGE_DIGEST_X86}'|g' "$file"
else
    sed -i -e '$a\IMAGE_DIGEST='${IMAGE_DIGEST_X86} "$file"
fi

if grep -q "IMAGE_TITLE" "$file"; then
    sed -i 's|IMAGE_TITLE.*$|IMAGE_TITLE='${IMAGE_NAME}'|g' "$file"
else
    sed -i -e '$a\IMAGE_TITLE='${IMAGE_NAME} "$file"
fi





#Download Docker images to store for local installation and 
chmod +x ./scripts/download-frozen-image-v2.sh
#     #Load Influxdb  
mkdir -p test_build/images/tmp/$IMAGE_NAME
echo "$FULL_IMAGE_NAME_X86"
./scripts/download-frozen-image-v2.sh test_build/images/tmp/$IMAGE_NAME $FULL_IMAGE_NAME_X86

tar -czvC test_build/images/tmp/$IMAGE_NAME . -f test_build/images/$IMAGE_NAME.tar.gz
# rm -r 3152/images/tmp/
sed -i 's/"version":.*$/"version":"'"${APP_VERSION}"'",/g' test_build/app_info.json
chmod +x test_build/initscript.sh
mksquashfs test_build $IMAGE_NAME.app -force-uid 1001 -force-gid 1002 -noappend  -e test_build/images/tmp