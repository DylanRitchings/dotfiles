#!/bin/bash

: ${SENDER:=space_change}

AEROSPACE="/opt/homebrew/bin/aerospace"
SKETCHYBAR="/run/current-system/sw/bin/sketchybar"

source ~/.config/sketchybar/plugins/icon_map.sh > /dev/null 2>&1 || true

all_windows=$("$AEROSPACE" list-windows --all --format "%{workspace}	%{app-name}" 2>/dev/null)

current_space="${AEROSPACE_FOCUSED_WORKSPACE:-$("$AEROSPACE" list-workspaces --focused 2>/dev/null)}"

sketchybar_args=()
for s in {1..9}; do
  icon_strip=""
  while IFS=$'\t' read -r ws app; do
    [[ "$ws" != "$s" || -z "$app" ]] && continue
    __icon_map "$app"
    icon_strip+=" $icon_result"
  done <<< "$all_windows"

  if [ -z "$icon_strip" ]; then
    set_args=(--set "space.$s" label="" label.padding_right=0)
  else
    set_args=(--set "space.$s" label="$icon_strip" label.padding_right=8)
  fi

  if [ "$s" = "$current_space" ]; then
    set_args+=(background.color=0xFF666666)
  else
    set_args+=(background.color=0xFF333333)
  fi

  sketchybar_args+=("${set_args[@]}")
done

"$SKETCHYBAR" "${sketchybar_args[@]}"
