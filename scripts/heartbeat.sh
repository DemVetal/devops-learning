#!/bin/bash
# heartbeat.sh — учебная служба: раз в 10 секунд сообщает, что жива
# Запускается через systemd (heartbeat.service), вывод уходит в журнал

set -euo pipefail

while true; do
    echo "heartbeat: $(date '+%F %T') — служба жива"
    sleep 10
done