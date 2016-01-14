#!/bin/bash

SOURCE=/$1
DESTINATION=/home/backup/sql
YEAR=`date +%Y`
MONTH=`date +%m`
DAY=`date +%d`
ARC_NAME=$DESTINATION/$HOSTNAME-$1-$YEAR-$MONTH-$DAY.tar.gz
COPIES=7


mysqldump -u root -p12345 $1 > $DESTINATION/$1

tar cfz $ARC_NAME $DESTINATION/$1 2>/dev/null
rm $DESTINATION/$1

FILES=`ls $DESTINATION/ | wc -l`
if [ $FILES -gt $COPIES ]
then
DELETE=$FILES-$COPIES
for (( i==1; i<$DELETE; i++ ))
do
rm $DESTINATION/$(ls $DESTINATION | sort | head -n 1)
done
fi
