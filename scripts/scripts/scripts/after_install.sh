#!/bin/bash
# Asume que la imagen ya está en el servidor desde ECR.
# Inicia el nuevo contenedor
docker run -d -p 5000:5000 --name mi-app-flask $(aws ecr describe-images --repository-name mi-repo-ecr --query 'sort_by(imageDetails,&imagePushedAt)[-1].imageTags[0]' --output text)