#!/usr/bin/env bash

mic_name="OBSMic"
combined_sink_name="OBSCombined"

# Unload module
pactl unload-module module-null-sink || true
pactl unload-module module-combine-sink || true

# Create virtual sink
pactl load-module module-null-sink media.class=Audio/Sink sink_name=$mic_name channel_map=front-left,front-right

# Create virtual mic
pactl load-module module-null-sink media.class=Audio/Source/Virtual sink_name=$mic_name channel_map=front-left,front-right

# Wait for last command to take effect
sleep 1

# Link mic to sink
pw-link "$mic_name:monitor_FL" "$mic_name:input_FL"
pw-link "$mic_name:monitor_FR" "$mic_name:input_FR"

# Create a combined sink
default_sink=$(pactl get-default-sink)
pactl load-module module-combine-sink sink_name=$combined_sink_name slaves=$mic_name,$default_sink
