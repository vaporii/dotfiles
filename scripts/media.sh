#!/bin/bash

truncate_with_dots() {
    local str=$1
    local len=$2
    if [ ${#str} -gt $len ]; then
        echo "${str:0:$((len - 3))}..."
    else
        echo "$str"
    fi
}

metadata=$(playerctl metadata 2>/dev/null)

title=$(echo "$metadata" | grep -m 1 'xesam:title' | awk -F '  +' '{print $2}' | sed 's/^ *//; s/ *$//')
album=$(echo "$metadata" | grep -m 1 'xesam:album' | awk -F '  +' '{print $2}' | sed 's/^ *//; s/ *$//')
artist=$(echo "$metadata" | grep -m 1 'xesam:artist' | awk -F '  +' '{print $2}' | sed 's/^ *//; s/ *$//')

status=$(playerctl status 2>/dev/null)

if [ "$status" = "Playing" ]; then
    icon=""
else
    if [ "$status" = "Paused" ]; then
        icon=""
    else
        icon=""
    fi
fi

if [ -z "$title" ] && [ -z "$album" ] && [ -z "$artist" ]; then
    echo "$icon No media"
else
    if [ -z "$album" ]; then
        if [ -z "$artist" ]; then
            echo "$icon $(truncate_with_dots "$title" 20)"
        else
            echo "$icon $(truncate_with_dots "$title" 20) - $(truncate_with_dots "$artist" 20)"
        fi
    else
        if [ -z "$artist" ]; then
            echo "$icon $(truncate_with_dots "$title" 20) | $(truncate_with_dots "$album" 20)"
        else
            echo "$icon $(truncate_with_dots "$title" 20) | $(truncate_with_dots "$album" 20) - $(truncate_with_dots "$artist" 20)"
        fi
    fi
fi
