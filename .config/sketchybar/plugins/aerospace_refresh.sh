#!/bin/bash
# Trigger sketchybar to update space icons and highlighting
# This script should be called by aerospace on window/workspace changes

# Trigger window change update for all spaces
sketchybar --trigger space_windows_change

# Trigger space change to update highlighting
sketchybar --trigger space_change
