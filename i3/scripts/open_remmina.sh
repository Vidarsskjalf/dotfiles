#!/bin/bash

# Open Remmina
remmina & #-c ~/.local/share/remmina/your_connection_file.remmina &

# Give Remmina a moment to start
sleep 2

# Find the next available workspace
current_workspace=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).num')
next_workspace=$((current_workspace + 1))

# Move the Remmina window to the next available workspace
remmina_window=$(xdotool search --name 'Remmina')
i3-msg [id="$remmina_window"] move container to workspace number $next_workspace

# Switch to the next available workspace
i3-msg workspace number $next_workspace

