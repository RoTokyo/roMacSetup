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

  if [[ CHKXCODE=0 && CHKBREW=0 ]]; then
    _f_alert_notice "xCode command line tools present"
    _f_alert_notice "${THISNAME} present"
    read -p "$(_f_alert_warning "Do you want to update? [yN]")" -n 1
    echo ''
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      _f_alert_info "brew update"; brew update
      _f_alert_info "brew cleanup"; brew cleanup
      _f_alert_info "brew doctor"; brew doctor
    fi
    _f_alert_check "Checking for ${THISNAME} packages ..."
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
  elif [[ CHKXCODE=1 ]]; then
    _f_alert_notice "xCode command line tools not installed"
    read -p "$(_f_alert_warning "Install OSX Command Line Tools? [yN]")" -n 1
    echo ''
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      xcode-select --install
      CHKXCODE=0
      _f_alert_success "Command Line Tools installed"
    fi
  elif [[ CHKXCODE=0 && CHKBREW=1 ]]; then
    _f_alert_notice "${THISNAME} not installed"
    read -p "$(_f_alert_warning "Install OSX ${THISNAME}? [yN]")" -n 1
    echo ''
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      #ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
      _f_alert_success "${THISNAME} installed"
    fi

  fi
  unset THISNAME REPLAY
  _f_alert_success "${THISNAME}"
}

_installHomebrew

_f_by_by
