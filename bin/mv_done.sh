#!/bin/bash

CURRENT=`dirname $0`
DBPATH="$CURRENT/../db"
TODAYDB="$DBPATH/today.txt"
DONEDB="$DBPATH/done.txt"
SCORES=""

if [ ! -e "$DONEDB" ]; then
  touch "$DONEDB"
  echo '# weight schecudule_time time task' > $DONEDB
fi

IFS=$'\n'
for dn in `grep -n '[x]' $TODAYDB`
do
  n=`echo $dn | awk -F':' '{print $1}'`
  sed -i '' -e "$n"d $TODAYDB

  task=`echo "$dn" | awk '{for(i=2;i<NF;i++){printf("%s ", $i)}print $NF}'`
  weight=`echo $dn | awk '{print $2}'`
  schedule_time=`echo $dn | awk '{print $3}'`
  finish_time=`echo $dn | awk '{print $4}'`
  score=`echo "$weight - $schedule_time - $finish_time" | bc`
  echo "$task $score" >> $DONEDB
done
