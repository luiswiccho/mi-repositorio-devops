pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/luiswiccho/mi-repositorio-devops.git'
            }
        }

        stage('Instalar dependencias') {
            steps {
                sh 'pip install -r app/requirements.txt'
            }
        }

        stage('Ejecutar pruebas') {
            steps {
                sh 'python -m pytest tests/'
            }
        }


        stage('Construir imagen Docker') {
            steps {
                sh 'docker build -t mi-app-flask ./app'
            }
        }

        stage('Despliegue con Docker Compose') {
            steps {
                sh 'docker-compose up -d'
            }
        }
    }

    post {
        success {
            echo 'Pipeline ejecutado con éxito 🚀'
        }
        failure {
            echo 'Pipeline falló ❌'
        }
    }
}
