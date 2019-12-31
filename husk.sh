#!/usr/bin/env bash
#escape
SAVE_POS=$(echo -en '\033[s')
RESTORE_POS=$(echo -en '\033[u')
DEL_EOL=$(echo -en '\033[K')
RESTORE=$(echo -en '\033[0m')
RED=$(echo -en '\033[00;31m')
GREEN=$(echo -en '\033[00;32m')
YELLOW=$(echo -en '\033[00;33m')
BLUE=$(echo -en '\033[00;34m')
MAGENTA=$(echo -en '\033[00;35m')
PURPLE=$(echo -en '\033[00;35m')
CYAN=$(echo -en '\033[00;36m')
LIGHTGRAY=$(echo -en '\033[00;37m')
LRED=$(echo -en '\033[01;31m')
LGREEN=$(echo -en '\033[01;32m')
LYELLOW=$(echo -en '\033[01;33m')
LBLUE=$(echo -en '\033[01;34m')
LMAGENTA=$(echo -en '\033[01;35m')
LPURPLE=$(echo -en '\033[01;35m')
LCYAN=$(echo -en '\033[01;36m')
WHITE=$(echo -en '\033[01;37m')

v=30

#for#range
for i in {1..40};do echo -n ${SAVE_POS}; echo -n $i $(echo -en "\033[00;${v}m") $v $(echo -en '\033[01;37m');v=$((v+1));sleep 0.1;echo -n ${RESTORE_POS}${DEL_EOL};done


#variable#substring
var="Hello there"
echo $var:' ${var%% *}' ${var%% *}
echo $var:' ${var##* }' ${var##* }
echo $var:' ${var/th/w}' ${var/th/w}
echo $var:' ${var//e/XX}'  ${var//e/XX}