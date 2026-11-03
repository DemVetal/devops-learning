#!/bin/bash
# check_disk.sh — проверяет заполненность дисков и предупреждает при превышении порога
# Использование: ./check_disk.sh [порог_в_процентах]   (по умолчанию 80)
# Коды возврата: 0 — всё в норме, 1 — есть диски выше порога, 2 — неверный аргумент

set -euo pipefail

THRESHOLD="${1:-80}"
MOUNTS="/ /mnt/c /mnt/d /mnt/e /mnt/f"
PROBLEMS=0

# Проверка аргумента: порог должен состоять только из цифр
if ! [[ "$THRESHOLD" =~ ^[0-9]+$ ]]; then
    echo "Ошибка: порог должен быть числом. Пример: $0 80"
    exit 2
fi

check_mount() {
    local MOUNT="$1"
    local USE
    USE="$(df -P "$MOUNT" | awk 'NR==2 {print $5}' | tr -d '%')"

    if [ "$USE" -ge "$THRESHOLD" ]; then
        echo "ВНИМАНИЕ: $MOUNT заполнен на $USE% (порог $THRESHOLD%)"
        return 1
    else 
        echo "OK: $MOUNT - $USE%"
    fi

    # ВСТАВЬ СЮДА:
    # если USE больше или равно THRESHOLD —
    #     вывести "ВНИМАНИЕ: $MOUNT заполнен на $USE% (порог $THRESHOLD%)" и return 1
    # иначе —
    #     вывести "OK: $MOUNT — $USE%"
}

echo "=== Проверка дисков: $(date '+%F %T'), порог ${THRESHOLD}% ==="

for MOUNT in $MOUNTS; do
    if [ ! -d "$MOUNT" ]; then
        echo "ПРОПУСК: $MOUNT не найден"
        continue
    fi
    check_mount "$MOUNT" || PROBLEMS=$((PROBLEMS + 1))
done

echo "Итого проблемных дисков: $PROBLEMS"

if [ "$PROBLEMS" -gt 0 ]; then
    exit 1
fi
exit 0