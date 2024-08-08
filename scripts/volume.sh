#!/bin/bash

volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '\d+(?=%)' | head -n 1)

# Determine icon based on volume range
if [ $volume -eq 0 ]; then
    icon=""
elif [ $volume -ge 1 ] && [ $volume -le 25 ]; then
    icon=""
elif [ $volume -ge 26 ] && [ $volume -le 75 ]; then
    icon=""
elif [ $volume -ge 76 ] && [ $volume -le 100 ]; then
    icon=""
else
    echo "Invalid volume level: $volume"
    exit 1
fi

if pactl list sinks | grep -q "Mute: yes"; then
    icon=""
fi

dunstify -h string:x-canonical-private-synchronous:audio "$icon  Volume: " -h int:value:$volume -t 1500
