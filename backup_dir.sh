#!/bin/bash

DESTINATION=/home/backup
DIR_NAME=${1##*/}
YEAR=`date +%Y`
MONTH=`date +%m`
DAY=`date +%d`
ARC_NAME=$DESTINATION/$HOSTNAME-$DIR_NAME-$YEAR-$MONTH-$DAY.tar.gz
COPIES=7


if [ -e $ARC_NAME ]
then
 echo "Файл существует. Перезаписать его?"
read doing
case $doing in
y) tar cfz $ARC_NAME $1 2>/dev/null
esac
else
 tar cfz $ARC_NAME $1 2>/dev/null
fi
FILES=`ls $DESTINATION/ | wc -l`

if [ $FILES -gt $COPIES ]
then
DELETE=$FILES-$COPIES
for (( i==1; i<$DELETE; i++ ))
do
rm $DESTINATION/$(ls $DESTINATION | sort | head -n 1)
done
fi
