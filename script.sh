#!/bin/bash

# Obtener la dirección IP pública del host
ip=$(curl -s http://checkip.amazonaws.com)

# Reemplazar la cadena de texto en el archivo
sed -i "s/http:\/\/ip172-19-0-18-ci71odcsnmng00ej6v60-8080.direct.labs.play-with-docker.com:8080/http:\/\/$ip:8080/g" test.ts

echo "La dirección IP pública del host es: $ip"
