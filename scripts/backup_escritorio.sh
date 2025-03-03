#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Nombre del usuario"
  exit 1
fi

USUARIO=$1

if ! id -u "$USUARIO" > /dev/null; then
  echo "El usuario no existe"
  exit 1
fi

cd /home/"$USUARIO"

mkdir -p backups

tar czf backups/backups.tar.gz Escritorio/*

echo "Copia de seguridad del escritorio terminada."