#!/bin/bash
echo "Deteniendo contenedor anterior si existe..."
docker stop mi-app-flask || true
docker rm mi-app-flask || true