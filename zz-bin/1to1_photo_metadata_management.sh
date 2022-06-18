#!/usr/bin/env bash

# **********************************
# *                                *
# *  erase and write image copy    *
# *                                *
#***********************************
#

ORIGINIMGPATH="${HOME}/Desktop"

read -p 'Insert file name ... :'
echo ''
if [[ "${REPLY}" != "" && -f "${ORIGINIMGPATH}/${REPLY}" ]]; then

  read -p 'Insert photo title (*): ...' TITLE
  echo ''

  echo "${ORIGINIMGPATH}/${REPLY}"
# erase all image metadata
  exiftool -All:All= \
    -TagsFromFile ${ORIGINIMGPATH}/${REPLY} \
  	-Make -Model \
  	-ExposureTime \
    -FNumber \
    -ISO \
    -FocalLength \
    -LensModel \
    ${ORIGINIMGPATH}/${REPLY}

# write copyrights data
# Modifiche:
# -LensModel="Fujifilm XF 18-55mm F2.8-4 R LM OIS" \
# -LensModel="Sigma 30mm F1.4 DC HSM Art" \
# -LensModel="Nikon 105mm F2.8D Micro Nikkor" \
# -LensModel="Sigma 105mm F2.8 DG Macro HSM" \

# -CreatorWorkEmail="roberto.calesini@gmail.com" \
# -CreatorWorkURL="" \

  exiftool \
    -PhotoTitle="${TITLE}" \
    -Creator="Roberto Calesini" \
    -Rights="© 2013 Roberto Calesini. All rights reserved." \
  	-Artist="roTokyo" \
  	-ArtistCity="Tokyo" \
  	-ArtistCountry="Japan" \
    -ArtistWorkURL="https://www.flickr.com/photos/rotokyo/albums" \
    -ArtistWorkEmail="rotokyo@icloud.com" \
    -CopyrightsOwner="© 2013 Roberto Calesini aka roTokyo" \
    -UsageTermsStatement="For evaluation only, no reproduction is permitted without written permission by copyrights owner." \
    -CopyrightFlag=true \
    ${ORIGINIMGPATH}/${REPLY}

  exiftool -a -G1 -s -H ${ORIGINIMGPATH}/${REPLY}

else
  echo ''
  echo 'Something went wrong ... retry!'
fi


