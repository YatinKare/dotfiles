#!/usr/bin/env bash

APP_BUNDLE_ID="org.vim.MacVim"
APP_PATH="/Applications/MacVim.app"

if ! pgrep -x "MacVim" >/dev/null; then
  open -a "$APP_PATH" --args -g "$HOME/.macvim-dummy"
fi

for i in {1..30}; do
  macvim_window_id=$(aerospace list-windows --app-bundle-id "$APP_BUNDLE_ID" --monitor all --format '%{window-id}' | head -n1)
  [ -n "$macvim_window_id" ] && break
  sleep 0.1
done

[ -z "$macvim_window_id" ] && exit 1

aerospace focus --window-id "$macvim_window_id"

aerospace layout floating && \
  osascript -e 'tell application "System Events" to key code 120 using {control down, option down, command down}' \
  || aerospace layout tiling
