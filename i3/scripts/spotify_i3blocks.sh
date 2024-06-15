#!/bin/bash

# Fetch the current status of Spotify
status=$(playerctl -p spotify status 2> /dev/null)

# If Spotify is not running or no song is playing, display nothing
if [[ $? -ne 0 ]] || [[ "$status" == "Stopped" ]] || [[ "$status" == "Paused" ]]; then
    echo ""
    exit 0
fi

# Get the artist and title of the currently playing song
artist=$(playerctl -p spotify metadata artist 2> /dev/null)
title=$(playerctl -p spotify metadata title 2> /dev/null)

# Display the song information
echo "󰓇 $artist - $title"

