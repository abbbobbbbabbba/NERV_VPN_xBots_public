#!/bin/bash

SOURCE_DIR="/etc/wireguard/"

# Получение пути к директории, в которой находится скрипт backup.sh
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

BACKUP_FILE="$SCRIPT_DIR/../reset/wg0_backup.zip"

if [[ -f "$BACKUP_FILE" ]]; then
  rm "$BACKUP_FILE"
fi

zip -r "$BACKUP_FILE" "$SOURCE_DIR"

cd "$SOURCE_DIR"

zip -j "$BACKUP_FILE" "$SCRIPT_DIR/../cofigs.txt"

wg-quick down wg0
wg-quick up wg0

