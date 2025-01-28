#!/bin/bash
if [ "$SENDER" = "space_windows_change" ]; then
  space="$(echo "$INFO" | jq -r '.space')"
  apps="$(echo "$INFO" | jq -r '.apps | keys[]')"
  icon_strip=""

  # current_focused_app=$(yabai -m query --windows --window | jq -r '.app')  

  if [ "${apps}" != "" ]; then
    while read -r app
    do
      icon_strip+=" $(./plugins/icon_map.sh "$app")"
      
    done <<< "${apps}"
  else
    icon_strip=""
  fi

  if [ -z "$icon_strip" ]; then
    sketchybar --set space.$space label="$icon_strip" label.padding_right=0 
  else
    sketchybar --set space.$space label="$icon_strip" label.padding_right=8 

  fi

fi

if [ "$SENDER" = "space_change" ]; then

  # current_space=$(yabai -m query --spaces --space | jq -r '.index')
  space="$(echo "$INFO" | jq -r '."display-1"')"
  sketchybar --set space.$space background.color=0xFF666666 

  all_spaces=$(yabai -m query --spaces | jq -r '.[].index')
  for s in $all_spaces; do
    if [ "$s" -ne "$space" ]; then
      sketchybar --set space.$s background.color=0xFF333333  
    fi
  done
fi
