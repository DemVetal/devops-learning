#!/bin/bash
# log_report.sh — делает ежедневный отчёт по логу сайта
# Использование: ./log_report.sh <путь к логу>
# Коды возврата: 0 — успех, 1 — путь не указан, 2 - файл не найден, 3 - есть ошибки 500

set -euo pipefail

TARGET="${1:-}"


# Проверяем путь
if [ -z "$TARGET" ]; then
    echo "Ошибка: не указан путь"
    echo "Использование: $0 <путь к логу>"
    exit 1
fi

# Если файл не найден выводим ошибку
if [ ! -f "$TARGET" ]; then
    echo "$TARGET - файл не найден"
    exit 2
fi

# Сбор данных
DATE="$(date '+%F %T')"
REQUEST="$(wc -l < "$TARGET")"
TOP_IP="$(awk '{print $1}' "$TARGET" | sort | uniq -c | sort -nr | head -n 3)"
ANSWER_CODE="$(awk '{print $9}' "$TARGET" | sort | uniq -c | sort -nr)"
SITE_500="$(awk '$9 == 500 {print $7}' "$TARGET" | sort | uniq -c | sort -nr)"
REPORT_DIR="$HOME/sandbox/reports"
REPORT_FILE="$REPORT_DIR/report-$(date +%F_%H%M).txt"

print_report() {
    echo "==== Отчёт по логу сайта ===="
    echo "Дата: $DATE"
    echo "Файл: $TARGET"
    echo "Всего запросов: $REQUEST"
    echo "Топ-3 IP: 
$TOP_IP"
    echo "Ответы по кодам: 
$ANSWER_CODE"
    if [ -n "$SITE_500" ]; then
    echo "Страницы вернувшие ошибку 500: 
$SITE_500"
    fi
}

mkdir -p "$REPORT_DIR"

# Сохранение и вывод отчёта

print_report | tee "$REPORT_FILE"
echo "Отчёт сохранён: $REPORT_FILE"

if [ -n "$SITE_500" ]; then
    exit 3
    else
    exit 0
fi
