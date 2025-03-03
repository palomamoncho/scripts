#!/bin/bash

#Script que recibe como parametro dos números y los compara

if [ $# -ne 2 ]
then
    echo "[ERROR]Necesito 2 números"
    echo "Ejemplo: $0 23 3"
else

valor=$1
valor=$2

if [ "$valor1" -eq "$valor2" ]
then
    echo "$valor1 = $valor2"
elif [ "$valor1" -gt "$valor2" ]
then
    echo "$valor1 > $valor2"
else
    echo "$valor1 < $valor2"
fi
fi