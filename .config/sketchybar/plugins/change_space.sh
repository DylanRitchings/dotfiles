#!/bin/bash

# Use full path to aerospace since scripts may not have Homebrew in PATH
AEROSPACE="/opt/homebrew/bin/aerospace"

# Check if a workspace number was provided as an argument
if [[ -z $1 ]] || ! [[ $1 =~ ^[0-9]$ ]]; then
  echo "Usage: $0 [workspace number (1-9)]"
  exit 1
fi

# Use aerospace to switch to the workspace
"$AEROSPACE" workspace "$1"
