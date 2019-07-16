#!/usr/bin/env bash

# ******************************
# *                            *
# *      Connect to host       *
# *                            *
#*******************************


set -o errexit
set -o pipefail
set -o errtrace
#set -o nounset
#set -o xtrace


readonly PROGNAME="$(basename $0)"
readonly PROGPATH="$(dirname $0)"
readonly  DIRNAME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
readonly SCROWNER="$(ls -ls ${DIRNAME}/${PROGNAME} | awk '{print $4":"$5}')"

_main () {

	unset THISNAME ORIGIN DESTINATION REPLY

	set -u

	local THISNAME='Connect to host'
	RED=$(tput setaf 1)

	_f_title () {
		cat <<_EOF_

[     help] ================================================
            ** you'll need to create a ~/.ssh/config file **
            ** so that host is mapped to IP addresses:    **
            **                                            **
            ** Host host                                  **    
            ** HostName 192.168.1.4                       **
            ** User root                                  **
            ** StrictHostKeyChecking no                   **
            ================================================

_EOF_
	}

	_f_select() {	
		_f_alert_info 'Enter the number of the file you want to view:'; echo ''
	
		PS3="${RED}[     input]      Your choice: ${RESET}"

		select INPUT_STRING in host eXit
			do 
				if [[ "${INPUT_STRING}" = 'host' ]]; then
					ssh $INPUT_STRING 2>&1 /dev/null
					else
						break
					fi
				done
	}


	_alert() {

		ORANGE=$(tput setaf 166)
		RED=$(tput setaf 1)
		RESET=$(tput sgr0)
		TAN=$(tput setaf 3)

	  if [[ "${1}" = "info" || "${1}" = "notice" ]];    then local COLOR=""; fi
		if [[ "${1}" = "input" ]];   then local COLOR="${ORANGE}"; fi
		if [[ "${1}" = "success" ]]; then local COLOR="${TAN}"; fi
	  if [[ "${1}" = "warning" ]]; then local COLOR="${RED}"; fi

	  echo -e "${COLOR}$(printf "[%9s]" "${1}") ${MESSAGE}${RESET}"
	}


	_f_alert_info ()      { local MESSAGE="${*}"; echo "$(_alert info)"; }
	_f_alert_input ()     { local MESSAGE="${*}"; echo "$(_alert input)"; }
	_f_alert_notice ()    { local MESSAGE="${*}"; echo "$(_alert notice)"; }
	_f_alert_success ()   { local MESSAGE="${*}"; echo "$(_alert success)"; }
	_f_alert_warning ()   { local MESSAGE="${*}"; echo "$(_alert warning)"; }

	_safeExit() {
		cat <<_EOF_

[     exit] ================================
            **      ${THISNAME}       **
            **    function terminated!    **
            ================================

_EOF_
		read -p "$(_f_alert_input 'Press any button to EXIT ⧳ ')" -n 1
		clear
	  trap - INT TERM EXIT
		unset THISNAME ORIGIN DESTINATION REPLY
	  exit
	}
	_f_title
	_f_select
	_safeExit

}

_main
