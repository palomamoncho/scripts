#!/bin/bash


if [ -z "$1" ]; then
  echo "ERROR: Se debe especificar un directorio"
  exit 1
fi

if [ ! -d "$1" ]; then
  echo "ERROR: El directorio no existe."
  exit 1
fi

numregulares=$(find "$1" -maxdepth 1 -type f | wc -l)
numdirectorios=$(find "$1" -maxdepth 1 -type d | wc -l)
numenlaces=$(find "$1" -maxdepth 1 -type l | wc -l)
numotros=$(find "$1" -maxdepth 1 ! -type f ! -type d ! -type l | wc -l)

echo "RESUMEN del directorio $1:"
echo
echo "$numdirectorios directorios."
echo
echo "$numregulares ficheros regulares."
echo
echo "$numenlaces enlaces simbólicos."
echo
echo "$numotros otros."
