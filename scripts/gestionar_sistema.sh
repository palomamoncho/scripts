#!/bin/bash

# Función para listar usuarios con directorios en /home
listar_usuarios() {
    echo "Verificando el archivo /etc/passwd..."
    if [ ! -e /etc/passwd ]; then
        echo "ERROR: El archivo /etc/passwd no existe."
        exit 1
    fi

    usuarios=$(grep "/home" /etc/passwd | cut -d: -f1 | sort)
    if [ -z "$usuarios" ]; then
        echo "No hay usuarios con directorios en /home."
    else
        echo "Usuarios con directorios en /home:"
        echo "$usuarios"
    fi
}

# Función para mostrar información de un grupo
informacion_grupo() {
    echo "Introduce el nombre de un grupo:"
    read grupo

    if [ -z "$grupo" ]; then
        echo "ERROR: No se ha introducido un nombre de grupo."
        exit 1
    fi

    if [ ! -f /etc/group ]; then
        echo "ERROR: El archivo /etc/group no existe."
        exit 1
    fi

    group=$(grep "^$grupo:" /etc/group)
    if [ -z "$group" ]; then
        echo "No se encontró el grupo especificado: $grupo."
        exit 1
    fi

    name=$(echo "$group" | cut -d: -f1)
    gid=$(echo "$group" | cut -d: -f3)
    user=$(echo "$group" | cut -d: -f4 | cut -d, -f1)

    echo "Información del grupo:"
    echo "Nombre: $name"
    echo "GID: $gid"
    if [ -z "$user" ]; then
        echo "No hay miembros en el grupo."
    else
        echo "Primer miembro: $user"
    fi
}

# Función para crear copia de seguridad del escritorio
backup_escritorio() {
    echo "Introduce el nombre de un usuario para el backup:"
    read usuario

    if [ -z "$usuario" ]; then
        echo "ERROR: Debe introducir un nombre de usuario."
        exit 1
    fi

    if [ ! -d "/home/$usuario" ]; then
        echo "ERROR: El usuario no tiene un directorio en /home."
        exit 1
    fi

    cd "/home/$usuario" || {
        echo "ERROR: No se pudo acceder al directorio /home/$usuario."
        exit 1
    }

    if [ ! -d "backups" ]; then
        mkdir backups
        echo "Directorio 'backups' creado."
    fi

    if [ -d "Desktop" ]; then
        tar -czvf backups/backups.tar.gz Desktop
        echo "Copia de seguridad del escritorio terminada en backups/backups.tar.gz."
    else
        echo "Advertencia: No se encontró el directorio 'Desktop'."
    fi
}

# Menú principal
echo "Elige una opción:"
echo "1) Listar usuarios con directorios en /home"
echo "2) Mostrar información de un grupo"
echo "3) Crear copia de seguridad del escritorio de un usuario"
read opcion

case $opcion in
    1)
        listar_usuarios
        ;;
    2)
        informacion_grupo
        ;;
    3)
        backup_escritorio
        ;;
    *)
        echo "Opción no válida. Saliendo."
        exit 1
        ;;
esac
