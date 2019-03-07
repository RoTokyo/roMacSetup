#!/usr/bin/env bash

# ******************************
# *                            *
# * Prepare jpg for site: KaF  *
# *                            *
#*******************************


set -o errexit
set -o pipefail
set -o errtrace
#set -o nounset
#set -o xtrace

readonly PROGNAME="$(basename $0)"
readonly PROGPATH="$(dirname $0)"

_main () {

	unset THISNAME ORIGIN DESTINATION REPLY

	set -u

	local THISNAME='Prepare jpg for site: KaF'
	local ORIGIN="$HOME/Pictures/zz-images/AA-source/"
	local DESTINATION="$HOME/Pictures/zz-images/AA-destination/"

	_f_title () {
		cat <<_EOF_

[    title] ================================
            ** ${THISNAME}  **
            **          function!         **
            ================================

_EOF_
	}

	_convert_jpg_for_kaf () {

		_convert_1200 () {
			convert \
				$ORIGIN/$REPLY.jpg \
				-resize 1200 \
				-quality 85 \
				-define jpeg:fancy-upsampling=off \
				-unsharp 0.25x0.25+8+0.065 \
				-dither None \
				-interlace none \
				-colorspace sRGB \
				-strip \
				$DESTINATION/$REPLY.jpg
		}

		_convert_thumb () {
		  convert \
		  	$ORIGIN/$REPLY.jpg \
	  		-thumbnail 420x280 \
	  		-unsharp 0.25x0.25+8+0.065 \
	  		-dither None \
	  		-posterize 136 \
	  		-define jpeg:fancy-upsampling=off \
	  		-interlace none \
	  		-colorspace sRGB \
	  		-strip \
	  		$DESTINATION/$REPLY-thumb.jpg
		}

		_convert_blur () {
			convert \
				$ORIGIN/$REPLY.jpg \
				-thumbnail 24x16 \
				-filter Gaussian \
				-blur 0x8 \
	  		$DESTINATION/$REPLY-blur.jpg
		}

		read -p "$(_f_alert_input "Insert jpg file name ... without extention ... :")" REPLY; echo ''
		if [[ "$REPLY" != "" ]]; then
			if [[ $(identify -ping -format '%w' ${ORIGIN}${REPLY}.jpg) -ge '1200' ]]; then
				_convert_1200
				_f_alert_info "File $REPLY.jpg creato."
				else
					_f_alert_warning "Image file too small!"
					_safeExit
			fi
			_convert_thumb
	  		_f_alert_info "File $REPLY-thumb.jpg creato."
	  	_convert_blur
	  		_f_alert_info "File $REPLY-blur.jpg creato."
		fi
		_f_alert_success "${THISNAME} executed!"

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

	  echo -e "${COLOR}$(printf "[%9s]" "${1}") ${MESSAGE}${RESET}"
	}


	_f_alert_info ()      { local MESSAGE="${*}"; echo "$(_alert info)"; }
	_f_alert_input ()     { local MESSAGE="${*}"; echo "$(_alert input)"; }
	_f_alert_notice ()    { local MESSAGE="${*}"; echo "$(_alert notice)"; }
	_f_alert_success ()   { local MESSAGE="${*}"; echo "$(_alert success)"; }
	_f_alert_warning ()   { local MESSAGE="${*}"; echo "$(_alert warning)"; }

	_safeExit() {
		cat <<_EOF_

[     exit] ================================
            ** ${THISNAME} **
            **          function!        **
            ================================

_EOF_
		read -p "$(_f_alert_input 'Press any button to EXIT ⧳ ')" -n 1
		clear
	  trap - INT TERM EXIT
		unset THISNAME ORIGIN DESTINATION REPLY
	  exit
	}

	_f_title
	_convert_jpg_for_kaf
	_safeExit

}

_main
