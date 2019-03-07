#!/usr/bin/env bash

# ******************************
# *                            *
# *           Help             *
# *                            *
#*******************************

_showHelp () {

  _f_alert_info "Installation routine for MAC OSX!"
  _f_alert_info "Version: ${VERSION}"
  _f_alert_info "Routine: ${PROGNAME}"
  _f_alert_info "   Path: $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
  
	if [[ $INTCONN = 0 ]]; then
		_f_alert_notice "Internet connection required to update on install packages"
		else
			_f_alert_warning '  Unable to connect to internet ... some functions unabled! '
		fi

  echo ''
  _f_alert_notice "${TAN}Choose:${RESET}
            1 - Upadte OSX
            2 - Configure OSX GUI
            3 - Install: Homebrew & Utilities
            4 - Install: GIT NODE RUBY
            5 - Install: Cask & Application
            6 - Install: Atom & Packages
            7 - Install: dot files & Extra

            A - To install all
            0 - To EXIT"
}

_showHelp
_f_by_by