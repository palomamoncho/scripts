#!/bin/bash

# Script para verificar si un usuario existe y manejar su directorio home

if [ $# -ne 1 ]; then
    echo "Error: Me falta 1 parámetro"
    echo "Uso: $0 nombre_usuario"
    exit 1
fi

USUARIO=$1

# Verificar si el usuario existe en /etc/passwd
if grep -qw "^$USUARIO" /etc/passwd; then
    echo "El usuario '$USUARIO' existe"

    # Intentar cambiar al directorio home del usuario
    if cd "/home/$USUARIO"; then
        echo "Directorio /home/$USUARIO encontrado"

        # Verificar si el directorio 'backups' existe, y crearlo si no existe
        if [ ! -d "backups" ]; then
            mkdir backups
            echo "Directorio 'backups' creado"
        else
            echo "El directorio 'backups' ya existe"
        fi

        # Cambiar al directorio 'backups'
        cd backups
        echo "Ahora estás en el directorio $(pwd)"
    else
        echo "No se pudo acceder al directorio /home/$USUARIO"
        exit 1
    fi
else
    echo "Error: El usuario '$USUARIO' no existe"
    exit 1
fi
