#! /bin/bash

FFMPEG="/usr/bin/ffmpeg"

echo "Screen Size :"
read INRES
echo "Framerate :"
read FPS
echo "Output Size :"
read OUTRES

QUAL=ultrafast

$FFMPEG -f x11grab -s $INRES -r $FPS -i :0.0 \
-f alsa -i pulse -vcodec libx264 \
-s $OUTRES -acodec libmp3lame -ac 2 \
-ab 128k -ar 44100 \
-f flv rtmp://live.twitch.tv/app/your_twitch_stream_key
