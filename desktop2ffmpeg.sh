#!/bin/bash

usage() { echo "Usage: $0 [-s <screen resolution>] [-r <FPS> ] [-o <path and file name to save> ]" 1>&2; exit 1; }

while getopts ":s:r:o:" o; do
    case "${o}" in
        s)
            RES=${OPTARG}
            ;;
	r)
	    FPS=${OPTARG}
	    ;;
	o)
	    FILE=${OPTARG}
	    ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "$RES" ] || [ -z "$FPS" ]; 
  then usage
fi
if [ -z "$FILE" ]; 
  then FILE=~/video1
fi

echo "Chosen resolution : $RES"
echo "Chosen frame rate : $FPS"
echo "Save file path : $FILE"

FFMPEG=/usr/bin/ffmpeg

$FFMPEG -f x11grab -s $RES -r $FPS -i :0.0 \
-f alsa -i pulse -vcodec libx264 \
$FILE.mpg
