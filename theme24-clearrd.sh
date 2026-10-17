#!/bin/bash

set -euo pipefail

SOURCE_26="/usr/share/icons/Yaru"
SOURCE_24="$HOME/yaru-24/usr/share/icons/Yaru"

TARGET="$HOME/.themes/yaru-24-places/Yaru-24"

echo "Yaru 26: $SOURCE_26"
echo "Yaru 24: $SOURCE_24"
echo "Результат: $TARGET"
echo

if [ ! -d "$SOURCE_26" ]; then
    echo "ОШИБКА: не найден Yaru 26:"
    echo "$SOURCE_26"
    exit 1
fi

if [ ! -d "$SOURCE_24" ]; then
    echo "ОШИБКА: не найден Yaru 24:"
    echo "$SOURCE_24"
    exit 1
fi

# Удаляем предыдущий результат.
if [ -e "$TARGET" ] || [ -L "$TARGET" ]; then
    rm -rf "$TARGET"
fi

mkdir -p "$TARGET"

COUNT_24=0
COUNT_26=0

echo "Создание объединенной темы..."
echo

while IFS= read -r -d '' FILE_26; do

    RELATIVE="${FILE_26#$SOURCE_26/}"
    FILE_24="$SOURCE_24/$RELATIVE"
    DEST="$TARGET/$RELATIVE"

    # index.theme берем из Yaru 26 отдельно.
    if [ "$RELATIVE" = "index.theme" ]; then
        continue
    fi

    mkdir -p "$(dirname "$DEST")"

    if [ -e "$FILE_24" ]; then
        cp -a "$FILE_24" "$DEST"
        ((COUNT_24+=1))
    else
        cp -a "$FILE_26" "$DEST"
        ((COUNT_26+=1))
    fi

done < <(
    find "$SOURCE_26" -type f -print0
)

# index.theme берем из Yaru 26.
cp -a "$SOURCE_26/index.theme" "$TARGET/index.theme"

echo
echo "========================================"
echo "Готово"
echo "========================================"
echo
echo "Из Yaru 24: $COUNT_24 файлов"
echo "Из Yaru 26: $COUNT_26 файлов"
echo
echo "Результат:"
echo "$TARGET"