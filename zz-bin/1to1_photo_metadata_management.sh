#!/usr/bin/env bash

# **********************************
# *                                *
# *  erase and write image copy    *
# *                                *
#***********************************
#

ORIGINIMGPATH=$(pwd)

read -p 'Insert file name ... :' READIMGFILENAME
echo ''


  IMGFILENAME=$(basename -- "$READIMGFILENAME")
  EXTENTION="${READIMGFILENAME##*.}"
  FILENAME="${READIMGFILENAME%.*}"
  FILEPATH=$(dirname "$READIMGFILENAME")

if [[ "${IMGFILENAME}" != "" && -f "${ORIGINIMGPATH}/${READIMGFILENAME}" ]]; then

  if [[ "${FILEPATH}" == "" ]]; then
    ORIGINIMGPATH=$ORIGINIMGPATH
    else
      ORIGINIMGPATH="${ORIGINIMGPATH}/${FILEPATH}"
  fi

  read -p 'Insert photo title (*): ...' IMGTITLE
  echo ''

  # erase all image metadata
  # -ProfileDescription="sRGB IEC61966-2.1"

  read -p 'Cancello i metadati? [y] ... :' READREPLY
  echo ''  

  if [[ "${READREPLY}" == y ]]; then
    exiftool \
      -All= --ICC_Profile:All \
      -TagsFromFile ${ORIGINIMGPATH}/${IMGFILENAME} \
      -PhotoTitle \
      -ProfileDescription \
      -Make -Model \
      -ExposureTime \
      -FNumber \
      -ISO \
      -FocalLength \
      -LensModel \
      ${ORIGINIMGPATH}/${IMGFILENAME}
  fi

# write copyrights data
# Modifiche:
# -LensModel="Fujifilm XF 18-55mm F2.8-4 R LM OIS" \
# -LensModel="Sigma 30mm F1.4 DC HSM Art" \
# -LensModel="Nikon 105mm F2.8D Micro Nikkor" \
# -LensModel="Sigma 105mm F2.8 DG Macro HSM" \

# -CreatorWorkEmail="roberto.calesini@gmail.com" \
# -CreatorWorkURL="" \

  exiftool \
    -PhotoTitle="${IMGTITLE}" \
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
    ${ORIGINIMGPATH}/${IMGFILENAME}

  exiftool -a -G1 -s -H ${ORIGINIMGPATH}/${IMGFILENAME}

else
  echo ''
  echo 'Something went wrong ... retry!'
fi


