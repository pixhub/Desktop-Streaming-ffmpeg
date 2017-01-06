#!/bin/bash

usage() { echo "Usage: $0 [-s <screen resolution>] [-r <FPS> ] [-out <path and file name to save> ]" 1>&2; exit 1; }

while getopts ":s:r:" o; do
    case "${o}" in
        s)
            RES=${OPTARG}
            ;;
	r)
	    FPS=${OPTARG}
	    ;;
	out)
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

echo "la resolution choisie est $RES"

FFMPEG=/usr/bin/ffmpeg

ffmpeg -f x11grab -s $RES -r $FPS -i :0.0 \
-f alsa -i pulse -vcodec libx264 \
$FILE.mpg
