#!/usr/bin/env bash
export ME=$(basename $0)
export MY_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )
#echo MYDIR ${MY_DIR}
#echo ME ${ME}
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

function show_colors() {
  local v=30
 for i in {1..256}; do
   echo -en "\033[38;5;${i}m" $i

   if [ $((i%10)) -eq 0 ] ;then
     echo
  fi
 done
}

function list() {
  echo List of examples in $MY_DIR/$ME
  while read line ;do
  if [[ ${line} =~ ^function ]] ; then
    local lineAfterFunction=${line##function }
    echo "     ${lineAfterFunction%%\(*}"
  fi
  done < $MY_DIR/$ME
}

function show_function() {
  local showcode=0
  IFS=''
  while read line ;do
    if [[ ${line} =~ ^function ]] ; then
      local lineAfterFunction=${line##function }
      if [[ ${lineAfterFunction%%\(*} == $1 ]] ;then
        showcode=1
      fi
    elif [[ ${line} =~ ^\} ]]; then
      showcode=0
    elif [ ${showcode} -eq 1 ]; then
      echo "$line"
    fi
  done < $MY_DIR/$ME
}

function lines_containing() {
 echo grep $1
}

function edit_reorder_elements() {
  # Use sed to select three elements
  # First and second element is any char except -
  # third element is everything else on the line
  echo 'one-two-three'|sed 's/\([^-]*\)-\([^-]*\)-\(.*\)/\3 \2 \1 \2 \1 \3/'
}

function oc_labels_on_image() {
  local ns=$1
  local dc=$2
  eval "$(oc get dc ${dc} -n ${ns} -o json |jq -r '.spec.template.spec.containers[]|.image'|sed 's;.*5000/\(.*\)/\(.*\);oc get isimage -n \1 \2 -o json;')" | jq '.image.dockerImageMetadata.Config.Labels|to_entries[]|select(.key|startswith("io.openshift.build.commit"))'
}

function curl_jq_fylker_og_kommuner() {
  # ./examples.sh curl_jq_fylker_og_kommuner | jq 'select(.kommune|startswith("Li"))'
  curl -k -H 'Accept: application/json' https://ws.geonorge.no/kommuneinfo/v1/fylkerkommuner|jq '.[]|{"fylke": .fylkesnavn,"nummer": .fylkesnummer,"kommune": .kommuner[]| .gyldigeNavn[]|select(.navn != null)| .navn}'
}

function curl_jq_fylker_og_kommuner_sorted() {
  # ./examples.sh curl_jq_fylker_og_kommuner | jq 'select(.kommune|startswith("Li"))'
  curl -k -H 'Accept: application/json' https://ws.geonorge.no/kommuneinfo/v1/fylkerkommuner|jq -S '.[]|{"fylke": .fylkesnavn,"nummer": .fylkesnummer,"kommune": .kommuner[]| .gyldigeNavn[]|select(.navn != null)| .navn}'
}

function variable_operations() {
  v="Some text we can cut and we can slice"
  echo "${GREEN}The text:${WHITE}       $v"
  echo "${GREEN}Until first we:${WHITE} ${v%%we*}"
  echo "${GREEN}Until last we:${WHITE}  ${v%we*}"
  echo "${GREEN}From last we:${WHITE}   ${v##*we}"
  echo "${GREEN}From first we:${WHITE}  ${v#*we}"

}

function encrypted_password_with_curl() {
  echo By example, commands in ${RED} red ${WHITE} command output in ${GREEN} green
  cat <<multiline
${RED}$ cat me.txt
${GREEN}user = "name:passwd"
${RED}$ gpg -c me.txt
$ gpg -d me.txt.gpg
${GREEN}gpg: AES256 encrypted data
gpg: encrypted with 1 passphrase
user = "name:passwd"
${RED}$ gpg -d me.txt.gpg |curl -K - --silent -H 'Content-type: application/json' https://your.server.com/bitbucket/rest/api/1.0/projects/PNAME/repos/repo-name/branches
${GREEN}gpg: AES256 encrypted data
gpg: encrypted with 1 passphrase
{"errors":[{"context":null,"message":"Authentication failed. Please check your credentials and try again.","exceptionName":"com.atlassian.bitbucket.auth.IncorrectPasswordAuthenticationException"}]}user = "name:passwd"}
multiline
  echo ${WHITE}
}

function json_remove_backslash_format() {
  cat |sed 's;\\;;g' |jq .
}

function json_paths() {
  #Trekk ut paths, join med "." for å elementer med space etc, legg på " først og sist og fix array index 0-99 med sed
  cat $1 |jq -r 'paths |map(.|tostring)|join("\".\"")' | sed -e 's;^;";' -e 's;$;";' -e 's;\."\([0-9]\{1,2\}\)";\[\1\];'
}

function for_list_of_strings() {
  declare -a p=('"a"' '"b c d"')
  for p in "${p[@]}";do
    echo $p;
  done
}

function json_edit_jq() {
  local json='{"data":{"name": "knut"}}'
  echo  Original: $json

  echo $json |jq  --arg v 4 '.data.vekt = $v'

  local var='en to tre'
  echo $json |jq  --arg v "$var" '.data.vekt = $v'
}

function arguments() {
  echo $#
  echo $@
}
#echo $@
if [[  $# -eq 0 ]] ; then
  list | sort
else
  $@
fi

