#!/bin/bash

ID=
CURRENT=`dirname $0`
DBPATH="$CURRENT/../db"
TASKDB="$DBPATH/task.txt"

get_id () {
  last_id=`cat $TASKDB | sort -n | awk '{print $1}' | tail -n1`
  if [ -z "$last_id" ]; then
    ID=1
  else
    ID=`expr $last_id + 1`
  fi
}

if [ ! -e "$TASKDB" ]; then
  touch "$TASKDB"
fi

get_id
echo "$ID $@" >> $TASKDB
