#!/bin/bash
# sysinfo.sh — краткая сводка о состоянии системы
# Использование: ./sysinfo.sh

# Собираем данные в переменные
DATE="$(date '+%F %T')"
USER_NAME="$(whoami)"
HOST="$(hostname)"
MEM_AVAIL="$(free -h | awk 'NR==2 {print $7}')"
DISK_USED="$(df -h / | awk 'NR==2 {print $5}')"

# Выводим отчёт
echo "===== Сводка о системе ====="
echo "Дата:              $DATE"
echo "Пользователь:      $USER_NAME"
echo "Компьютер:         $HOST"
echo "Доступно памяти:   $MEM_AVAIL"
echo "Время работы:      $(uptime -p)"
echo "Занято на диске /: $DISK_USED"