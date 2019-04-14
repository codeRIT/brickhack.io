#!/bin/bash
set -eo pipefail

#
# This script generates thumbnails for a year's gallery photos.
# Run it like this:
#
#     cd /path/to/brickhack.io/public/gallery/photos/
#     bash create_thumbs.sh
#
#For Windows users, open docker and run:
#     docker-compose run web bash
#     cd public/gallery/photos
#     ./create_thumbs.sh 

# UPDATE THIS FOR THE SPECIFIC YEAR TO GENERATE
YEAR_FOLDER=2019

# Nothing below this line should need to be modified
FULL_FOLDER="${YEAR_FOLDER}/full"
THUMBS_FOLDER="${YEAR_FOLDER}/thumb"
mkdir -p $THUMBS_FOLDER
for file in ${FULL_FOLDER}/*
do
  # next line checks the mime-type of the file
  CHECKTYPE=`file --mime-type -b "$file" | awk -F'/' '{print $1}'`
  if [ "x$CHECKTYPE" == "ximage" ]; then
    #CHECKSIZE=`stat -f "%z" "$file"`               # this returns the filesize
    CHECKWIDTH=`identify -format "%W" "$file"`     # this returns the image width
    CHECKHEIGHT=`identify -format "%H" "$file"`     # this returns the image width

    # next 'if' is true if either filesize >= 200000 bytes  OR  if image width >=201
    #if [ $CHECKSIZE -ge  200000 ] || [ $CHECKWIDTH -ge 401 ]; then
    if [ $CHECKWIDTH -gt $CHECKHEIGHT ]; then
       convert -resize 400x300 "$file" "${THUMBS_FOLDER}/$(basename "$file")"
    else
       convert -resize 400x603 "$file" "${THUMBS_FOLDER}/$(basename "$file")"
    fi
  fi
done
