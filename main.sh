#!/usr/bin/env bash

mic_name="OBSMic"
combined_sink_name="OBSCombined"

# Unload module
echo "Unloading modules"
pactl unload-module module-null-sink 2> /dev/null || true
pactl unload-module module-combine-sink 2> /dev/null || true

# Create virtual sink
pactl load-module module-null-sink media.class=Audio/Sink sink_name=$mic_name channel_map=front-left,front-right > /dev/null
echo "Succesfully created virtual sink: $mic_name"

# Create virtual mic
pactl load-module module-null-sink media.class=Audio/Source/Virtual sink_name=$mic_name channel_map=front-left,front-right > /dev/null
echo "Succesfully created virtual source: $mic_name"

# Wait for last command to take effect
sleep 1

# Link mic to sink
pw-link $mic_name:monitor_FL $mic_name:input_FL
pw-link $mic_name:monitor_FR $mic_name:input_FR
echo "Successfully linked sink to source"

# Create a combined sink
default_sink=$(pactl get-default-sink)
echo "Combining default sink ($default_sink) with $mic_name"
pactl load-module module-combine-sink sink_name="$combined_sink_name" slaves="$mic_name,$default_sink" > /dev/null
