#!/bin/sh
# the script is used to save docker images in batch

IMAGE_TAR_FILE=./k8s.tar.gz

mkdir -p backup 

cd backup

echo "=====> backup docker images in batch begin" 
docker images > ./imagesinfo.txt
awk -F' ' 'NR>1 { print $1":"$2 >> "./imagetag.txt" }' ./imagesinfo.txt

n=0

while read LINE
do
   filename=$(echo $LINE | sed "s/\//_/g" )
   echo "------> backup image -> ${filename}"
   docker save $LINE > ${filename}.tar
   let "n++"

done < ./imagetag.txt

echo "=====> packaging images ...."
rm -f imagesinfo.txt imagetag.txt

cd ..

tar -zcvf ${IMAGE_TAR_FILE} backup 

echo "<===== packaging images done"

rm -rf backup

echo "<====== done successfully"
exit 0
