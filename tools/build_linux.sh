#!/bin/bash
REMOTE="root@localhost"
PORT="9999"

cwd=$(pwd)

REPO_URL="https://github.com/ATtinyTeenageRiot/AvrdudeGnusbuinoMidi2Kicker.git"
REPO_DIR="/root/AvrdudeGnusbuinoMidi2Kicker"
STAGING_DIR="./tools/staging"


DESTINATION_REPO="../../CocoMake7Platform/avr/tools/avrdude"
COMMIT_HASH="7c139bd4267f6b902aa6b931838e701ad0744919"


#ssh ${REMOTE} -p ${PORT} bash -c "'
#cd "${REPO_DIR}/avrdude-6.0rc1"
#./avrdude -cusbasp -pt85 -C ./avrdude.conf
#'"

ssh ${REMOTE} -p ${PORT} bash -c "'

#rm -fr "${REPO_DIR}"
git clone ${REPO_URL}
cd ${REPO_DIR}
git checkout ${COMMIT_HASH}
git log -1
ls "${REPO_DIR}"


cd "${REPO_DIR}"
git fetch --all
git pull --all
git reset --hard ${COMMIT_HASH}
git clean -dfx


cd "${REPO_DIR}/babygnusbsysex"
mkdir "Release"
make clean
make

cd "${REPO_DIR}/avrdude-6.0rc1"
chmod +x configure


#make clean
./configure --silent > /dev/null
make

patchelf --set-rpath ./ ./avrdude
patchelf --print-rpath ./avrdude

mv ./avrdude ./avrdude_bin

cp "/lib/libusb-0.1.so.4" .
cp "/lib/libusb-1.0.so.0" .
cp "/lib/libncurses.so.5" .
cp "/usr/lib/libasound.so.2.0.0" .

git log -1 > changelog.txt

'"

mkdir -p "${cwd}/${DESTINATION_REPO}/linux"
scp -P ${PORT} ${REMOTE}:${REPO_DIR}/avrdude-6.0rc1/\{avrdude_bin,changelog.txt,libusb-0.1.so.4,libusb-1.0.so.0,libncurses.so.5,libasound.so.2.0.0\} "${cwd}/${DESTINATION_REPO}/linux"