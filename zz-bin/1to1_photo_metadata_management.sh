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
  ORIGINIMGPATH=$(pwd)

  echo ${IMGFILENAME}
  echo ${EXTENTION}
  echo ${FILENAME}
  echo ${FILEPATH}


if [[ "${IMGFILENAME}" != "" && -f "${ORIGINIMGPATH}/${READIMGFILENAME}" ]]; then

  if [[ "${FILEPATH}" == "." ]]; then
    ORIGINIMGPATH=$(pwd)
    echo "Si:  " ${ORIGINIMGPATH}
    else
      ORIGINIMGPATH="${ORIGINIMGPATH}/${FILEPATH}"
      echo "No:  " ${ORIGINIMGPATH}
  fi

  # erase all image metadata
  # -ProfileDescription="sRGB IEC61966-2.1"

  read -p 'Cancello i metadati? [y] ... :' READREPLY
  echo ''  

  if [[ "${READREPLY}" == y ]]; then
    exiftool \
      -All= --ICC_Profile:All \
      -TagsFromFile ${ORIGINIMGPATH}/${IMGFILENAME} \
      -PhotoTitle -Title \
      -ProfileDescription \
      -Make -Model \
      -ExposureTime \
      -FNumber \
      -ISO \
      -FocalLength \
      -LensModel \
      -LensID \
      ${ORIGINIMGPATH}/${IMGFILENAME}

    # exiftool '-LensModel+<LensID' ${ORIGINIMGPATH}/${IMGFILENAME}

  fi

# write copyrights data
# Modifiche:
# -LensModel="Fujifilm XF 18-55mm F2.8-4 R LM OIS" \
# -LensModel="Sigma 30mm F1.4 DC HSM Art" \
# -LensModel="Sigma 105mm F2.8 DG Macro HSM" \
# -LensModel="Nikon AF Zoom-Nikkor 70-300mm f/4-5.6D ED"

  read -p 'Insert photo title (*): ...' IMGTITLE
  echo ''

  exiftool \
    -Title="${IMGTITLE}" \
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
    ${ORIGINIMGPATH}/${IMGFILENAME}
  
  
  exiftool -a -G1 -s -H -sort ${ORIGINIMGPATH}/${IMGFILENAME}

else
  echo ''
  echo 'File not found ... retry!'
fi

unset READIMGFILENAME IMGFILENAME EXTENTION FILENAME FILEPATH ORIGINIMGPATH IMGTITLE READREPLY CAMERA LESNMODEL
