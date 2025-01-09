#!/usr/bin/env bash

TIMER_FILE="i3timer"
STATUS="stopped"
TIME=0

# Default Pomodoro duration in seconds
POMODORO_DURATION=25*60

start_timer() {
    STATUS="running"
    TIME=$(date +%s)
    echo "$STATUS,$TIME,$1" > "$TIMER_FILE"
}

stop_timer() {
    STATUS="stopped"
    echo "$STATUS,0,0" > "$TIMER_FILE"
}

check_timer() {
    if [[ -f "$TIMER_FILE" ]]; then
        IFS=',' read -r STATUS TIME DURATION < "$TIMER_FILE"
        if [ "$STATUS" == "running" ]; then
            ELAPSED=$(( $(date +%s) - TIME ))
            if [ "$ELAPSED" -ge "$DURATION" ]; then
                stop_timer
                # Play sound when timer is done
                mpv ~/home-manager/dotfiles/pomo-gong.mp3 &
                echo "🍅: Done"
            else
                echo "🍅: $(date -u -d @$((DURATION - ELAPSED)) +%M:%S)"
            fi
        else
            echo "⏱️"
        fi
    else
        echo "⏱️"
    fi
}

case "$1" in
    "start")
        # Check if a second argument (duration) is provided
        if [ -n "$2" ]; then
            POMODORO_DURATION=$2*60
        fi
        start_timer "$POMODORO_DURATION"
        ;;
    "stop")
        stop_timer
        ;;
    *)
        check_timer
        ;;
esac
