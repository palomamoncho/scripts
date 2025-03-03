#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Nombre del usuario"
  exit 1
fi

NOMBREUSUARIO=$1


if ! id -u "$NOMBREUSUARIO" > /dev/null ; then
  echo "El usuario no existe"
  exit 1
fi

INFOUSUARIO=$(id "$NOMBREUSUARIO")
UID=$(echo "$INFOUSUARIO" | awk '{print $1}' | cut -d= -f2)
GID=$(echo "$INFOUSUARIO" | awk '{print $2}' | cut -d= -f2)
NOMBREGRUPO=$(id -gn "$NOMBREUSUARIO")
MIEMBRO=$(getent group "$NOMBREGRUPO" | cut -d: -f4)

echo "El nombre del usuario es $NOMBREUSUARIO"
echo "Su UID es $UID"
echo "El GID de su grupo principal es $GID"
echo "El nombre de su grupo principal es $NOMBREGRUPO"
echo "El primer miembro de ese grupo es $MIEMBRO"
