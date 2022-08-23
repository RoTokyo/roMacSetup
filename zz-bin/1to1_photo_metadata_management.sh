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
      -PhotoTitle \
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

# -CreatorWorkEmail="roberto.calesini@gmail.com" \
# -CreatorWorkURL="" \

  CAMERA=$(exiftool -Make ${ORIGINIMGPATH}/${IMGFILENAME})

  if [[  "${CAMERA}" =~ .*"SIGMA".* ]]; then
    echo "1): Sigma 30mm F1.4 DC HSM Art"
    echo "2): Sigma 105mm F2.8 DG Macro HSM"
    echo ""
    echo -n "Which lens model? [ 1 or 2]: "
    read READREPLY
    case $READREPLY in
      [1] ) LENSMODEL="Sigma 30mm F1.4 DC HSM Art"
        ;;
      [2] ) LENSMODEL="Sigma 105mm F2.8 DG Macro HSM"
        ;;
      *) echo "Invalid input"
        exit 0
        ;;
    esac
    exiftool -LensModel="${LENSMODEL}" ${ORIGINIMGPATH}/${IMGFILENAME}
  fi

  read -p 'Insert photo title (*): ...' IMGTITLE
  echo ''

  exiftool \
    -PhotoTitle="${IMGTITLE}" \
    -Creator="Roberto Calesini" \
    -Rights="© 2013 Roberto Calesini aka roTokyo. All rights reserved." \
  	-Artist="roTokyo" \
  	-ArtistCity="Tokyo" \
  	-ArtistCountry="Japan" \
    -ArtistWorkURL="https://www.flickr.com/photos/rotokyo/albums" \
    -ArtistWorkEmail="rotokyo@icloud.com" \
    -CopyrightsOwner="© 2013 Roberto Calesini aka roTokyo. All rights reserved." \
    -UsageTermsStatement="For evaluation only, no reproduction is permitted without written permission by copyrights owner." \
    -CopyrightFlag=true \
    ${ORIGINIMGPATH}/${IMGFILENAME}
  
  

  exiftool -a -G1 -s -H -sort ${ORIGINIMGPATH}/${IMGFILENAME}

else
  echo ''
  echo 'File not found ... retry!'
fi

unset READIMGFILENAME IMGFILENAME EXTENTION FILENAME FILEPATH ORIGINIMGPATH IMGTITLE READREPLY CAMERA LESNMODEL
