#!/bin/bash

usage() { echo "Usage: $0 [ -s <screen resolution> ] [ -r <FPS> ] [ -o <output resolution> ] [ -i <IP where to stream> ] [-h <help> ]" 1>&2; exit 1; }

while getopts ":s:r:o:i:h" o; do
    case "${o}" in
        s)
            INRES=${OPTARG}
            ;;
	r)
	    FPS=${OPTARG}
	    ;;
	o)
	    OUTRES=${OPTARG}
	    ;;
	i)
	    IP=${OPTARG}
	    ;;
	h)  
	    echo ""
	    echo "Welcome on the desktop2ffmpeg helper"
	    echo ""
	    echo "Options :"
	    echo ""
	    echo "-s is your screen size, you must inquire this option with your actual screen size (ex : 1920x1080)"
	    echo ""
	    echo "-r is the frame rate. (Default framerate = 30)"
	    echo ""
	    echo "-o is the stream resolution (output resolution)"
	    echo ""
	    echo "-i is the server IP"
	    echo ""
	    ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "$INRES" ] || [ -z "$OUTRES" ] || [ -z "$IP" ]; 
  then usage
fi

if [ -z "$FPS" ];
  then FPS=30
fi

echo "Screen resolution = $RES"
echo "Frame rate = $FPS fps"
echo "Stream resolution = $OUTRES.mpg"
echo "Streaming path = rtmp://$IP:1935/live"

FFMPEG="/usr/bin/ffmpeg"

QUAL=ultrafast

$FFMPEG -f x11grab -s $INRES -r $FPS -i :0.0 \
-f alsa -ac 2 -i pulse -vcodec libx264 \
-s $OUTRES -strict -2 -acodec aac \
-ab 128k -ar 44100 -threads 0 \
-f flv "rtmp://$IP:1935/live"
