#!/usr/bin/env bash

# ******************************
# *                            *
# *     Configure OSX GUI      *
# *                            *
#*******************************
# Credits https://pawelgrzybek.com/change-macos-user-preferences-via-command-line/

_installOSXsetup() {

  unset THISNAME DATA

  local THISNAME='Configure OSX GUI'
  local DATA=$(date +%Y-%m-%d-%S)

	_f_alert_check "Checking for ${THISNAME} ..."

# * Backup before changes
	_f_alert_notice "Backup before changes in file ${DATA}_before.txt"

  read -p "$(_f_alert_warning "Overwriting ... Continue? ... [yN]")" -n 1
  echo ''
	if [[ $REPLY =~ ^[Yy]$ ]]; then
    defaults read > zz_pref_pane_settings/${DATA}_before.txt

    osascript -e 'tell application "System Preferences" to quit'
    # To make changes that require system password uncomment following
  	#sudo -v
    #while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# * Boot
		# Disable the sound effects on boot
		sudo nvram SystemAudioVolume=" "

# * System
		# Save to disk (not to iCloud) by default
		defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
		# Remove duplicates in the “Open With” menu (also see `lscleanup` alias)
		/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user
		# Disable auto-correct
		defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
		# Always show scroll bars
		defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
		# Show all filename extensions in Finder by default
		defaults write NSGlobalDomain AppleShowAllExtensions -bool false
		# Avoid creation of .DS_Store files on network volumes
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# * Language
    defaults write NSGlobalDomain AppleLanguages -array "it"
    defaults write NSGlobalDomain AppleLocale -string "it_IT@currency=EUR"
    defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
    defaults write NSGlobalDomain AppleMetricUnits -bool true

# * Screen
		# System Preferences > Desktop & Screen Saver > Start after: Never
		defaults -currentHost write com.apple.screensaver idleTime -int 0
		# Require password immediately after sleep or screen saver begins
		defaults write com.apple.screensaver askForPassword -int 1
		defaults write com.apple.screensaver askForPasswordDelay -int 0

# * Finder
		# Show the ~/Library folder
		chflags nohidden ~/Library
		# Show the /Volumes folder
		# sudo chflags nohidden /Volumes
    # Show icons for hard drives, servers, and removable media on the desktop
    defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
    defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
    defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
    defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
    #
		defaults write com.apple.finder NewWindowTarget -string "PfHm"
		defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"
    # Finder: show status bar
    defaults write com.apple.finder ShowStatusBar -bool true
    # Finder: show path bar
    defaults write com.apple.finder ShowPathbar -bool true

# * Terminal
    # Stop “Resume” feature
    defaults write com.apple.Terminal NSQuitAlwaysKeepsWindows -bool false

# * Dock
		# System Preferences > Dock > Automatically hide and show the Dock:
		defaults write com.apple.dock autohide -bool true
		# System Preferences > Dock > Show indicators for open applications
		defaults write com.apple.dock show-process-indicators -bool true

# * Trackpad
		# System Preferences > Trackpad > Tap to click
		defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
    defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
    defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
    # Disable “natural” (Lion-style) scrolling
    defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# * Photos
    # Save screenshots in JPG format (other options: BMP, GIF, JPG, PDF, TIFF)
		# Prevent Photos from opening automatically when devices are plugged in
		defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true
		defaults -currentHost write com.apple.ImageCapture2 HotPlugActionPath ''
    # Save screenshots to the desktop
    defaults write com.apple.screencapture location -string "$HOME/Desktop"
		defaults write com.apple.screencapture type jpg

# * iMail
		# Disable signing emails by default
		# defaults write ~/Library/Preferences/org.gpgtools.gpgmail SignNewEmailsByDefault -bool false

		# Kill affected apps
		for app in "Dock" "Finder"; do
			killall "${app}" > /dev/null 2>&1
		done

    # * Backup after changes
    	_f_alert_notice "Backup after changes in file ${DATA}_after.txt"
    	defaults read > zz_pref_pane_settings/${DATA}_after.txt

	    _f_alert_warning "Some changes require a logout/restart to take effect."

	fi

	_f_alert_success "${THISNAME}"

  unset THISNAME DATA

}

_installOSXsetup
_f_by_by
