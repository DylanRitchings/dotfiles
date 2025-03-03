#!/bin/bash

# Get the space number passed to the script
input_number=$1

# Get the currently focused display
focused_display=$(yabai -m query --displays | jq '.[] | select(.focused == true).index')

# TODO change to switch case
if [ "$focused_display" -eq 1 ]; then
    space_number=$input_number
elif [ "$focused_display" -eq 2 ]; then
    space_number=$((input_number + 9))
elif [ "$focused_display" -eq 3 ]; then
    space_number=$((input_number + 18))
else
    echo "No valid focused display found."
fi


yabai -m window --space $space_number
