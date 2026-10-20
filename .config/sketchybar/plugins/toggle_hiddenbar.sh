#!/bin/bash
# Click Ice's menu bar item to show the hidden icons panel
osascript -e '
tell application "System Events"
  tell process "Ice"
    click menu bar item 1 of menu bar 2
  end tell
end tell
'
