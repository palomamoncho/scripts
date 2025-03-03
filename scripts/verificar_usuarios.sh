#!/bin/bash
if [$# -eq 1 ]
then
 #simepasa un parametro
  usuario=$(grep -w ^$1 /etc/passwd)
  echo $?
  echo $usuario
  if [ $# -eq 0]
  then
   echo "$1 existe en el sistema"
   if [ -d /home/$1 ]
   then
   echo "Vamos a hacer lo que dice el script"
  else
  echo "el /home/$1 no existe"
  cd /home/$1
  if [ -d "/backups" ]
  then 
  echo "/backups existe y no lo creo"
  else 
  mkdir /backups
  fi
  fi
  echo "$1 no existe en el sistema"
  exit 22
  fi
  cd /home/$1
else 
 #sinomepasa un parametro
 echo "ERROR: $0 nombreusuario"
fi