#!/bin/bash
echo "Iniciando nuevo contenedor..."
docker run -d -p 5000:5000 --name mi-app-flask mi-app-flask:latest