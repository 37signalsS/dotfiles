#!/bin/bash

SCREENSHOT_DIR="/home/q/Изображения/screenshots"

mkdir -p "$SCREENSHOT_DIR"

BASENAME="screenshot_$(date +'%Y-%m-%d_%H-%M-%S')"
ORIGINAL_PATH="$SCREENSHOT_DIR/${BASENAME}.png"
EDITED_PATH="$SCREENSHOT_DIR/${BASENAME}_edited.png"

grim -g "$(slurp)" "$ORIGINAL_PATH"

if [ -f "$ORIGINAL_PATH" ]; then
    if satty -f "$ORIGINAL_PATH" -o "$EDITED_PATH"; then
        if [ -f "$EDITED_PATH" ]; then
            is_identical=$(LC_NUMERIC=C compare -metric AE "$ORIGINAL_PATH" "$EDITED_PATH" null: 2>&1 | awk '{print ($1 < 1)}')
            if [ "$is_identical" = "1" ]; then
                rm "$EDITED_PATH"
            fi
        fi
    else
        rm "$ORIGINAL_PATH"
    fi
fi
