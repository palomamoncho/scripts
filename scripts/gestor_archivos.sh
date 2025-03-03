#!/bin/bash
opc=-1

while [ $opc -ne 0 ]
do
    echo "#Mini Shell#"
    echo "1-Crear un fichero"
    echo "2-Crear un directorio"
    echo "3-Listar un directorio"
    echo "0-salir"
    read opc


    case $opc in
        1) 
            echo "Introduce el nombre del fichero:"
            read file
            touch "$file"
            echo "Fichero $file creado."
            ;;
        2) 
            echo "Introduce el nombre del directorio:"
            read dir
            mkdir "$dir"
            echo "Directorio $dir creado."
            ;;
        3) 
            echo "Dame el nombre de un directorio:"
            read dir
            ls "$dir"
            ;;
        *) 
            echo "Opción no válida"
            ;;
    esac

done