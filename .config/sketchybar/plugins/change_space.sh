#!/bin/bash

# Check if a workspace number was provided as an argument
if [[ -z $1 ]] || ! [[ $1 =~ ^[0-9]$ ]]; then
  echo "Usage: $0 [workspace number (1-9)]"
  exit 1
fi

# Use aerospace to switch to the workspace
aerospace workspace "$1"
