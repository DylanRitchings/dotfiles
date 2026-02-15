#!/bin/bash
# Update icons for the space where a window change occurred
if [ "$SENDER" = "space_windows_change" ] || [ "$SENDER" = "front_app_switched" ]; then
  # Get the currently focused app
  focused_app=$(aerospace list-windows --focused --format "%{app-name}" 2>/dev/null | head -1)
  
  # Update all spaces to refresh their window icons
  for space_num in {1..9}; do
    # Get all windows in this workspace
    apps=$(aerospace list-windows --workspace "$space_num" --format "%{app-name}" 2>/dev/null | sort -u)
    
    icon_strip=""
    if [ -n "$apps" ]; then
      while IFS= read -r app; do
        if [ -n "$app" ]; then
          icon=$(~/.config/sketchybar/plugins/icon_map.sh "$app")
          icon_strip+=" ${icon}"
        fi
      done <<< "$apps"
    fi

    # Determine if this space has the focused app
    space_has_focus=false
    if echo "$apps" | grep -q "^${focused_app}$"; then
      space_has_focus=true
    fi

    if [ -z "$icon_strip" ]; then
      sketchybar --set space.$space_num label="" label.padding_right=0 label.highlight=off
    else
      if [ "$space_has_focus" = true ]; then
        # Space contains focused app - use highlight color for all icons in this space
        sketchybar --set space.$space_num label="$icon_strip" label.padding_right=8 label.highlight=on
      else
        # No focus - use normal color
        sketchybar --set space.$space_num label="$icon_strip" label.padding_right=8 label.highlight=off
      fi
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
