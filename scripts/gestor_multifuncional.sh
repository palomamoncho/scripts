#!/bin/bash

# Función para listar usuarios con directorios en /home
listar_usuarios() {
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
    read -p "Introduce el nombre de un grupo: " grupo
    if [ -z "$grupo" ]; then
        echo "ERROR: Debe introducir un nombre de grupo."
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
    echo "Primer miembro: ${user:-'(sin miembros)'}"
}

# Función para gestionar información de usuarios
informacion_usuario() {
    read -p "Introduce el nombre del usuario: " username

    userinfo=$(grep "^$username:" /etc/passwd)
    if [ -z "$userinfo" ]; then
        echo "ERROR: El usuario '$username' no existe."
        exit 1
    fi

    name=$(echo "$userinfo" | cut -d: -f1)
    uid=$(echo "$userinfo" | cut -d: -f3)
    gid=$(echo "$userinfo" | cut -d: -f4)
    groupname=$(getent group "$gid" | cut -d: -f1)
    firstmember=$(getent group "$gid" | cut -d: -f4 | cut -d, -f1)

    echo "El nombre del usuario es $name"
    echo "Su UID es $uid"
    echo "El GID de su grupo principal es $gid"
    echo "El nombre de su grupo principal es $groupname"
    echo "El primer miembro del grupo es: ${firstmember:-'(sin miembros)'}"
}

# Función para gestionar datos personales
datos_personales() {
    read -p "Introduce tu nombre: " name
    read -p "Introduce tus apellidos: " lastnames
    read -p "Introduce tu edad: " age

    if ! [[ "$age" =~ ^[0-9]+$ ]]; then
        echo "ERROR: La edad debe ser un número válido."
        exit 1
    fi

    apellido1=$(echo "$lastnames" | cut -d " " -f1)
    apellido2=$(echo "$lastnames" | cut -d " " -f2)

    echo "Tu nombre es $name, tu primer apellido es $apellido1, tu segundo apellido es ${apellido2:-'(no especificado)'} y tu edad es $age años."
}

# Función para ejecutar un comando
ejecutar_comando() {
    read -p "Introduce un comando: " command

    if [ -z "$command" ]; then
        echo "ERROR: No se ingresó ningún comando."
        exit 1
    fi

    $command &
    command_pid=$!

    if [ -f "basura.txt" ]; then
        rm basura.txt
        echo "Archivo 'basura.txt' eliminado."
    else
        echo "El archivo 'basura.txt' no existe."
    fi

    $command &> result.txt
    echo "Salida del comando guardada en 'result.txt'."

    echo "Procesos en ejecución:"
    ps -ef

    echo "El PID del script es $$"
    echo "El PID del comando en segundo plano es $command_pid"
}

# Función para realizar copias de seguridad
backup_escritorio() {
    read -p "Introduce el nombre de un usuario para el backup: " usuario

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
        echo "Copia de seguridad del escritorio terminada."
    else
        echo "Advertencia: No se encontró el directorio 'Desktop'."
    fi
}

# Menú principal
echo "Seleccione una opción:"
echo "1) Listar usuarios con directorios en /home"
echo "2) Mostrar información de un grupo"
echo "3) Mostrar información de un usuario"
echo "4) Gestionar datos personales"
echo "5) Ejecutar un comando"
echo "6) Realizar copia de seguridad del escritorio"
read -p "Opción: " opcion

case $opcion in
    1) listar_usuarios ;;
    2) informacion_grupo ;;
    3) informacion_usuario ;;
    4) datos_personales ;;
    5) ejecutar_comando ;;
    6) backup_escritorio ;;
    *) echo "Opción no válida. Saliendo."; exit 1 ;;
esac
