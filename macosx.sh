#!/usr/bin/env bash

# ******************************
# *                            *
# *       Main menu            *
# *                            *
#*******************************


set -o errexit
set -o pipefail
#set -o nounset
#set -o xtrace

VERSION="1.0.0"
PROGNAME="$(basename $0)"
PROGPATH="$(dirname $0)"
UTILPATH="${PROGPATH}/utils"

source "${UTILPATH}/v_colors"
source "${UTILPATH}/f_alert"
source "${UTILPATH}/f_function"
source "${UTILPATH}/f_set_variables"


_main_code () {

	local readonly DELAY=2
	
	while [[ $REPLY != 0 ]]; do
		clear && echo ''
		if [[ $INTCONN = 1 ]]; then
			echo '';  _f_alert_warning '  Unable to connect ... some functions unabled! '; echo ''
			fi
		
  	cat <<_EOF_
  Installation routine:
    1. Update OSX
    2. Configure OSX GUI
    3. Install Homebrew
    4. Developer Tools : git node ruby ...
    5. Cask & Application
    6. vsCodium & Packages
    7. Install dot files & Extra

    A. All
    ?. Help

    0. eXit

_EOF_
  	read -p "Enter selection [0-9] > "
  	if [[ $REPLY =~ ^[0-9]$ || $REPLY =~ ^[?]$ || $REPLY =~ ^[A]$ ]]; then
    	if [[ $REPLY == 0 ]]; then
        echo ''; _f_alert_menu '  eXit Installation Routine! Wait ...'; echo ''
      	sleep $DELAY
				clear
    	fi
			if [[ $REPLY == '?' ]]; then
				clear
        echo ''; _f_alert_menu 'Help Routine'; echo ''
      	source "${PROGPATH}/f_i_help.sh"
    	fi
			if [[ $REPLY == 'A' ]]; then
				clear
        echo ''; _f_alert_menu '  XXXXXX'; echo ''
      	sleep $DELAY
    	fi
    	if [[ $REPLY == 1 ]]; then
        clear
      	echo '';  _f_alert_menu '  1. Update OSX '; echo ''
      	source "${PROGPATH}/f_i_osxupdate.sh"
    	fi
    	if [[ $REPLY == 2 ]]; then
        clear
      	echo '';  _f_alert_menu '  2. Configure OSX GUI '; echo ''
        source "${PROGPATH}/f_i_osxsetup.sh"
    	fi
    	if [[ $REPLY == 3 ]]; then
    		clear
      	echo '';  _f_alert_menu '  3. Install Homebrew'; echo ''
      	source "${PROGPATH}/f_i_brew.sh"
    	fi
    	if [[ $REPLY == 4 ]]; then
        clear
        echo ''; _f_alert_menu '  4. Developer Tools'; echo ''
        source "${PROGPATH}/f_i_devtools.sh"
    	fi
      if [[ $REPLY == 5 ]]; then
    		clear
      	echo ''; _f_alert_menu '  5. Cask & Application'; echo ''
      	source "${PROGPATH}/f_i_cask.sh"
    	fi
      if [[ $REPLY == 6 ]]; then
    		clear
      	echo ''; _f_alert_menu '  6. Atom & Packages'; echo ''
      	source "${PROGPATH}/f_i_atom.sh"
    	fi
      if [[ $REPLY == 7 ]]; then
    		clear
      	echo ''; _f_alert_menu '  7. Install dot files'; echo ''
      	source "${PROGPATH}/f_i_dotf.sh"
    	fi
    	else
        _f_alert_warning '  Invalid entry! Wait ...'
      	sleep $DELAY
  	fi
	done
  unset DELAY REPLY
}

_main_code
_f_exit
