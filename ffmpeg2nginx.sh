#! /bin/bash

FFMPEG="/usr/bin/ffmpeg"

$FFMPEG -f x11grab -s 1920x1080 -r 30 -i :0.0 \
-f alsa -ac 2 -i pulse -vcodec libx264 \
-s 1280x720 -acodec libmp3lame \
-ab 128k -ar 44100 -threads 0 \
-f flv "rtmp://IP_nginx_server/live"
