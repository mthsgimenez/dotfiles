#!/usr/bin/env bash

source $HOME/.cache/wal/colors.sh

echo '{"version": 1, "click_events": true}'
echo "["

PLAYER="firefox"

(while :;
do
   if music=$(playerctl -s -p $PLAYER metadata -f "{{trunc(artist, 20)}} - {{trunc(title, 30)}}"); then
      if [[ $(playerctl -s -p $PLAYER status) == "Paused" ]]; then
         music="*Paused*"
      fi
   else
      music="No players found"
   fi
   date=$(date "+%a %d/%m/%Y")
   time=$(date "+%H:%M")
   sound=$(amixer sget Master | awk -F'[][]' '/Mono:/ { print $2 }')
   if [[ $(amixer sget Master | awk -F'[][]' '/Mono:/ { print $6 }') == "off" ]]; then
      sound="Muted"
   fi
   echo '[{"name": "music", "background": "'$background'", "full_text": " 󰝚 '$music' ", "color": "'$color4'"}, {"background": "'$background'", "full_text": "  '$date' ", "color": "'$color3'"}, {"background": "'$background'", "full_text": " 󰥔 '$time' ", "color": "'$color2'"}, {"background": "'$background'", "name": "sound", "full_text": " 󰕾 '$sound' ", "color": "'$color1'"}],'
   sleep 0.3
done) &

while read line;
do
   # echo $line > $HOME/temp/temp.txt
   if [[ $line == *"name"*"music"* ]]; then
      playerctl -p $PLAYER play-pause
   elif [[ $line == *"name"*"sound"* ]]; then
      if [[ $line == *"button\": 4"* ]]; then # Scroll up
         amixer sset Master 2%+ >/dev/null
      elif [[ $line == *"button\": 5"* ]]; then # Scroll down
         amixer sset Master 2%- >/dev/null
      else
         amixer sset Master toggle >/dev/null
      fi
   fi
done
