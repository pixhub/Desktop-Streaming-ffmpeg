#! /bin/bash

FFMPEG ="/usr/bin/ffmpeg"

echo "Desktop Size :"
read INRES

echo "Framerate :"
read FPS

echo "File name :"
read FILE

$FFMPEG -f x11grab -s $INRES -r $FPS -i :0.0 \
-f alsa -i pulse -vcodec libx264 \
~/Videos/$FILE.mpg
