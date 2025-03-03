#!/bin/bash

num_aleatorio=$(( $RANDOM % 6 ))

echo "Elige un número del 0 al 5:"
read num_elegido

if (( num_elegido >= 0 and num_elegido <= 5 )); then
  echo "¿Cuánto apuestas?"
  read apuesta

  if (( num_elegido == num_aleatorio )); then
    premio=$(( apuesta * 5 ))
    echo "¡Acertaste! Has ganado $premio euros."
  else
    echo "Has fallado, el número era el $num_aleatorio. Pierdes $apuesta euros."
  fi
else
  echo "El número elegido no está entre 0 y 5."
fi