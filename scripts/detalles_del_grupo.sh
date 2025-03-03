#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Nombre del grupo"
  exit 1
fi

GRUPO=$1

GRUPO_INFO=$(getent group "$GRUPO")

if [ -z "$GRUPO_INFO" ]; then
  echo "El grupo no existe"
  exit 1
fi

NOMBREGRUPO=$(echo "$GRUPO_INFO" | cut -d: -f1)
GID=$(echo "$GRUPO_INFO" | cut -d: -f3)
MIEMBRO=$(echo "$GRUPO_INFO" | cut -d: -f4)

echo "El nombre del grupo es:"
echo "$NOMBREGRUPO"
echo "Su GID es:"
echo "$GID"
echo "El primer miembro es:"
echo "$MIEMBRO"