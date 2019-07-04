#!/usr/bin/env bash

# ******************************
# *                            *
# *     Developer Tools        *
# *                            *
#*******************************


function _installDevTools() {

  unset THISNAME PACKAGES NODEMDL RUBYGEM PKG REPLY MDL GEM

  local THISNAME='Developer Tools'
  local PACKAGES=( git node ruby )
  local NODEMDL=( grunt-cli postcss-cli autoprefixer cssnano html-minifier uglifyjs-folder bimbumbam )
  local RUBYGEM=( bundler jekyll jekyll-paginate jekyll-sitemap babibo )

  if [[ CHKXCODE=0 && CHKBREW=0 ]]; then
    _f_alert_check "Checking for ${THISNAME} to install..."
    for PKG in "${PACKAGES[@]}"; do
      if [[ ! -d $(brew --cellar ${TOOL} 2>/dev/null) ]]; then
        read -p "$(_f_alert_warning "${PKG} NOT PRESENT ... do I install it? [yN]")" -n 1
        echo ''
        if [[ $REPLY =~ ^[Yy]$ ]]; then
          brew install "${PKG}"
          _f_alert_success "${PKG} Installed"
          case ${PKG} in
            node)
              for MDL in "${NODEMDL[@]}"; do
                npm install -g ${MDL}
                _f_alert_pkg "${PKG} ${MDL} Installed"
                done
              ;;
            ruby)
              for GEM in "${RUBYGEM[@]}"; do
                gem install ${GEM}
                _f_alert_pkg "${PKG} ${GEM} Installed"
                done
                gem update --system
              ;;
          esac
        fi
      else
        _f_alert_notice "${ORANGE}${PKG}${RESET} already installed ... "
        source utils/f_chk_for_packages
      fi
    done
  else
    _f_alert_warning "You have to install Homebrew!"
  fi
    _f_alert_success "${THISNAME}"
}

_installDevTools
_f_by_by
