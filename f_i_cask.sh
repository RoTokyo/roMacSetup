#!/usr/bin/env bash

# ******************************
# *                            *
# *      Brew Cask & Apps      *
# *                            *
#*******************************


_installCask() {

  unset THISNAME PACKAGES PKG REPLAY

  local THISNAME='Homebrew Cask'
  local PACKAGES=( 'alfred 3' bartender flycut gimp insomniax loading moom typora )

  if [[ CHKXCODE=0 && CHKBREW=0 ]]; then
    _f_alert_check "Checking for ${THISNAME} to install ..."
    if [[ ! $(brew info cask 2>/dev/null) ]]; then
      _f_alert_warning "Cask not present ... not yet understood how to ... "
      else
        _f_alert_notice "${THISNAME} present"
        for PKG in "${PACKAGES[@]}"; do
          if [[ ! -d /Applications/${PKG}.app ]]; then
            read -p "$(_f_alert_warning "${PKG} NOT PRESENT ... do I install it? [yN]")" -n 1
            echo ''
            if [[ $REPLY =~ ^[Yy]$ ]]; then
              brew cask install "${PKG}"
              _f_alert_success "${PKG} Installed"
              fi
            else
              _f_alert_pkg "${PURPLE}${PKG}${RESET} already installed ... "
            fi
        done
        fi
      else
        _f_alert_warning "You have to install Homebrew!"
    fi
	_f_alert_success "${THISNAME}"
  unset THISNAME TOOL
}

_installCask
_f_by_by
