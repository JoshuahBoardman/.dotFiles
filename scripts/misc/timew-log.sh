#!/bin/bash

#TODO: Set this to actual location... Might want to get some type of variable storage for my whole dotFiles
NOTE_DIR="$HOME/sandbox/my_obsidian_vault"
TODAY=$(date +%F)
DAILY_NOTE="$NOTE_DIR/$TODAY.md"

if [[ "$1" == "stop" ]]; then
    # Only log if the daily note already exists
    if [[ -f "$DAILY_NOTE" ]]; then

        # Run timew stop and capture its output
        OUTPUT=$(command timew stop)

        # Get the last finished interval in JSON
        LAST_INTERVAL=$(timew export | jq -r '[.[] | select(.end != null)] | last')

        # Proceed only if there is a finished interval
        if [[ "$LAST_INTERVAL" != "null" && -n "$LAST_INTERVAL" ]]; then
            # Extract start, end, and tags
            START=$(echo "$LAST_INTERVAL" | jq -r '.start')
            END=$(echo "$LAST_INTERVAL" | jq -r '.end')
            TAGS=$(echo "$LAST_INTERVAL" | jq -r '.tags | join(", ")')

            # Convert Timewarrior timestamps to ISO 8601 (for date parsing)
            START_ISO=$(echo "$START" | sed -E 's/([0-9]{4})([0-9]{2})([0-9]{2})T([0-9]{2})([0-9]{2})([0-9]{2})Z/\1-\2-\3T\4:\5:\6Z/')
            END_ISO=$(echo "$END"   | sed -E 's/([0-9]{4})([0-9]{2})([0-9]{2})T([0-9]{2})([0-9]{2})([0-9]{2})Z/\1-\2-\3T\4:\5:\6Z/')

            # Calculate duration in minutes using date
            DURATION_MINUTES=$(echo "$START_ISO $END_ISO" | awk '{ 
                cmd = "date -d \"" $2 "\" +%s"
                cmd | getline endsec
                close(cmd)
                cmd = "date -d \"" $1 "\" +%s"
                cmd | getline startsec
                close(cmd)
                print int((endsec - startsec)/60)
            }')

            # Append a human-readable log to the daily note
            LOG_MSG="Worked ${DURATION_MINUTES}m on ${TAGS}"
            echo -e "\n- $(date '+%H:%M'): $LOG_MSG" >> "$DAILY_NOTE"

	    # Show the original output in terminal
	    echo "$OUTPUT"
        fi
    else
        # If the daily note doesn't exist, just stop normally
        command timew stop
    fi
else
    # For all other timew commands, run normally
    command timew "$@"
fi
