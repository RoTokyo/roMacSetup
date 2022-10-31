#!/usr/bin/env bash

# **********************************
# *                                *
# *  erase and write image copy    *
# *                                *
#***********************************
#

read -p 'Insert file ext ... :' FILEEXT
echo ''

for file in *.${FILEEXT}; do
  if [[ -f ${file} ]]; then

    # erase all image metadata
    # -ProfileDescription="sRGB IEC61966-2.1"

    exiftool \
      -All= --ICC_Profile:All \
      -TagsFromFile ${file} \
      -PhotoTitle -Title \
      -Make -Model \
      -ExposureTime \
      -FNumber \
      -ISO \
      -FocalLength \
      -LensModel \
      -LensID \
      ${file}

    exiftool \
      -Artist="roTokyo" \
      -ArtistCity="Tokyo" \
      -ArtistCountry="Japan" \
      -ArtistWorkURL="https://www.flickr.com/photos/rotokyo/albums" \
      -ArtistWorkEmail="rotokyo@icloud.com" \
      -UsageTerms="For evaluation only, do not reproduce, distribute, use, and or adapt any part of this work without written permission by the copyright owner." \
      -Creator="Roberto Calesini aka roTokyo" \
      -Rights="© 2013 Roberto Calesini aka roTokyo. All rights reserved." \
      -CopyrightsOwner="© 2013 Roberto Calesini aka roTokyo. All rights reserved." \
      -CopyrightFlag=true \
      ${file}

    echo ${file} " updated"

  else
    echo ''
    echo '  No *.Files found!'
    echo ''
    read -p "Press any button to continue ... :"
  fi

done
