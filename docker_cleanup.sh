#!/bin/bash
# Clean up unused Docker images, containers, and volumes

echo "[INFO] Removing stopped containers..."
docker container prune -f

echo "[INFO] Removing dangling images..."
docker image prune -f

echo "[INFO] Removing unused volumes..."
docker volume prune -f

echo "[SUCCESS] Docker cleanup completed!"
