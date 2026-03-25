#!/bin/bash

# Pomodoro script for Waybar with manual session start and robust state handling

# --- Configuration ---
WORK_MIN=25
SHORT_BREAK_MIN=5
LONG_BREAK_MIN=15
STATE_FILE="/tmp/waybar_pomodoro.state"

# --- Functions ---
send_notification() {
    notify-send -u critical -a "Pomodoro" "$1" "$2"
}

# Atomically writes the current state to the state file
write_state() {
    local tmp_state_file="${STATE_FILE}.tmp"
    {
        echo "MODE=${1:-init}"
        echo "END_TIME=${2:-0}"
        echo "RUNNING=${3:-false}"
        echo "POMODOROS=${4:-0}"
        echo "REMAINING=${5:-0}"
    } > "$tmp_state_file"
    mv "$tmp_state_file" "$STATE_FILE"
}

start_session() {
    source "$STATE_FILE" 2>/dev/null
    local mode=$1
    local duration=$2
    
    if [ "$mode" = "work" ]; then
        POMODOROS=$((POMODOROS + 1))
    fi
    
    local new_end_time=$(date -d "+$duration minutes" +%s)
    write_state "$mode" "$new_end_time" "true" "${POMODOROS:-0}" "0"
}

# --- Main Logic ---
case "$1" in
    toggle)
        if [ -f "$STATE_FILE" ]; then
            source "$STATE_FILE"
            case "$MODE" in
                pending_break)
                    if [ $((POMODOROS % 4)) -eq 0 ]; then
                        send_notification "Long Break Started" "$LONG_BREAK_MIN minutes"
                        start_session "break" $LONG_BREAK_MIN
                    else
                        send_notification "Short Break Started" "$SHORT_BREAK_MIN minutes"
                        start_session "break" $SHORT_BREAK_MIN
                    fi
                    ;;
                pending_work)
                    send_notification "Work Session Started" "$WORK_MIN minutes"
                    start_session "work" $WORK_MIN
                    ;;
                *)
                    if [ "$RUNNING" = true ]; then
                        # Pause
                        remaining_time=$((END_TIME - $(date +%s)))
                        # Prevent remaining time from being negative
                        [ $remaining_time -lt 0 ] && remaining_time=0
                        write_state "$MODE" "$END_TIME" "false" "$POMODOROS" "$remaining_time"
                    else
                        # Resume
                        new_end_time=$(( $(date +%s) + REMAINING ))
                        write_state "$MODE" "$new_end_time" "true" "$POMODOROS" "0"
                    fi
                    ;;
            esac
        else
            # Start fresh if no state file exists
            send_notification "Pomodoro Started" "$WORK_MIN minutes!"
            start_session "work" $WORK_MIN
        fi
        exit 0
        ;;
    reset)
        rm -f "$STATE_FILE"
        exit 0
        ;;
esac

# --- Display Logic ---
if [ ! -f "$STATE_FILE" ]; then
    echo '{"text":"", "tooltip":"Click to start Pomodoro"}'
    exit 0
fi

source "$STATE_FILE"

# Handle pending states first
if [ "$MODE" = "pending_break" ]; then
    echo "{\"text\":\" Start Break?\", \"tooltip\":\"Work session finished. Pomodoros: ${POMODOROS:-0}\"}"
    exit 0
fi
if [ "$MODE" = "pending_work" ]; then
    echo "{\"text\":\" Start Work?\", \"tooltip\":\"Break finished. Pomodoros: ${POMODOROS:-0}\"}"
    exit 0
fi

# Handle paused state
if [ "$RUNNING" = false ]; then
    MINS=$((REMAINING / 60))
    SECS=$((REMAINING % 60))
    printf '{"text":" %02d:%02d", "tooltip":"Timer is paused. Pomodoros: %s"}\n' "$MINS" "$SECS" "${POMODOROS:-0}"
    exit 0
fi

NOW=$(date +%s)
REMAINING_SECS=$((END_TIME - NOW))

# When timer hits zero, transition to a pending state
if [ $REMAINING_SECS -le 0 ]; then
    if [ "$MODE" = "work" ]; then
        send_notification "Work session over!" "Click to start your break."
        write_state "pending_break" "0" "false" "$POMODOROS" "0"
        echo "{\"text\":\" Start Break?\", \"tooltip\":\"Work session finished. Pomodoros: ${POMODOROS:-0}\"}"
    elif [ "$MODE" = "break" ]; then
        send_notification "Break is over!" "Click to start the next session."
        write_state "pending_work" "0" "false" "$POMODOROS" "0"
        echo "{\"text\":\" Start Work?\", \"tooltip\":\"Break finished. Pomodoros: ${POMODOROS:-0}\"}"
    fi
    exit 0
fi

# Default display for a running timer
MINS=$((REMAINING_SECS / 60))
SECS=$((REMAINING_SECS % 60))

ICON="" # Work
TOOLTIP="Work session. Pomodoros: ${POMODOROS:-0}"
if [ "$MODE" = "break" ]; then
    ICON="" # Break
    TOOLTIP="Break time. Pomodoros: ${POMODOROS:-0}"
fi

printf '{"text":"%s %02d:%02d", "tooltip":"%s"}\n' "$ICON" "$MINS" "$SECS" "$TOOLTIP"
