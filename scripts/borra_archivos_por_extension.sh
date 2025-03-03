#!/bin/bash

if (( $# < 2 )); then
  echo "Se deben especificar al menos dos extensiones."
  exit 1
fi
for ext in "$@"; do
  echo "Se van a borrar los ficheros con extensión $ext"

  ficheros=$(ls *.$ext 2>/dev/null)

  if [[ -z $ficheros ]]; then
    echo "No hay ficheros con extensión $ext."
    continue
  fi

  for fichero in $ficheros; do
    echo "¿Deseas borrar el fichero $fichero? (S/N)"
    read opcion

    if [[ $opcion == "S" || $opcion == "s" ]]; then
      rm "$fichero"
      echo "Fichero borrado"
    else
      echo "No se ha borrado el fichero"
    fi
  done
done

echo "Proceso finalizado"