#!/usr/bin/env bash

# ******************************
# *                            *
# *     Mac osx update         *
# *                            *
#*******************************


_installOSXupdate() {

  unset THISNAME
  local THISNAME='Mac OSX update'
  local  OSXNAME="$(sw_vers -productName)"
  local  OSXVERS="$(sw_vers -productVersion)"

  case ${OSXVERS} in
    10.9.*) OSXVERS="${OSXVERS} Mavericks" ;;
    10.10.*) OSXVERS="${OSXVERS} Yosemite" ;;
    10.11.*) OSXVERS="${OSXVERS} El Capitan" ;;
    10.12.*) OSXVERS="${OSXVERS} Sierra" ;;
    10.13.*) OSXVERS="${OSXVERS} High Sierra" ;;
    10.14.*) OSXVERS="${OSXVERS} Mojave" ;;
  esac

  _f_alert_info "${OSXVERS} Installed"
  if [[ $INTCONN = 0 ]]; then
		_f_alert_check "Checking for ${THISNAME} ... ${RED}please wait!${RESET}"

		#local SWRUPD="$(softwareupdate -l)"
  	local SWRUPD="$(softwareupdate -l)"
  	if [[ $SWRUPD =~ "No new software available" ]]; then
    	_f_alert_success "MAC OSX UPDATED!"
    	else
    		# SWRUPD=$(softwareupdate -l)
    		if [[ "${SWRUPD}" =~ "No new software available" ]]; then
    			_f_alert_success "MAC OSX UPDATED!"
    			else
      			_f_alert_warning "Update available:"
      			UPDATE=$(echo "{$SWRUPD}" | grep '[*]' | sed 's/^[[:space:]]*\*[[:space:]]//' | sed 's/^Install[[:space:]]//')
      			IFS=$'\n'
      			for I in $UPDATE; do
      				_f_alert_notice "${PURPLE}${I}${RESET}"
							done
    				read -p "$(_f_alert_warning "Do you want to update? [yN]")" -n 1
    				echo ''
    				if [[ $REPLY =~ [Yy]$ ]]; then
    					_f_alert_menu "Choose installation routine:"
							source utils/f_chk_for_osx_update
							fi
					fi
    	fi
		_f_alert_success "${THISNAME}"

		else
			_f_alert_warning '  Unable to connect ... update function disabled! '
		fi

}

_installOSXupdate
_f_by_by
