#!/usr/bin/env bash

# ******************************
# *                            *
# *     Install Homebrew       *
# *                            *
#*******************************


_installHomebrew() {

  unset THISNAME PACKAGES PKG REPLAY

  THISNAME='Homebrew'
  local PACKAGES=( bash curl grep imagemagick rename rsync wget )


  _f_alert_check "Checking for ${THISNAME} packages to install..."


  for PKG in "${PACKAGES[@]}"; do
    if [[ ! -d $(brew --cellar ${PKG} 2>/dev/null) ]]; then
      read -p "$(_f_alert_warning "${PKG} NOT PRESENT ... do I install it? [yN]")" -n 1
      echo ''
      if [[ $REPLY =~ ^[Yy]$ ]]; then
        brew install "${PKG}"
        _f_alert_success "${PKG} Installed"
      fi
    else
      _f_alert_notice "${PURPLE}${PKG}${RESET} already installed ... "
    fi
  done
  _f_alert_success "${THISNAME}"
}


source utils/f_chk_for_homebrew
_installHomebrew
_f_by_by
