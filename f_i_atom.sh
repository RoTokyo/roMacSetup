#!/usr/bin/env bash

# ******************************
# *                            *
# *      Atom & Packages       *
# *                            *
#*******************************


_installAtom() {

  unset THISNAME PKG APMPKGS APM

	local THISNAME='Atom & Packages'
	local PKG='atom'
	local APMPKGS=( atom-beautify atom-wrap-in-tag file-icons less-than-slash markdown-writer open-recent pigments selector-to-tag)

  if [[ CHKXCODE=0 && CHKBREW=0 ]]; then
    _f_alert_check "Checking for ${THISNAME} to install ..."

	  if [ ! -e /Applications/Atom.app ]; then
      _f_alert_notice "Atom not installed"
      brew cask install atom
      _f_alert_success "${THISNAME} installed"
      _f_alert_check "Checking for ${THISNAME} packages to install..."
      for APM in "${APMPKGS[@]}"; do
        apm install ${APM}
        _f_alert_success "${APM} Installed"
        done
      else
        _f_alert_info "${ORANGE}${PKG}${RESET} already installed ... "
        source utils/f_chk_for_packages
      fi
    else
      _f_alert_warning "You have to install Homebrew!"
    fi
	_f_alert_success "${THISNAME}"
}

_installAtom
_f_by_by
