#!/bin/bash

echo "Esto es un bucle for"

for variable in Pep Angela Alba Reme
do 
    echo "Hola $variable"
done 

echo "Esto es un bucle for"
for variable in *.sh
do 
    echo "Fichero $variable"
done 


echo "Esto es un bucle for"
for var in $*
do 
    if [ $var -eq 0 ]
    then
        echo "$var es 0"
    break
    else
        echo "$var otro parámetro"
    fi
done 


if [ $# -eq 2 ]
then
    echo "fin porque me has pasado 2"
    exit 69
fi