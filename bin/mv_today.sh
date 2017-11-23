#!/bin/bash

CURRENT=`dirname $0`
DBPATH="$CURRENT/../db"
TASKDB="$DBPATH/task.txt"
TODAYDB="$DBPATH/today.txt"

if [ ! -e "$TODAYDB" ]; then
  touch "$TODAYDB"
  echo '# status weight schecudule_time time task' > $TODAYDB
fi

for id in "$@"
do
  full=`cat $TASKDB | grep "$id "`
  if [ "$?" == 1 ]; then
    continue
  fi

  # n=`cat $TASKDB | grep -n "$id " | awk -F':' '{print $1}'`
  #sed -i '' -e "$n"d $TASKDB

  task=`echo "$full" | awk '{for(i=2;i<NF;i++){printf("%s ", $i)}print $NF}'`
  echo "-[] $task" >> $TODAYDB
done
