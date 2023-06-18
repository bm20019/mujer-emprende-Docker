#!/bin/bash
pwd
# Obtener la dirección IP pública del host
ip=$(curl -s http://checkip.amazonaws.com)

# Reemplazar la cadena de texto en el archivo
sed -i "s/localhost/$ip/g" src/app/components/principal/principal.component.ts

echo "La dirección IP pública del host es: $ip"
