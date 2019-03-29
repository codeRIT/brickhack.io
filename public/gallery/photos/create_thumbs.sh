#!/bin/bash
THUMBS_FOLDER=2018/thumb/*
for file in 2018/full/*
do
  # next line checks the mime-type of the file
  CHECKTYPE=`file --mime-type -b "$file" | awk -F'/' '{print $1}'`
  if [ "x$CHECKTYPE" == "ximage" ]; then
    CHECKSIZE=`stat -f "%z" "$file"`               # this returns the filesize
    CHECKWIDTH=`identify -format "%W" "$file"`     # this returns the image width

    # next 'if' is true if either filesize >= 200000 bytes  OR  if image width >=201
    if [ $CHECKSIZE -ge  200000 ] || [ $CHECKWIDTH -ge 401 ]; then
       convert -sample 400x300 "$file" "$(dirname "${THUMBS_FOLDER}")/$(basename "$file")"
    fi
  fi
done
