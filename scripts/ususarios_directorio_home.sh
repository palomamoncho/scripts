#!/bin/bash

echo "Los usuarios tienen el directorio en /home" 

/etc/passwd | grep "/home" | cut -d: -f1 | sort