#!/usr/bin/env bash

# CREDITS: https://gist.github.com/pythoninthegrass/9e4d3ef0f2036746467add17c76b4c15
# TODO: case user conf; rm `sleep` shenaynays

# Logs
logTime=$(date +%Y-%m-%d:%H:%M:%S)
uninstallLog="/tmp/$(basename "$0" | cut -d. -f1)_$logTime.log"
exec &> >(tee -a "$uninstallLog")

# Current user
loggedInUser=$(stat -f%Su /dev/console)

# Working directory
scriptDir=$(cd "$(dirname "$0")" && pwd)

# Ensure running as root
if [[ "$(id -u)" != "0" ]]; then
  exec sudo "$0" "$@"
fi

# Set $IFS to eliminate whitespace in pathnames
IFS="$(printf '\n\t')"

#   Office 2016 for Mac uninstaller
# ###################################

#        Unofficial uninstaller
#     Brought to you by Frank Pira
#             (fpira.com)
#     Modified by /u/pythoninthegrass
# https://gist.github.com/pythoninthegrass

# This software comes with absolutely
#             NO WARRANTY

#       Use it at your own risk.
# "

# sleep 4

# Remove MS Apps sans RDP
msArray=($(find /Applications -maxdepth 1 -name "Microsoft*" ! -name "*Remote Desktop*"))
# echo $msArray
echo "Removing Office 2016 apps..."
cd /Applications || exit
for a in "${msArray[@]}"; do
    echo "Removed $a."
    [[ -f "$a" ]] && rm -f "$a"
done

# ~/Library PLISTs
declare -a userLibrArray=(
    com.microsoft.errorreporting
    com.microsoft.Excel
    com.microsoft.netlib.shipassertprocess
    com.microsoft.Office365ServiceV2
    com.microsoft.Outlook
    com.microsoft.Powerpoint
    com.microsoft.RMS-XPCService
    com.microsoft.Word
    com.microsoft.onenote.mac
)
# echo $userLibrArray

echo "Cleaning ~/Library..."
cd "/Users/$loggedInUser/Library/Containers" || exit
for u in "${userLibrArray[@]}"; do
    # echo "Removed $u."
    [[ -f "$u" ]] && rm -f "$u"
done

cd "/Users/$loggedInUser/Library//Group Containers" || exit
containArray=($(find /Users/"$loggedInUser"/Library/Group\ Containers -maxdepth 1 -name "UBF8T346G9*"))
for c in "${containArray[@]}"; do
    # echo "Removed $c."
    [[ -f "$c" ]] && rm -f "$c"
done

# further cleaning

echo "Cleaning system folders..."
rm -rf "/Library/Application Support/Microsoft/MAU2.0"
rm -rf "/Library/Fonts/Microsoft"

# /Library PLISTs
declare -a sysLibrArray=(
    com.microsoft.office.licensing.helper.plist
    com.microsoft.office.licensingV2.helper.plist
    com.microsoft.Excel.plist
    com.microsoft.office.plist
    com.microsoft.office.setupassistant.plist
    com.microsoft.outlook.databasedaemon.plist
    com.microsoft.outlook.office_reminders.plist
    com.microsoft.Outlook.plist
    com.microsoft.PowerPoint.plist
    com.microsoft.Word.plist
    com.microsoft.office.licensingV2.plist
    com.microsoft.autoupdate2.plist
    com.microsoft
    com.microsoft.office.licensing.helper
    com.microsoft.office.licensingV2.helper
)
# echo $userLibrArray

cd "/Library" || exit
for s in "${sysLibrArray[@]}"; do
    # echo "Removed $s."
    [[ -f "$s" ]] && rm -f "$s"
done

find "/Library/Receipts" -name "Office2016_*" -exec -rm -r -rf {} \;

# /Library PLISTs
declare -a packArray=(
    com.microsoft.package.Fonts
    com.microsoft.package.Microsoft_AutoUpdate.app
    com.microsoft.package.Microsoft_Excel.app
    com.microsoft.package.Microsoft_OneNote.app
    com.microsoft.package.Microsoft_Outlook.app
    com.microsoft.package.Microsoft_PowerPoint.app
    com.microsoft.package.Microsoft_Word.app
    com.microsoft.package.Proofing_Tools
    com.microsoft.package.licensing
)
# echo $packArray

echo "Making your Mac forget about Office 2016..."
for p in "${packArray[@]}"; do
    # echo "Removed $p."
    [[ -f "$p" ]] && pkgutil --forget "$p"
done

echo "Fini!"

unset IFS