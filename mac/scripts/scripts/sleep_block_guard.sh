#!/bin/bash

PLIST="/Library/LaunchDaemons/com.user.sleepblock.plist"

current_hour=$(date +%H)

if (( current_hour >= 0 && current_hour <= 4 )); then
  if ! launchctl list | grep -q com.user.sleepblock; then
    launchctl load "$PLIST"
  fi
fi
