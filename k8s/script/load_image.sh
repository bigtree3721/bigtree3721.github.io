#!/bin/sh
# the script is used to load docker images in batch from gz file
# 2017-11, V1.0, bill.tang@

IMAGE_TAR_FILE=./k8s.tar.gz

echo "=====> unzip package "
tar -zxvf ${IMAGE_TAR_FILE}
echo "<===== unzip package done"

cd backup
echo "=====> loading docker images in batch begin" 
for LINE in ` find ./ -name "*.tar" -print ` 
do
   echo "------> loading image from  ${LINE}"
   docker load -i ${LINE}

done 
cd ..

rm -rf backup

echo "<====== loading images done successfully"
exit 0
