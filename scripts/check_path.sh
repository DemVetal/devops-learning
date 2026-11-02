#!/bin/bash
# check_path.sh — определяет, что находится по указанному пути
# Использование: ./check_path.sh <путь>

TARGET="$1"

# Проверка: передан ли аргумент
if [ -z "$TARGET" ]; then
    echo "Ошибка: не указан путь"
    echo "Использование: $0 <путь>"
    exit 1
fi

if [ -d "$TARGET" ]; then
    echo "$TARGET — это папка"
    
elif [ -f "$TARGET" ]; then
    echo "$TARGET - это файл"

# ВСТАВЬ СЮДА: проверку, что это файл (elif), и сообщение "это файл"
else
    echo "$TARGET — не найден"
    exit 2
fi