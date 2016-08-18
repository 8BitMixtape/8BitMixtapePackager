#!/bin/bash
REMOTE="xcorex@172.16.225.134"
PORT="22"

cwd=$(pwd)

REPO_URL="https://github.com/ATtinyTeenageRiot/AvrdudeGnusbuinoMidi2Kicker.git"
REPO_DIR="/c/Users/BvSsh_VirtualUsers/AvrdudeGnusbuinoMidi2Kicker"
STAGING_DIR="./tools/staging"


DESTINATION_REPO="../../CocoMake7Platform/avr/tools/avrdude"
COMMIT_HASH="7db7f06ec33af157b9cf97500c54b367a9b464bb"

#ssh ${REMOTE} -p ${PORT} bash -c "'
#cd "${REPO_DIR}/avrdude-6.0rc1"
#./avrdude.exe -cusbasp -pt85 -C ./avrdude.conf
#'"

ssh ${REMOTE} -p ${PORT} bash -c "'
git clone ${REPO_URL}
pwd
cd ${REPO_DIR}
git fetch --all
git pull --all
git checkout ${COMMIT_HASH}
git clean -dfx
git log -1
#ls "${REPO_DIR}"

cd "${REPO_DIR}/babygnusbsysex"
mkdir "Release"
make clean
make

pwd

cd "${REPO_DIR}/avrdude-6.0rc1"
make clean
./configure
make

cp avrdude.exe ../release
cp avrdude.conf ../release

git log -1 > ../release/changelog.txt

cd "${REPO_DIR}/release"
pwd
ls "${REPO_DIR}/release"

'"

mkdir -p "${cwd}/${DESTINATION_REPO}/windows"
scp -P ${PORT} "${REMOTE}:${REPO_DIR}/release/*" "${cwd}/${DESTINATION_REPO}/windows"