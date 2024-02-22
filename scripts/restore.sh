#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

BACKUP_FILE="$SCRIPT_DIR/../reset/wg0_backup.zip"

DESTINATION_DIR="/etc/wireguard/"

if [ ! -f "$BACKUP_FILE" ]; then
  echo "Архив $BACKUP_FILE не найден."
  exit 1
fi

rm -rf "$DESTINATION_DIR"/*

cd "$DESTINATION_DIR"

unzip -j "$BACKUP_FILE"

if [ ! -f "$DESTINATION_DIR/cofigs.txt" ]; then
  echo "Распакованный файл cofigs.txt не найден в директории $DESTINATION_DIR."
  exit 1
fi

mv cofigs.txt "$SCRIPT_DIR"/..

wg-quick down wg0
wg-quick up wg0

