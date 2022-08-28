	  #!/usr/bin/env bash

# **********************************
# *                                *
# *  erase and write image copy    *
# *                                *
#***********************************
#

ORIGINIMGPATH="/Volumes/Discoimmagini/ZZ-images/WS-ilpoli"

for file in $ORIGINIMGPATH/*.jpg; do
  if [[ -f ${file} ]]; then

    # erase all image metadata
    # -ProfileDescription="sRGB IEC61966-2.1"


    # write copyrights data
    # 
    # -LensModel="Fujifilm XF 18-55mm F2.8-4 R LM OIS" \
    # -LensModel="Sigma 30mm F1.4 DC HSM Art" \
    # -LensModel="Nikon 105mm F2.8D Micro Nikkor" \
    # -LensModel="Sigma 105mm F2.8 DG Macro HSM" \

    #
    # write title
    read -p 'Insert photo title (*): ...' IMGTITLE
    echo ''
    #
    # write metadata
    exiftool \
      -PhotoTitle="${IMGTITLE}" \
      -ArtistName="Roberto Calesini aka roTokyo" \
      -ArtistCity="Tokyo" \
      -ArtistCountry="Japan" \
      -ArtistWorkURL="https://www.flickr.com/photos/rotokyo/albums" \
      -ArtistWorkEmail="rotokyo@icloud.com" \
      -Artist="roTokyo" \
      -Creator="Roberto Calesini aka roTokyo" \
      -Rights="© 2013 Roberto Calesini aka roTokyo. All rights reserved." \
      -CopyrightsOwner="© 2013 Roberto Calesini aka roTokyo. All rights reserved." \
      -CopyrightFlag=true \
      ${file}
    echo "File: ${file} modified! ... "
  

  else
    echo ''
    echo '  No *.Files found!'
    echo ''
    read -p "Press any button to continue ... :"
  fi
done
