#!/bin/bash
# Check if a service is running and restart if needed

SERVICE="nginx"

if systemctl is-active --quiet "$SERVICE"; then
  echo "[OK] $SERVICE is running."
else
  echo "[ALERT] $SERVICE is not running. Restarting..."
  systemctl start "$SERVICE"
  echo "[INFO] $SERVICE restarted."
fi
