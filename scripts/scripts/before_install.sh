#!/bin/bash
# Detiene y elimina cualquier contenedor viejo que use el puerto 5000
docker stop mi-app-flask || true
docker rm mi-app-flask || true