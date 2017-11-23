#!/bin/bash

CURRENT=`dirname $0`
DBPATH="$CURRENT/../db"
TASKDB="$DBPATH/task.txt"
TODAYDB="$DBPATH/today.txt"
SCORES=""

IFS=$'\n'
for dn in `grep '[x]' $TODAYDB`
do
  weight=`echo $dn | awk '{print $2}'`
  schedule_time=`echo $dn | awk '{print $3}'`
  finish_time=`echo $dn | awk '{print $4}'`
  score=`echo "$weight - $schedule_time - $finish_time" | bc`
  echo "$dn => $score"
  SCORES="$SCORES$score,"
done

len=`echo ${#SCORES}`
fin=`expr $len - 1`

SCORES=`echo ${SCORES:0:$fin}`

IFS=','
SUM=0
for score in $SCORES
do
  SUM=`echo "$SUM + $score" | bc`
done

echo "sum: $SUM"
