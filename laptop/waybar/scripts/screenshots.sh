#!/bin/bash

# Директория для сохранения скриншотов
SCREENSHOT_DIR="/home/q/Изображения/screenshots"

# Создаем директорию, если она не существует
mkdir -p "$SCREENSHOT_DIR"

# Генерируем уникальное базовое имя файла
BASENAME="screenshot_$(date +'%Y-%m-%d_%H-%M-%S')"
ORIGINAL_PATH="$SCREENSHOT_DIR/${BASENAME}.png"
EDITED_PATH="$SCREENSHOT_DIR/${BASENAME}_edited.png"

# Делаем скриншот выделенной области
grim -g "$(slurp)" "$ORIGINAL_PATH"

# Проверяем, был ли создан файл
if [ -f "$ORIGINAL_PATH" ]; then
    # Открываем оригинал в swappy
    if satty -f "$ORIGINAL_PATH" -o "$EDITED_PATH"; then
        # Проверяем, существует ли отредактированный файл
        if [ -f "$EDITED_PATH" ]; then
            # Сравниваем изображения - если идентичны, удаляем отредактированную копию
            is_identical=$(LC_NUMERIC=C compare -metric AE "$ORIGINAL_PATH" "$EDITED_PATH" null: 2>&1 | awk '{print ($1 < 1)}')
            if [ "$is_identical" = "1" ]; then
                rm "$EDITED_PATH"
            fi
        fi
    else
        # Swatty был закрыт без сохранения - удаляем оригинал
        rm "$ORIGINAL_PATH"
    fi
fi
