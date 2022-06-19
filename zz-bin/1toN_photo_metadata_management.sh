#!/usr/bin/env bash

# **********************************
# *                                *
# *  erase and write image copy    *
# *                                *
#***********************************
#


_main_code () {

	while [[ $REPLY != 'x' ]]; do
		clear && echo ''
  	cat <<_EOF_
  erase and write image copyrights:

    1. do one file

    2. do a bunch of files

    x. eXit

_EOF_

  read -p "Enter selection [eXit or 1] > "
  if [[ $REPLY =~ ^[1-2]$ || $REPLY =~ ^[?]$  || $REPLY =~ ^[x]$ ]]; then

  	if [[ $REPLY == 'x' ]]; then
  		echo ''
      echo '  eXit Convert Routine! By by ...'
      echo ''
  	fi


    if [[ $REPLY == 1 ]]; then

      ORIGINIMGPATH="${HOME}/Desktop/a"
      DESTINIMGPATH="${HOME}/Desktop/b"

      read -p 'Insert file name ... :'
      echo ''

      if [[ "${REPLY}" != "" && -f "${ORIGINIMGPATH}/${REPLY}" ]]; then

        read -p 'Insert photo title (*): ...' TITLE
        echo

        # erase all image metadata
        #mogrify \
        #  -strip \
         # ${ORIGINIMGPATH}/${REPLY}
        exiftool -All:All= \
          -TagsFromFile ${ORIGINIMGPATH}/${REPLY} \
          -Make -Model \
          -ExposureTime \
          -FNumber \
          -ISO \
          -FocalLength \
          -LensModel \
          ${ORIGINIMGPATH}/${REPLY}

        read -p "${REPLY} Metadata erased ... : press any key to continue!"

        # write copyrights data
        # Modifiche:
        # -LensModel="Fujifilm XF 18-55mm F2.8-4 R LM OIS" \
        # -LensModel="Sigma 30mm F1.4 DC HSM Art" \
        # -LensModel="Nikon 105mm F2.8D Micro Nikkor" \
        # -LensModel="Sigma 105mm F2.8 DG Macro HSM" \

         exiftool \
          -PhotoTitle=${TITLE} \
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
        read -p "${REPLY} New metadata saved ... : press any key to continue!"

			else
		    	echo ''
		      echo '  Invalid entry! Wait ...'
		      echo ''
		      sleep 1

      fi
  	fi

  	if [[ $REPLY == 2 ]]; then
  	  ORIGINIMGPATH="${HOME}/Desktop/a"

  	  for file in $ORIGINIMGPATH/*.jpg; do
  	    if [[ -f ${file} ]]; then
 
        read -p 'Insert photo title (*): ...' TITLE
        echo

          exiftool -All:All= \
            -TagsFromFile ${file} \
            -Make -Model \
            -ExposureTime \
            -FNumber \
            -ISO \
            -FocalLength \
            -LensModel \
            ${file}

          # -LensModel="Fujifilm XF 18-55mm F2.8-4 R LM OIS" \
          # -LensModel="Sigma 30mm F1.4 DC HSM Art" \
          # -LensModel="Nikon 105mm F2.8D Micro Nikkor" \
          # -LensModel="Sigma 105mm F2.8 DG Macro HSM" \
          exiftool \
            -PhotoTitle=${TITLE} \
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
            ${file}
          echo "File: ${file} modified! ... "

        else
		    	echo ''
		      echo '  No *.jpg files found!'
		      echo ''
          read -p "Press any button to continue ... :"
	      fi
      done

  	fi
  fi
	done
  unset DESTINIMGPATH ORIGINIMGPATH REPLY
}

_main_code
