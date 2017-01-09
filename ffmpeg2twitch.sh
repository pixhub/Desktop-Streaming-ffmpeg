#! /bin/bash

usage() { echo "Usage: $0 [-s <screen resolution>] [-r <FPS> ] [-o <output resolution> ]" 1>&2; exit 1; }

while getopts ":s:r:o:" o; do
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
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "$RES" ] || [ -z "$OUTRES" ]; 
  then usage
fi

if [ -z "$FPS" ];
  then FPS=30

QUAL=ultrafast

echo "Chosen input resolution : $INRES"
echo "Chosen output resolution : $OUTRES"
echo "Chosen frame rate : $FPS fps"

FFMPEG=/usr/bin/ffmpeg

$FFMPEG -f x11grab -s $INRES -r $FPS -i :0.0 \
-f alsa -i pulse -vcodec libx264 \
-s $OUTRES -acodec libmp3lame -ac 2 \
-ar 44100 \
-f flv rtmp://live.twitch.tv/app/your_twitch_stream_key
