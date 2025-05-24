#!/bin/bash

# Set your desired profile
DESIRED_PROFILE="handsfree_head_unit"

# Set this to a unique identifier for your device (e.g., part of the MAC address or alias)
DEVICE_MATCH="BC_87_FA_28_91_DB" # Replace with your headset's MAC fragment

# Watch for new card events
pactl subscribe | while read -r event; do
    if [[ "$event" == "Event 'new' on card"* ]]; then
        # Loop over all PulseAudio cards
        pactl list cards short | while read -r card_index card_name _; do
            if [[ "$card_name" == *"$DEVICE_MATCH"* ]]; then
                pactl set-card-profile "$card_name" "$DESIRED_PROFILE"
            fi
        done
    fi
done
