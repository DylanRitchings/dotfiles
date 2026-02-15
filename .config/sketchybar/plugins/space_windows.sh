#!/bin/bash
# Update icons for the space where a window change occurred
if [ "$SENDER" = "space_windows_change" ]; then
  # Update all spaces to refresh their window icons
  for space_num in {1..9}; do
    # Get all windows in this workspace
    apps=$(aerospace list-windows --workspace "$space_num" --format "%{app-name}" 2>/dev/null | sort -u)
    
    icon_strip=""
    if [ -n "$apps" ]; then
      while IFS= read -r app; do
        if [ -n "$app" ]; then
          icon_strip+=" $(~/.config/sketchybar/plugins/icon_map.sh "$app")"
        fi
      done <<< "$apps"
    fi

    if [ -z "$icon_strip" ]; then
      sketchybar --set space.$space_num label="" label.padding_right=0 
    else
      sketchybar --set space.$space_num label="$icon_strip" label.padding_right=8 
    fi
  done
fi

# Highlight the currently focused space
if [ "$SENDER" = "space_change" ] || [ "$SENDER" = "front_app_switched" ]; then
  # Get current focused workspace
  current_space=$(aerospace list-workspaces --focused 2>/dev/null)
  
  if [ -n "$current_space" ]; then
    # Highlight current space
    sketchybar --set space.$current_space background.color=0xFF666666 

    # Dim all other spaces
    for s in {1..9}; do
      if [ "$s" != "$current_space" ]; then
        sketchybar --set space.$s background.color=0xFF333333  
      fi
    done
  fi
fi
