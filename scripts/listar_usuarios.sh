#!/bin/bash

cat /etc/passwd | grep /home/ | cut -f1 -d: | sort