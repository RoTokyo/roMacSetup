#!/usr/bin/env bash

# ******************************
# *                            *
# *   Install .dots files      *
# *                            *
#*******************************


_installDotFiles () {

	unset THISNAME RSYNCFILE

	local THISNAME='Files'

	_f_rsync_dot () {
		rsync "$@" \
	    --exclude '.git/' \
	    --exclude 'utils/' \
			--exclude '.DS_Store' \
	    --exclude 'zz_*' \
	    --exclude "f_i_*.sh" \
	    --exclude 'Icon?' \
	    --exclude '*.md' \
	    --exclude '*.txt' \
	    --exclude 'macosx.sh' \
			-zav --no-perms . ~;
		# source ~/.bash_profile;
	}

	_f_alert_check "Checking for ${THISNAME} to install..."

	_f_alert_notice "File missing or overwriting ... "

	RSYNCFILE=$(_f_rsync_dot --dry-run) # |  grep '^[.]')
	IFS=$'\n'
	for I in $RSYNCFILE; do
		_f_alert_notice "${PURPLE}${I}${RESET}"
		done


	read -p "$(_f_alert_warning "Overwriting ... Continue? ... [yN]")" -n 1
	echo ''

	if [[ $REPLY =~ ^[Yy]$ ]]; then
	  _f_rsync_dot
		fi
	_f_alert_success "Install ${THISNAME}"

}

_installDotFiles
_f_by_by
