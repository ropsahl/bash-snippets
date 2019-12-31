#!/usr/bin/env bash
export ME=$(basename $0)
export MY_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )
#echo MYDIR ${MY_DIR}
#echo ME ${ME}

function list() {
  echo List of examples in $MY_DIR/$ME
  while read line ;do
  if [[ ${line} =~ ^function ]] ; then
    local lineAfterFunction=${line##function }
    echo "     ${lineAfterFunction%%\(*}"
  fi
  done < $MY_DIR/$ME
}

function lines_containing() {
 echo grep $1
}

#echo $@
if [[  $# -eq 0 ]] ; then
  list
else
  eval $1
fi

