pipeline {
    agent any

    environment {
        PYTHON_VERSION = '3.9'
        APP_NAME = 'Flask App'
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Clonando repositorio...'
                git branch: 'main', 
                    url: 'https://github.com/luiswiccho/mi-repositorio-devops.git',
                    credentialsId: 'github-pat'
            }
        }

        stage('Instalar dependencias') {
            steps {
                echo 'Instalando dependencias de Python...'
                bat 'pip install -r app/requirements.txt'
            }
        }

        stage('Verificar estructura del proyecto') {
            steps {
                echo 'Verificando archivos necesarios...'
                bat 'if exist app\\app.py (echo OK: app.py encontrado) else (echo ERROR: app.py no encontrado & exit 1)'
                bat 'if exist app\\requirements.txt (echo OK: requirements.txt encontrado) else (echo ERROR: requirements.txt no encontrado & exit 1)'
                bat 'if exist app\\Dockerfile (echo OK: Dockerfile encontrado) else (echo WARNING: Dockerfile no encontrado)'
            }
        }

        stage('Ejecutar pruebas unitarias') {
            steps {
                echo 'Ejecutando pruebas unitarias...'
                bat 'python -m pytest tests/ -v --tb=short'
            }
        }

        stage('Validar sintaxis de Python') {
            steps {
                echo 'Validando sintaxis del codigo...'
                bat 'python -m py_compile app/app.py'
                echo 'OK: Sintaxis correcta'
            }
        }

        stage('Verificar configuracion de AWS') {
            steps {
                echo 'Verificando archivos de configuracion de AWS...'
                bat 'if exist buildspec.yml (echo OK: buildspec.yml encontrado) else (echo ERROR: buildspec.yml no encontrado & exit 1)'
                bat 'if exist appspec.yml (echo OK: appspec.yml encontrado) else (echo ERROR: appspec.yml no encontrado & exit 1)'
                bat 'if exist scripts\\before_install.sh (echo OK: before_install.sh encontrado) else (echo WARNING: before_install.sh no encontrado)'
                bat 'if exist scripts\\after_install.sh (echo OK: after_install.sh encontrado) else (echo WARNING: after_install.sh no encontrado)'
            }
        }

        stage('Prueba de importacion') {
            steps {
                echo 'Probando que la aplicacion se puede importar...'
                bat 'python -c "import sys; sys.path.append(\"app\"); from app import app; print(\"OK: App importada exitosamente\")"'
            }
        }
    }

    post {
        success {
            echo '''
            =============================================
            PIPELINE DE VALIDACION EXITOSO
            =============================================
            Resumen de validacion:
            - Codigo fuente: OK
            - Dependencias: Instaladas
            - Pruebas unitarias: Pasaron
            - Sintaxis Python: Valida
            - Configuracion AWS: Completa
            
            Proximo paso: Subir codigo a GitHub
            =============================================
            '''
        }
        failure {
            echo '''
            =============================================
            PIPELINE DE VALIDACION FALLIDO
            =============================================
            Revision los logs arriba para identificar el error.
            
            Posibles causas comunes:
            - Faltan archivos requeridos (app.py, requirements.txt)
            - Error de sintaxis en Python
            - Pruebas unitarias fallaron
            - Dependencias no instaladas correctamente
            =============================================
            '''
        }
        always {
            echo 'Mostrando informacion del entorno...'
            bat 'python --version'
        }
    }
}