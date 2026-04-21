pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', 
                    url: 'https://github.com/luiswiccho/mi-repositorio-devops.git',
                    credentialsId: 'github-pat'
            }
        }

        stage('Instalar dependencias') {
            steps {
                // Para Windows usa 'bat' en lugar de 'sh'
                bat 'pip install -r app/requirements.txt'
            }
        }

        stage('Ejecutar pruebas') {
            steps {
                bat 'python -m pytest tests/ -v'
            }
        }

        stage('Preparar artefactos para AWS') {
            steps {
                echo '✅ Código validado y listo para AWS CodePipeline'
                echo '📦 AWS CodeBuild construirá la imagen Docker'
                echo '🚀 AWS CodeDeploy desplegará la aplicación'
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline ejecutado con éxito - Código listo para AWS'
        }
        failure {
            echo '❌ Pipeline falló - Revisa los logs'
        }
    }
}