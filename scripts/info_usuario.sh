#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage: $0 <username>"
  exit 1
fi

username="$1"
user_info=$(getent passwd "$username")

if [ -z "$user_info" ]; then
  echo "User '$username' not found"
  exit 1
fi

uid=$(echo "$user_info" | cut -d ':' -f 3)
gid=$(echo "$user_info" | cut -d ':' -f 4)
group_info=$(getent group "$gid")
group_name=$(echo "$group_info" | cut -d ':' -f 1)
miembro=$(echo "$group_info" | cut -d ':' -f 4 | cut -d ',' -f 1)

echo "El nombre del usuario es $username"
echo "Su UID es $uid"
echo "El GID de su grupo principal es $gid"
echo "El nombre de su grupo principal es $group_name"
echo "El primer miembro de ese grupo es $miembro"
