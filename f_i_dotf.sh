#!/usr/bin/env bash

# ******************************
# *                            *
# *   Install .dots files      *
# *                            *
#*******************************
#


ORIGIN="$( cd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null && pwd )"
DESTINATION="${HOME}/Desktop/test/"
BASHFILES=(".bash_profile" ".bash_prompt" ".bash_aliases" ".bash_export" ".bash_functions")
GITFILES=(".gitattributes" ".gitconfig" ".gitignore")
VIMFILES=(".vimrc" ".vim")
OTHERFILES=(".editorconfig" ".hushlogin")


_installFiles () {
  ARRAY=("$@")
  #for file in ${ORIGIN}/.{bash_profile,bash_prompt,bash_aliases,bash_export,bash_functions}; do
  for file in ${ORIGIN}/"${ARRAY[@]}"; do
    filename="${file##*/}"
    if [[ -f ${DESTINATION}/${filename} ]] && [[ ! -L ${DESTINATION}/${filename} ]]
      then
        _f_alert_warning "File ${filename} EXISTS ... "
        seek_confirmation " ................................ do you want to backup? [yN]"
        if is_confirmed; then
          mv ${DESTINATION}/${filename}  ${DESTINATION}/${filename}.bak
          _f_alert_success "${filename} backup successfull!"
        fi
    fi

    if [[ -L ${DESTINATION}/${filename} ]]
      then
        _f_alert_warning "Symlink ${filename} EXISTS ... "
        seek_confirmation " ................................ overwrite? [yN]"
        if is_confirmed; then
          ln -sfn ${ORIGIN}/${filename} ${DESTINATION}/
          _f_alert_notice "${filename} symlink overwritten!"
        fi
    fi

    if [[ ! -f ${DESTINATION}/${filename} ]]
      then
        seek_confirmation "File ${filename} DO NOT EXISTS ... creating symlink? [yN]"
        if is_confirmed; then
          ln -s ${ORIGIN}/${filename} ${DESTINATION}/
          _f_alert_info "${filename} symlink created!"
        fi
    fi

  done

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
  if [[ "${1}" = "error" ]]; then local COLOR="${BOLD}${RED}"; fi
  if [[ "${1}" = "header" ]]; then local COLOR="${BOLD}""$(tput setaf 3)"; fi     # TAN color
  if [[ "${1}" = "checking" || "${1}" = "info" || "${1}" = "notice" || "${1}" = "pkg" ]]; then local COLOR=""; fi
  if [[ "${1}" = "input" ]]; then local COLOR="${ORANGE}"; fi
  if [[ "${1}" = "install" ]]; then local COLOR="${BOLD}"; fi
  if [[ "${1}" = "menu" ]]; then local COLOR="${ORANGE}"; fi
  if [[ "${1}" = "success" ]]; then local COLOR="$(tput setaf 76)"; fi            # GREEN color
  if [[ "${1}" = "warning" ]]; then local COLOR="$(tput setaf 1)"; fi             # RED color

  echo -e "${COLOR}$(printf "[%9s]" "${1}") ${_MESSAGE}${RESET}" 
}

_f_alert_error()   { local _MESSAGE="${*}"; echo    "$(_alert error)"; }
_f_alert_check()   { local _MESSAGE="${*}"; echo    "$(_alert checking)"; }
_f_alert_info()    { local _MESSAGE="${*}"; echo    "$(_alert info)"; }
_f_alert_notice()  { local _MESSAGE="${*}"; echo    "$(_alert notice)"; }
_f_alert_pkg()     { local _MESSAGE="${*}"; echo    "$(_alert pkg)"; }
_f_alert_input()   { local _MESSAGE="${*}"; echo    "$(_alert input)"; }
_f_alert_install() { local _MESSAGE="${*}"; echo    "$(_alert install)"; }
_f_alert_menu()    { local _MESSAGE="${*}"; echo    "$(_alert menu)"; }
_f_alert_success() { local _MESSAGE="${*}"; echo    "$(_alert success)"; }
_f_alert_warning() { local _MESSAGE="${*}"; echo    "$(_alert warning)"; }

_byby() {
  cat <<_EOF_

[     exit]

_EOF_
	read -p "$(_f_alert_input 'Press any button to EXIT ⧳ ')" -n 1
	unset ORIGIN DESTINATION
	clear
	exit
}

#_installFiles "${BASHFILES[@]}"
#_installFiles "${GITFILES[@]}"
#_installFiles "${OTHERFILES[@]}"
_byby
