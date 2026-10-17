#!/bin/bash

SOURCE_26="/usr/share/icons"
SOURCE_24="$HOME/yaru-24/usr/share/icons"

THEMES=(
    "Yaru"
    "Yaru-bark"
    "Yaru-bark-dark"
    "Yaru-blue"
    "Yaru-blue-dark"
    "Yaru-dark"
    "Yaru-magenta"
    "Yaru-magenta-dark"
    "Yaru-olive"
    "Yaru-olive-dark"
    "Yaru-prussiangreen"
    "Yaru-prussiangreen-dark"
    "Yaru-purple"
    "Yaru-purple-dark"
    "Yaru-red"
    "Yaru-red-dark"
    "Yaru-sage"
    "Yaru-sage-dark"
    "Yaru-viridian"
)

for THEME in "${THEMES[@]}"; do

    DIR_26="$SOURCE_26/$THEME"
    DIR_24="$SOURCE_24/$THEME"

    echo
    echo "========================================"
    echo "$THEME"
    echo "========================================"

    if [ ! -d "$DIR_26" ]; then
        echo "ОШИБКА: нет темы в 26:"
        echo "  $DIR_26"
        continue
    fi

    if [ ! -d "$DIR_24" ]; then
        echo "ОШИБКА: нет темы в 24:"
        echo "  $DIR_24"
        continue
    fi

    FOUND=0

    while IFS= read -r FILE_26; do

        RELATIVE="${FILE_26#$DIR_26/}"
        FILE_24="$DIR_24/$RELATIVE"

        if [ ! -f "$FILE_24" ]; then
            echo "$RELATIVE"
            FOUND=1
        fi

    done < <(
        find "$DIR_26" -type f | sort
    )

    if [ "$FOUND" -eq 0 ]; then
        echo "Нет файлов, отсутствующих в Yaru 24."
    fi

done
