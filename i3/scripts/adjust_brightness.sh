#!/bin/bash

# Adjust brightness
brightnessctl set "$1"

# Get the current brightness level
brightness_level=$(brightnessctl get)
max_brightness=$(brightnessctl max)
brightness_percentage=$((100 * brightness_level / max_brightness))

# Send notification
notify-send -u low -h string:x-canonical-private-synchronous:brightness "Brightness" "Current brightness: ${brightness_percentage}%"

