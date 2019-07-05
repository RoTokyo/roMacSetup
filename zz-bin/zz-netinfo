#!/usr/bin/env bash

# ******************************
# *                            *
# *     Get network info       *
# *                            *
#*******************************
#
# https://apple.stackexchange.com/questions/191879/how-to-find-the-currently-connected-network-service-from-the-command-line

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

	local THISNAME='Get network info'
	local ORIGIN=''
	local DESTINATION=''

	_f_title () {
		cat <<_EOF_

[    title] ================================
            **      ${THISNAME}      **
            **          function!         **
            ================================

_EOF_
	}

	_net_info () {

		local PUBDNS=$(dig +short myip.opendns.com @resolver1.opendns.com)
  	local HOSTNA=$(uname -n)

  	if [[ -z ${PUBDNS} ]]; then # We got an empty string, meaning:
    	PUBDNS='No Internet connection available'
  	fi

  	_f_alert_info "     Public IP: ${PUBDNS}"
  	_f_alert_info "     Hostname : ${HOSTNA}"
  	
  	local PORTS=$(ifconfig -uv | grep '^[a-z0-9]' | awk -F : '{print $1}')
  	for IDX in $PORTS[@]; do
  		local ATTIVA=$(ifconfig -uv $IDX | grep 'status: ' | awk '{print $2}')
  		if [[ "$ATTIVA" = 'active' ]]; then
				local IPADDRESS=$(ifconfig -uv $IDX | grep 'inet ' | awk '{print $2}')
				if [[ -n "$IPADDRESS" ]]; then
					local LABEL=$(ifconfig -uv $IDX | grep 'type' | awk '{print $2}')
        	local NETMASK=$(ipconfig getpacket $IDX | grep 'subnet_mask (ip):' | awk '{print $3}')
        	local ROUTER=$(ipconfig getpacket $IDX | grep 'router (ip_mult):' | sed 's/.*router (ip_mult): {\([^}]*\)}.*/\1/')
        	local DNSSERVER=$(ipconfig getpacket $IDX | grep 'domain_name_server (ip_mult):' | sed 's/.*domain_name_server (ip_mult): {\([^}]*\)}.*/\1/')
        	local MACADDRESS=$(ifconfig -uv $IDX | grep 'ether ' | awk '{print $2}')
        	local QUALITY=$(ifconfig -uv $IDX | grep 'link quality:' | awk '{print $3, $4}')

					_f_alert_network "              : ${LABEL}"

        	case "$LABEL" in
          	Wi-Fi)
          		local AP="/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -I"
          		if [ ! "$(${AP})" = "AirPort: Off" ]; then
								_f_alert_info " Network Name : $(${AP} | grep "\ SSID" | cut -d: -f2- | sed 's/ //')"
								_f_alert_info "Authorisation : $(${AP} | grep "link auth" | awk '{print $3}' | tr '[:lower:]' '[:upper:]')"
								_f_alert_info "Network Speed : $(${AP} | grep "lastTxRate:" | sed 's/.*: //' | sed 's/$/ Mbps/')"
								fi
							;;	
          	*)
            	local NETWORKSPEED=$(ifconfig -uv $IDX | grep 'link rate:' | awk '{print $3, $4}')
            	_f_alert_info "Network Speed : $NETWORKSPEED"
        		esac
        	
        	_f_alert_info "   IP-address : $IPADDRESS"
	        _f_alert_info "  Subnet Mask : $NETMASK"
	        _f_alert_info "       Router : $ROUTER"
	        _f_alert_info "   DNS Server : $DNSSERVER"
	        _f_alert_info "  MAC-address : $MACADDRESS"
	        _f_alert_info " Link quality : $QUALITY"

					fi
  			else
  				echo 2>/dev/null
  			fi
  	done 2>/dev/null


	}

	_alert () {

		ORANGE=$(tput setaf 166)
		RED=$(tput setaf 1)
		RESET=$(tput sgr0)
		TAN=$(tput setaf 3)

	  if [[ "${1}" = "info" || "${1}" = "notice" ]];    then local COLOR=""; fi
		if [[ "${1}" = "input" ]];   then local COLOR="${ORANGE}"; fi
		if [[ "${1}" = "network" ]]; then local COLOR="${TAN}"; fi
		if [[ "${1}" = "success" ]]; then local COLOR="${TAN}"; fi
	  if [[ "${1}" = "warning" ]]; then local COLOR="${RED}"; fi

	  echo -e "${COLOR}$(printf "[%9s]" "${1}") ${MESSAGE}${RESET}"
	}


	_f_alert_info ()      { local MESSAGE="${*}"; echo "$(_alert info)"; }
	_f_alert_input ()     { local MESSAGE="${*}"; echo "$(_alert input)"; }
	_f_alert_network ()   { local MESSAGE="${*}"; echo "$(_alert network)"; }
	_f_alert_notice ()    { local MESSAGE="${*}"; echo "$(_alert notice)"; }
	_f_alert_success ()   { local MESSAGE="${*}"; echo "$(_alert success)"; }
	_f_alert_warning ()   { local MESSAGE="${*}"; echo "$(_alert warning)"; }

	_safeExit() {
		cat <<_EOF_

[     exit] ================================
            **     ${THISNAME}       **
            **    function terminated!    **
            ================================

_EOF_
		read -p "$(_f_alert_input 'Press any button to EXIT ⧳ ')" -n 1
		clear
	  trap - INT TERM EXIT
		unset THISNAME ORIGIN DESTINATION REPLY
	  exit
	}
	_f_title
	_net_info
	_safeExit

}

clear
_main
