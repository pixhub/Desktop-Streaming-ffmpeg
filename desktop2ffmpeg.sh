#!/bin/bash

usage() { echo "Usage: $0 [-s <screen resolution>] [-r <FPS> ] [-o <path and file name to save> ] [-h <help> ]" 1>&2; exit 1; }

while getopts ":s:r:o:h" o; do
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
	h)  
	    echo ""
	    echo "Welcome on the desktop2ffmpeg helper"
	    echo ""
	    echo "Options :"
	    echo ""
	    echo "-s is your screen size, you must inquire this option with the correct size of your screen (ex : 1920x1080)"
	    echo ""
	    echo "-r is the frame rate. (Default framerate = 30)"
	    echo ""
	    echo "-o is the file saving path. (Default = ~/video1.mpg)"
	    echo ""
	    echo "For -o do not inquire the file extension. It is already inquired as .mpg"
	    echo ""
	    ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "$RES" ]; 
  then usage
fi

if [ -z "$FPS" ];
  then FPS=30
fi

if [ -z "$FILE" ];
  then  FILE=~/video1 
fi

echo "Screen resolution = $RES"
echo "Frame rate = $FPS fps"
echo "Saved file path = $FILE.mpg"

FFMPEG=/usr/bin/ffmpeg

$FFMPEG -f x11grab -s $RES -r $FPS -i :0.0 \
-f alsa -i pulse -vcodec libx264 \
$FILE.mpg
