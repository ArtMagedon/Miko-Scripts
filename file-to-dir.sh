#!/usr/bin/env bash

set -euo pipefail

if [[ $# -ne 1 ]]; then
    echo "Использование: $0 <путь_к_папке>"
    exit 1
fi

TARGET_DIR="${1%/}"

if [[ ! -d "$TARGET_DIR" ]]; then
    echo "Ошибка: директория не существует: $TARGET_DIR"
    exit 1
fi

cd -- "$TARGET_DIR"

shopt -s dotglob nullglob

for file in *; do
    [[ -f "$file" ]] || continue

    # Убираем расширение из имени
    dir_name="${file%.*}"

    # Если расширения нет, оставляем исходное имя
    [[ "$dir_name" == "$file" ]] && dir_name="$file"

    # Создаём директорию
    mkdir -- "$dir_name"

    # Перемещаем файл
    mv -- "$file" "$dir_name/$file"

    echo "Перемещён: $file -> $dir_name/$file"
done

echo "Готово!"
