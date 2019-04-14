#!/bin/bash
set -eo pipefail

#
# This script fixes resizes and re-orients the full images for a year's gallery photos.
# Run it like this:
#
#     cd /path/to/brickhack.io/public/gallery/photos/
#     bash fix_full.sh
#
#For Windows users, open docker and run:
#     docker-compose run web bash
#     cd public/gallery/photos
#     ./fix_full.sh 

# UPDATE THIS FOR THE SPECIFIC YEAR TO GENERATE
YEAR_FOLDER=2019

# Nothing below this line should need to be modified
FULL_FOLDER="${YEAR_FOLDER}/full"

for file in ${FULL_FOLDER}/*
do
  # next line checks the mime-type of the file
  CHECKTYPE=`file --mime-type -b "$file" | awk -F'/' '{print $1}'`
  if [ "x$CHECKTYPE" == "ximage" ]; then

    CHECKWIDTH=`identify -format "%W" "$file"`     # this returns the image width
    CHECKHEIGHT=`identify -format "%H" "$file"`

    if [ $CHECKWIDTH -gt $CHECKHEIGHT ]; then
       convert -resize 1024x683 "$file" -auto-orient "${FULL_FOLDER}/$(basename "$file")"
    else
       convert -resize 637x960 "$file" -auto-orient "${FULL_FOLDER}/$(basename "$file")"
    fi
  fi
done
