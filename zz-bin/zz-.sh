#!/usr/bin/env bash

# **********************************
# *                                *
# *   
# *                                *
#***********************************
#

readonly ORIGIN=
readonly DESTINATION=

function _ () {
  unset REPLY

}

function seek_confirmation() {
  #input "$@"
  read -p "$(_f_alert_input "$@")" -n 1
  echo ""
}

function is_confirmed() {
  if [[ "${REPLY}" =~ ^[Yy]$ ]]; then
    return 0
  fi
  return 1
}

_alert() {

  ORANGE=$(tput setaf 166)
	RED=$(tput setaf 1)
	RESET=$(tput sgr0)
	TAN=$(tput setaf 3)

	if [[ "${1}" = "info" || "${1}" = "notice" ]];    then local COLOR=""; fi
	if [[ "${1}" = "input" ]];   then local COLOR="${RED}"; fi
	if [[ "${1}" = "success" ]]; then local COLOR="${TAN}"; fi
	if [[ "${1}" = "warning" ]]; then local COLOR="${RED}"; fi
	if [[ "${1}" = "menu" ]];    then local COLOR="${ORANGE}"; fi

	echo -e "${COLOR}$(printf "[%9s]" "${1}") ${MESSAGE}${RESET}"
}

_f_alert_info ()      { local MESSAGE="${*}"; echo "$(_alert info)"; }
_f_alert_input ()     { local MESSAGE="${*}"; echo "$(_alert input)"; }
_f_alert_notice ()    { local MESSAGE="${*}"; echo "$(_alert notice)"; }
_f_alert_menu()       { local MESSAGE="${*}"; echo "$(_alert menu)"; }
_f_alert_success ()   { local MESSAGE="${*}"; echo "$(_alert success)"; }
_f_alert_warning ()   { local MESSAGE="${*}"; echo "$(_alert warning)"; }

_byby() {
  cat <<_EOF_

[     exit]

_EOF_
	read -p "$(_f_alert_input 'Press any button to EXIT ⧳ ')" -n 1
	unset ORIGIN DESTINATION
	clear
	exit
}

_menu () {

	local readonly DELAY=2

	while [[ $REPLY != 0 ]]; do
		clear && echo ''
  	cat <<_EOF_
  Image manipulation menu:
    1. roTokyo image manipulation routine
    2. blur image for web site
    3. responsive images for web site

    0. eXit

_EOF_
  	read -p "Enter selection [0-3] > "
  	if [[ ${REPLY} =~ ^[0-3]$ ]]; then
    	if [[ ${REPLY} == 0 ]]; then
        echo ''; _f_alert_menu '  eXit Installation Routine! Wait ...'; echo ''
      	sleep ${DELAY}
				clear
    	fi
    	if [[ ${REPLY} == 1 ]]; then
        clear
      	echo '';  _f_alert_menu '  1. roTokyo image manipulation routine '; echo ''
        _roTokyo_image
    	fi
    	if [[ ${REPLY} == 2 ]]; then
        clear
      	echo '';  _f_alert_menu '  2. blur image for web site '; echo ''
        _blur_image
    	fi
    	if [[ ${REPLY} == 3 ]]; then
        clear
      	echo '';  _f_alert_menu '  3. responsive images for web site '; echo ''
        _responsive_image
    	fi
    	else
        _f_alert_warning '  Invalid entry! Wait ...'
      	sleep ${DELAY}
  	fi
	done
  unset DELAY REPLY
}

_menu
_byby
