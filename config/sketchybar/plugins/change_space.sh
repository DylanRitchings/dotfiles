#!/bin/bash

# Check if a number key was provided as an argument
if [[ -z $1 ]] || ! [[ $1 =~ ^[0-9]$ ]]; then
  echo "Usage: $0 [number key (0-9)]"
  exit 1
fi

# Convert the input number to its corresponding key code
case $1 in
  0) keycode=29 ;; # Key code for 0
  1) keycode=18 ;; # Key code for 1
  2) keycode=19 ;; # Key code for 2
  3) keycode=20 ;; # Key code for 3
  4) keycode=21 ;; # Key code for 4
  5) keycode=23 ;; # Key code for 5
  6) keycode=22 ;; # Key code for 6
  7) keycode=26 ;; # Key code for 7
  8) keycode=28 ;; # Key code for 8
  9) keycode=25 ;; # Key code for 9
esac

# Use osascript to simulate the key press
osascript <<EOF
tell application "System Events"
    key down option
    key down shift
    key down control
    key code $keycode
    key up control
    key up shift
    key up option
end tell
EOF
