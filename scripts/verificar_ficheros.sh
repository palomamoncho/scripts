#!/bin/bash

echo "Pruebas Shell script"
echo "-------------------"
echo "Dame nombre del fichero"
read fitx

# Verificar si se ingresó un nombre de fichero
if [ -z "$fitx" ]; then
    echo "No has introducido un nombre de fichero"
    exit 1
fi

# Verificar si el fichero existe
if [ -f "$fitx" ]; then
    echo "El fichero '$fitx' existe"
else
    echo "El fichero '$fitx' no existe"
    touch "$fitx"
    echo "Creado '$fitx'"
fi
