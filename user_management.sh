#!/bin/bash
# Add or remove users

ACTION=$1
USERNAME=$2

if [ "$ACTION" == "add" ]; then
  sudo useradd -m "$USERNAME"
  echo "User $USERNAME created."
elif [ "$ACTION" == "delete" ]; then
  sudo userdel -r "$USERNAME"
  echo "User $USERNAME deleted."
else
  echo "Usage: $0 {add|delete} username"
fi
