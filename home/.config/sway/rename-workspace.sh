#!/bin/bash

workspace_number=$(swaymsg -t get_workspaces 2>&1 | jq -r '.[] | select(.focused) | .num')

[ -z "$workspace_number" ] && exit 0

new_name=$(rofi -dmenu -lines 0 -p 'New Workspace name')

[ -z "$new_name" ] && exit 0

swaymsg rename workspace to "${workspace_number}:${new_name}"
