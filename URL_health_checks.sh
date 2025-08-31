#!/bin/bash
# Health check for web application

URL="http://localhost:8080"

if curl -s --head "$URL" | grep "200 OK" > /dev/null; then
  echo "[OK] $URL is healthy."
else
  echo "[FAIL] $URL is down!"
fi
