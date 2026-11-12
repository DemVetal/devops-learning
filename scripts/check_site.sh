#!/bin/bash
# check_site.sh — проверяет сайт по коду ответа и пишет результат в журнал
# Использование: ./check_site.sh [URL]   (по умолчанию http://localhost:8080)
# Коды возврата: 0 — сайт ответил 200, 1 — другой код или нет ответа
# Журнал: journalctl -t check_site

set -euo pipefail

URL="${1:-http://localhost:8080}"

# --max-time 5 — не ждать ответа дольше 5 секунд
# || true — не дать set -e остановить скрипт, если сайт не отвечает
CODE="$(curl -s -o /dev/null -w "%{http_code}" --max-time 5 "$URL" || true)"

# ВСТАВЬ СЮДА:
# если CODE равен "200" —
#     записать в журнал: logger -t check_site "OK: $URL ответил $CODE"
#     и выйти с кодом 0
# иначе —
#     записать в журнал с уровнем ошибки: logger -t check_site -p user.err "FAIL: $URL ответил $CODE"
#     и выйти с кодом 1

if [ "$CODE" = "200" ]; then
    logger -t check_site "OK: $URL ответил $CODE"
    exit 0
else
    logger -t check_site -p user.err "Fail: $URL ответил $CODE"
    exit 1
fi
