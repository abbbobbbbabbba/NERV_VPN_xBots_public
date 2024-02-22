#!/bin/bash

internet_interface=$(ip a | awk '/^[0-9]+: .* state UP/ {gsub(/:/,"",$2); print $2}' | grep -E '^ens[0-9]+')

if [ -z "$internet_interface" ]; then
  echo "Интерфейс с доступом в интернет не найден."
  internet_interface="eth0"
fi

ip_address=$(ip a show dev $internet_interface | awk '/inet / {split($2, a, "/"); print a[1]}')

if [ -z "$ip_address" ]; then
  echo "IP-адрес интерфейса $internet_interface не найден."
  exit 1
fi

ip_address_glob=$(curl -s ifconfig.me)
echo "Полученный IP-адрес: $ip_address_glob"
echo "Имя интерфейса: $internet_interface"
echo "internet_interface=${internet_interface}" >> variables.sh
echo "IP-адрес: $ip_address"
