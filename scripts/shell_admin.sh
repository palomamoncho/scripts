#!/bin/bash
while true ;do
echo "dime la opcion que quieras"
echo "1 usuario"
echo "2 contar ficheros/directorios"
echo "3 grupos"
echo "4 ping"
echo "5 salir"
read opcion




case $opcion in

1)
 read -p "dime un nombre de usuario " usuario
 if [ -z "$usuario" ];
 then
 echo "pon un usuario valido una opcion"
 continue
fi
    if id "$usuario" >/dev/null 2>&1;then
    echo "el usuario $usuario existe"
    

    shell_del_usuario=$(grep "^$usuario": /etc/passwd | cut -d: -f7)
    echo "el shell  de inicio de $usuario es: $shell_del_usuario"
    else
    echo "el usuario no existe"
    fi

;;

2)
read -p "Selecciona la opcion que quieres(1 contar fichero,2 contar directorios): "  opcion
if [ $opcion == 1 ];
then
contarficheros=$(find /tmp -type f | wc -l)

echo "el numero de ficheros de /tmp es $contarficheros"


elif [ $opcion == 2 ];
then

contardirectorios=$(find /tmp -type d | wc -l)

echo "el numero de ficheros de /tmp es $contardirectorios"

else
echo "opcion no es valida seleccione 1 o 2"
exit 1
fi


;;
3)

if [ -z $grupos ];
then
echo "no se pudo obtener la lista de grupos"
fi

grupos=$(cut -d: -f1 /etc/group | sort -r)
echo "$grupos"

;;


4) 

read -p "dime una direccion ip para hacerle ping" dping
if [ -z $dping ];
then
echo "no se pudo hacer el ping"
fi

ping $dping

;;
5)
exit
;;
*)
echo "un numero del 1 al 5 por favor"

esac
done
