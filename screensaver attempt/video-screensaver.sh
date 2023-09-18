#!/bin/bash

# Kill the spaceinvaders.py program if it is running
pkill -f "python.*spaceinvaders.py"

# Launch VLC in the background
vlc --fullscreen --no-video-title-show --loop /home/space/0space-invaders-fomcore/screensaver.ogv &

# Get the process ID of VLC
VLC_PID=$!

# Function to kill VLC if it's running
kill_vlc() {
    if ps -p $VLC_PID > /dev/null; then
        kill $VLC_PID
    fi
    exit
}

# Catch signals to kill VLC
trap kill_vlc SIGINT SIGTERM

# Monitor mouse and keyboard activity
while true; do
    # If the mouse is moved or a key is pressed, `xprintidle` will return a low number.
    IDLE_TIME=$(xprintidle)
    if [ "$IDLE_TIME" -lt "1000" ]; then  # less than 1 second
        kill_vlc
    fi
    sleep 0.5
done
