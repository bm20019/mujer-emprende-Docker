#!/bin/bash
pwd
# Obtener la dirección IP pública del host
# ip=$(curl -s http://checkip.amazonaws.com)
ipR=$(ip addr show eth1 | grep 'inet\b' | awk '{print $2}' | cut -d/ -f1)
domain="ip${ipR}-${SESSION_ID}-8080.${PWD_HOST_FQDN}"
# Reemplazar la cadena de texto en el archivo
sed -i "s/localhost/$domain/g" src/app/components/principal/principal.component.ts

echo "La dirección IP pública del host es: $domain"
