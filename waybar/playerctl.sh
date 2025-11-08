#!/bin/bash

PREV_OUTPUT=""

while true; do
        if MUSIC=$(playerctl -s -p $MUSIC_PLAYER metadata -f "{{trunc(artist, 20)}} - {{trunc(title, 30)}}"); then
                if [[ $(playerctl -s -p $MUSIC_PLAYER status) == "Paused" ]]; then
                        MUSIC="*Paused*"
                elif [[ "$MUSIC" == *"&"* ]]; then
                        MUSIC="${MUSIC//&/&amp;}"
                fi
        else
                MUSIC="No music playing"
        fi

        if [ "$PREV_OUTPUT" != "$MUSIC" ]; then
                echo $MUSIC
                PREV_OUTPUT="$MUSIC"
        fi

        sleep 1
done
