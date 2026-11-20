#!/usr/bin/env bash
set -euo pipefail

TARGET_URL="${1:-https://example.com}"

echo "[INFO] Running as user: $(whoami)"
echo "[INFO] Checking endpoint: $TARGET_URL"

HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$TARGET_URL")

if [ "$HTTP_STATUS" -eq 200 ]; then
  echo "[OK] Service healthy (HTTP $HTTP_STATUS)"
  exit 0
else
  echo "[ERROR] Service unhealthy (HTTP $HTTP_STATUS)"
  exit 1
fi
