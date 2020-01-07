#!/usr/bin/env bash
RED=$(echo -en '\033[00;31m')
GREEN=$(echo -en '\033[01;32m')
#YELLOW=$(echo -en '\033[00;33m')
YELLOW=$(echo -en '\033[0;32m')
WHITE=$(echo -en '\033[00m')
BLUE=$(echo -en '\033[01;34m')

function some_func() {
  date +%H:%M:%S
}

function _tagWindow() {
  _TTAG=$1;
  PS1="\[\e]0;\u@\h:  \w \a\]${BLUE}\w ${RED}$(some_func) ${WHITE}\n\$ "
}

log_bash_persistent_history() {
  cmd=$(history 1)
  if [ "$cmd" != "$PERSISTENT_HISTORY_LAST" ]
  then
    echo $(date +'%Y-%m-%d-%H:%M:%S') ${cmd#* } >> /home/.persistent_history
    export PERSISTENT_HISTORY_LAST="$cmd"
  fi
}

# Stuff to do on PROMPT_COMMAND
run_on_prompt_command() {
    if [[ $? -eq 0 ]] ; then
      log_bash_persistent_history
    fi
    _tagWindow
}

export DATE_TIME='[0-9]*-[0-9]*-[0-9]*[ -][0-9]*:[0-9]*:[0-9]*'
function hgp {
 grep "$1" /home/.persistent_history |sed "s/$DATE_TIME [0-9]* //" |awk '!_[$0]++'|grep --color "$1"
}

export EDITOR='/usr/bin/vi'
PROMPT_COMMAND="run_on_prompt_command"

bind '"\C-p": history-search-backward'
bind '"\C-n": history-search-forward'
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

