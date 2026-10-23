#!/bin/bash
# Focus the running scrcpy window, or start mirroring if nothing is running.
# scrcpy is not an app bundle, so `open -a` does not work on it.

export PATH="/opt/homebrew/bin:$PATH"

if pgrep -x scrcpy >/dev/null 2>&1; then
  osascript -e 'tell application "System Events" to set frontmost of first process whose name is "scrcpy" to true'
else
  scrcpy "$@" >/dev/null 2>&1 &
  disown
fi
