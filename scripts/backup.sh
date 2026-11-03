#!/bin/bash
# backup.sh — делает архивные копии указанных папок с датой в имени
# Использование: ./backup.sh
# Коды возврата: 0 — все бэкапы успешны, 1 — была хотя бы одна ошибка

BACKUP_DIR="$HOME/sandbox/backups"
SOURCES="$HOME/sandbox/server $HOME/sandbox/streams"
ERRORS=0

backup_dir() {
    local SRC="$1"
    local NAME
    NAME="$(basename "$SRC")"
    local ARCHIVE="$BACKUP_DIR/$NAME-$(date +%F).tar.gz"

    if [ ! -d "$SRC" ]; then
        echo "ОШИБКА: $SRC не найдена"
        return 1
    fi

    # ВСТАВЬ СЮДА: проверку, что папка $SRC существует.
    # Если её нет — вывести "ОШИБКА: $SRC не найдена" и выполнить return 1

    if tar -czf "$ARCHIVE" -C "$(dirname "$SRC")" "$NAME"; then
        echo "OK: $SRC → $ARCHIVE"
    else
        echo "ОШИБКА: не удалось заархивировать $SRC"
        return 1
    fi
}

mkdir -p "$BACKUP_DIR"

for SRC in $SOURCES; do
    backup_dir "$SRC" || ERRORS=$((ERRORS + 1))
done

echo "Готово. Ошибок: $ERRORS"

if [ "$ERRORS" -gt 0 ]; then
    exit 1
fi
exit 0