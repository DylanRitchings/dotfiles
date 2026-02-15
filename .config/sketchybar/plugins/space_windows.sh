#!/bin/bash
if [ "$SENDER" = "space_windows_change" ]; then
  # Get current workspace from aerospace
  current_space=$(aerospace list-workspaces --focused)
  
  # Get all windows in the current workspace
  apps=$(aerospace list-windows --workspace "$current_space" --format "%{app-name}" | sort -u)
  
  icon_strip=""
  if [ -n "$apps" ]; then
    while IFS= read -r app; do
      if [ -n "$app" ]; then
        icon_strip+=" $(~/.config/sketchybar/plugins/icon_map.sh "$app")"
      fi
    done <<< "$apps"
  fi

  if [ -z "$icon_strip" ]; then
    sketchybar --set space.$current_space label="$icon_strip" label.padding_right=0 
  else
    sketchybar --set space.$current_space label="$icon_strip" label.padding_right=8 
  fi
fi

if [ "$SENDER" = "space_change" ]; then
  # Get current focused workspace
  current_space=$(aerospace list-workspaces --focused)
  
  # Highlight current space
  sketchybar --set space.$current_space background.color=0xFF666666 

  # Dim all other spaces
  for s in {1..9}; do
    if [ "$s" -ne "$current_space" ]; then
      sketchybar --set space.$s background.color=0xFF333333  
    fi
  done
fi
