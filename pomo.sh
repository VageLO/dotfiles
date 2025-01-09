TIMER_FILE="i3timer"
STATUS="stopped"
TIME=0

# Write pomodoro log to daily note
TONOTES="true"
# Default duration 25min
POMODORO_DURATION=1500

start_timer() {
    STATUS="running"
    TIME=$(date +%s)
    echo "$STATUS,$TIME,$POMODORO_DURATION,$TONOTES,$SOUND" > "$TIMER_FILE"
}

stop_timer() {
    STATUS="stopped"
    echo "$STATUS,0,0,false,$SOUND" > "$TIMER_FILE"
}

write_daily_note() {
    local DATE=$1
    FILE="Notes/DailyNotes/$(date +"%Y")/$(date +"%-m")/$(date +"%Y-%-m-%d").md"
    FILE_PATH="/home/vagelo/main-vault/$FILE"

    if [ ! -f "$FILE_PATH" ]; then
        xdg-open "obsidian://new?vault=main-vault&file=$FILE" &
        sleep 5
    fi
    # TODO: Write log to Pomodor header
    printf '\n%s' "$DATE" >> "$FILE_PATH"
}

check_timer() {
    if [[ -f "$TIMER_FILE" ]]; then
        IFS=',' read -r STATUS TIME DURATION ISNOTE SOUND < "$TIMER_FILE"
        if [ "$STATUS" == "running" ]; then
            ELAPSED=$(( $(date +%s) - TIME ))
            if [ "$ELAPSED" -ge "$DURATION" ]; then
                stop_timer

                if [ $ISNOTE == "true" ]; then
                    write_daily_note "🍅 $(date "+%B %d, %Y, %I:%M %p")"
                fi

                # Play sound when timer is done
                mpv "$SOUND"
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

while getopts 'd:s:n:a:' OPTION;
do
    case "$OPTION" in
        d) POMODORO_DURATION="$OPTARG";;
        s) SOUND="$OPTARG";;
        n) TONOTES="$OPTARG";;
        a) ACTION="$OPTARG";;
    esac
done

shift $((OPTIND - 1))

case "$ACTION" in
    "start")
        start_timer
        ;;
    "stop")
        stop_timer
        ;;
    *)
        check_timer
        ;;
esac
