#!/usr/bin/env bash

# Check if a player is running
if ! playerctl status &>/dev/null; then
    echo "No music playing"
    exit 0
fi

# Get metadata
title=$(playerctl metadata xesam:title 2>/dev/null)
artist=$(playerctl metadata xesam:artist 2>/dev/null)
length=$(playerctl metadata mpris:length 2>/dev/null)   # microseconds
position=$(playerctl position 2>/dev/null)              # seconds (float)

# Convert length from µs → s (integer)
length=$((length / 1000000))

# Convert position float → integer
position=${position%.*}   # strip decimal part safely

# Safety check
[ -z "$length" ] && length=0
[ -z "$position" ] && position=0

# Make a progress bar (20 chars wide)
bar_width=20
if [ "$length" -gt 0 ]; then
    filled=$(( position * bar_width / length ))
else
    filled=0
fi
empty=$((bar_width - filled))

progress="$(printf '█%.0s' $(seq 1 $filled))$(printf '░%.0s' $(seq 1 $empty))"

# Format time mm:ss
format_time() {
    local t=$1
    printf "%02d:%02d" $((t/60)) $((t%60))
}

pos_fmt=$(format_time $position)
len_fmt=$(format_time $length)

# Output
echo "$title"
echo "by $artist"
echo "$pos_fmt/$len_fmt"
echo "$progress"

