#!/bin/bash

if [ $# -ne 1 ]
then
    echo "Error: Necesito 1 parámetro"
    echo "$0 fichero/directotorio/"
    exit1
fi
    if [ -d "$1" ];
    then
        echo "$1 es un directorio"
    elif [ -f "$1" ];
    then 
        echo "$1 es un link"
    elif [-h "$1" ];
    then
        echo "$1 es un fichero"
    else
        echo "$1 no existe"
fi