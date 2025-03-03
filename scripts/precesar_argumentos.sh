#!/bin/bash

# Parte 1: Procesar argumentos
echo "Los tres primeros argumentos, uno debajo del otro:"
echo "$1"
echo "$2"
echo "$3"

echo "Los tres primeros argumentos, uno a continuación del otro:"
echo "$1$2$3"

echo "Número total de argumentos: $#"
echo "Todos los argumentos con \$*: $*"

# Validar que al menos un argumento fue proporcionado para la segunda parte
if [[ $# -lt 1 ]]; then
    echo "ERROR: Debes proporcionar un nombre de usuario como argumento."
    exit 1
fi

# Parte 2: Obtener información del usuario
echo "Buscando información del usuario '$1'..."

if ! grep -qw "^$1:" /etc/passwd; then
    echo "ERROR: El usuario '$1' no existe en el sistema."
    exit 1
fi

NOMBRE_USUARIO=$(grep -w "^$1" /etc/passwd | cut -d : -f 1)
UID=$(grep -w "^$1" /etc/passwd | cut -d : -f 3)
DIRECTORIO=$(grep -w "^$1" /etc/passwd | cut -d : -f 6)
SHELL=$(grep -w "^$1" /etc/passwd | cut -d : -f 7 | cut -d / -f 3)

echo "Tu nombre de usuario es: $NOMBRE_USUARIO"
echo "Tu UID: $UID"
echo "Tu directorio de inicio: $DIRECTORIO"
echo "Tu shell: $SHELL"
