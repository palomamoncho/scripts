#!/bin/bash

if [ $# -ne 1 ]
then
    echo "Error me falta 1 parámetro"
    exit 1
fi


if $(grep -w $1 /etc/group > /dev/null) 
then
  
    echo El nombre del grupo es:
    cat /etc/group| grep -w "$1" | cut -f1 -d :
    echo "El GID es:"
    cat /etc/group| grep -w "$1" | cut -f3 -d :
    echo "El miembro es:"
    cat /etc/group| grep -w "$1" | cut -f4 -d :
else
    echo "El grupo $1 no existe"
fi 