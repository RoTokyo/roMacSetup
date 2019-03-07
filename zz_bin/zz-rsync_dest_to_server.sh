#!/usr/bin/env bash

# ******************************
# *                            *
# * Syncronize WebServer Files *
# *                            *
#*******************************


set -o errexit
set -o pipefail
set -o errtrace
#set -o nounset
#set -o xtrace

readonly PROGNAME="$(basename $0)"
readonly PROGPATH="$(dirname $0)"

_main () {

	unset THISNAME ORIGIN DESTINATION REPLY

	local THISNAME='Syncronize WebServer Files'
	local ORIGIN="./dest/"
	local DESTINATION="$HOME/Sites/"

	_f_title () {
		cat <<_EOF_

[    title] ================================
            ** ${THISNAME} **
            **          function!         **
            ================================

_EOF_
	}

	_rSync_WebSite_Files () {

		_f_rsync () {
			rsync "$@" \
		    --exclude '.git/' \
				--exclude '.DS_Store' \
		    --exclude 'Icon?' \
		    --exclude '*.sh' \
				-zav --no-perms ${ORIGIN} ${DESTINATION};
		}

		_f_alert_notice "File in sincro: Some files may be deleted!"; echo ''
		_f_rsync --dry-run --delete; echo ''
		read -p "$(_f_alert_warning 'Do you want to syncronize? ... [yN]')" -n 1; echo ''
		if [[ $REPLY =~ ^[Yy]$ ]]; then
		  _f_rsync --delete
		fi
		_f_alert_success "${THISNAME} executed!"
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
            ** ${THISNAME} **
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
	_rSync_WebSite_Files
	_safeExit

}

_main
