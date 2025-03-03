#!/bin/bash
echo "Pruebas ShellScript"
echo "Dame un nombre"
read nombre
echo "Dame los apellidos"
read ape1 ape2
echo "Hola $nombre $ape1 $ape2"
echo "Dame nombre a buscar"
read usuario
esta=$(grep $usuario /etc/passwd)
echo $esta
echo "El contenido de \$? es $?"