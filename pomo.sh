#!/bin/sh
TIMER_FILE="$HOME/.i3timer"
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

append_to_header() {
    local file="$1"
    local header="$2"
    local data="$3"

    # Escape special characters for sed
    header=$(printf '%s\n' "$header" | sed 's/[\/&]/\\&/g')

    # Check if the header exists
    if grep -q "^#\s*$header\s*$" "$file"; then
        # If header exists, append data with newlines at start and end
        sed -i '/^#\s*'"$header"'\s*$/a\
'"$data"'' "$file"
    else
        # If header does not exist, add header and data at the end of the file
        printf "\n# %s\n\n%s\n" "$header" "$data" >> "$file"
    fi
}

write_daily_note() {
    local DATE=$1

    local year=$(date +"%Y")
    local month=$(date +"%-m")
    local title=$(date +"%Y-%-m-%d")

    local monday=$(date -d "$(( $(date +%u) - 1 )) days ago" +%Y%m%d)
    local week_month=$(date -d "$monday" +%-m)
    local week="Week $(date +"%V")"

    FILE="Notes/DailyNotes/$year/$month/$title.md"
    FILE_PATH="$VAULT/$FILE"

    if [ ! -f "$FILE_PATH" ]; then
        TEMPLATE_FILE="$VAULT/templates/Note templates/Nvim Daily Notes.md"
        sed "s/{{year}}/$year/g;s/{{week_month}}/$week_month/g;s/{{week}}/$week/g" "$TEMPLATE_FILE" > "$FILE_PATH"
    fi

    append_to_header "$FILE_PATH" "Pomodoro Timer" "$DATE"

    # Update pomodoro counter property
    $VAULT/pomodoro -d $FILE_PATH
}

check_timer() {
    if [[ -f "$TIMER_FILE" ]]; then
        IFS=',' read -r STATUS TIME DURATION ISNOTE SOUND < "$TIMER_FILE"
        if [ "$STATUS" == "running" ]; then
            ELAPSED=$(( $(date +%s) - TIME ))
            if [ "$ELAPSED" -ge "$DURATION" ]; then
                stop_timer

                if [ $ISNOTE == "true" ]; then
                    write_daily_note "🍅 $(date "+%B %d %Y, %I:%M %p") - $((DURATION / 60))min"
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

while getopts 'd:s:n:a:v:' OPTION;
do
    case "$OPTION" in
        d) POMODORO_DURATION="$OPTARG";;
        s) SOUND="$OPTARG";;
        n) TONOTES="$OPTARG";;
        a) ACTION="$OPTARG";;
        v) VAULT="$OPTARG";;
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
