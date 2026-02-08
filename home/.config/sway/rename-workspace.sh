#!/bin/bash

# Get the current workspace number
current_workspace=$(swaymsg -t get_workspaces | jq -r '.[] | select(.focused) | .name')

# Extract the number from the current workspace name
workspace_number=$(echo $current_workspace | grep -o '^[0-9]*')

new_name=$(rofi -dmenu -lines 0 -p 'New Workspace name')

if [ -n "$new_name" ]; then
    new_name=:$new_name
fi

swaymsg rename workspace to $workspace_number$new_name
