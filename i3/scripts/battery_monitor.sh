#!/bin/bash

# Ensure D-Bus is running
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    eval $(dbus-launch --sh-syntax)
    export DBUS_SESSION_BUS_ADDRESS
    echo "D-Bus started: $DBUS_SESSION_BUS_ADDRESS"
fi

# Thresholds
LOW_BATTERY_THRESHOLD=20
CRITICAL_BATTERY_THRESHOLD=10

while true; do
    # Check battery status
    BATTERY_LEVEL=$(acpi -b | grep -P -o '[0-9]+(?=%)')
    BATTERY_STATUS=$(acpi -b | grep -oP '(Charging|Discharging)')

    echo "Battery level: $BATTERY_LEVEL, Status: $BATTERY_STATUS"

    if [[ $BATTERY_STATUS == "Discharging" && $BATTERY_LEVEL -le $CRITICAL_BATTERY_THRESHOLD ]]; then
        notify-send -u critical "Battery Low" "Battery level is critically low ($BATTERY_LEVEL%). Please plug in your charger."
        echo "Critical battery notification sent."
    elif [[ $BATTERY_STATUS == "Discharging" && $BATTERY_LEVEL -le $LOW_BATTERY_THRESHOLD ]]; then
        notify-send -u normal "Battery Low" "Battery level is low ($BATTERY_LEVEL%)."
    fi

    # Wait for 5 minutes before checking again
    sleep 300
done

