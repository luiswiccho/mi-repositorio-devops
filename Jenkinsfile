pipeline {
    agent any

    environment {
        // Variables de entorno para la aplicación
        PYTHON_VERSION = '3.9'
        APP_NAME = 'Flask App'
    }

    stages {
        stage('Checkout') {
            steps {
                echo '📥 Clonando repositorio...'
                git branch: 'main', 
                    url: 'https://github.com/luiswiccho/mi-repositorio-devops.git',
                    credentialsId: 'github-pat'
            }
        }

        stage('Instalar dependencias') {
            steps {
                echo '📦 Instalando dependencias de Python...'
                bat 'pip install -r app/requirements.txt'
                bat 'pip install pytest'  // Asegurar que pytest esté instalado
            }
        }

        stage('Verificar estructura del proyecto') {
            steps {
                echo '🔍 Verificando archivos necesarios...'
                bat 'if exist app\\app.py (echo ✅ app.py encontrado) else (echo ❌ app.py no encontrado & exit 1)'
                bat 'if exist app\\requirements.txt (echo ✅ requirements.txt encontrado) else (echo ❌ requirements.txt no encontrado & exit 1)'
                bat 'if exist app\\Dockerfile (echo ✅ Dockerfile encontrado) else (echo ⚠️ Dockerfile no encontrado - Se usará en AWS)'
            }
        }

        stage('Ejecutar pruebas unitarias') {
            steps {
                echo '🧪 Ejecutando pruebas unitarias...'
                bat 'python -m pytest tests/ -v --tb=short'
            }
        }

        stage('Validar sintaxis de Python') {
            steps {
                echo '🔧 Validando sintaxis del código...'
                bat 'python -m py_compile app/app.py'
                echo '✅ Sintaxis correcta'
            }
        }

        stage('Verificar configuración de AWS') {
            steps {
                echo '☁️ Verificando archivos de configuración de AWS...'
                bat 'if exist buildspec.yml (echo ✅ buildspec.yml encontrado) else (echo ❌ buildspec.yml no encontrado & exit 1)'
                bat 'if exist appspec.yml (echo ✅ appspec.yml encontrado) else (echo ❌ appspec.yml no encontrado & exit 1)'
                bat 'if exist scripts\\before_install.sh (echo ✅ before_install.sh encontrado) else (echo ⚠️ before_install.sh no encontrado)'
                bat 'if exist scripts\\after_install.sh (echo ✅ after_install.sh encontrado) else (echo ⚠️ after_install.sh no encontrado)'
            }
        }

        stage('Prueba de importación') {
            steps {
                echo '📚 Probando que la aplicación se puede importar...'
                bat 'python -c "import sys; sys.path.append(\\"app\\"); from app import app; print(\\"✅ App importada exitosamente\\")"'
            }
        }
    }

    post {
        success {
            echo '''
            ═══════════════════════════════════════════════════════════
            ✅ PIPELINE DE VALIDACIÓN EXITOSO
            ═══════════════════════════════════════════════════════════
            📊 Resumen de validación:
            • Código fuente: ✅ Correcto
            • Dependencias: ✅ Instaladas  
            • Pruebas unitarias: ✅ Pasaron
            • Sintaxis Python: ✅ Válida
            • Configuración AWS: ✅ Completa
            
            🚀 Próximo paso: AWS CodePipeline construirá y desplegará
            📦 La imagen Docker se construirá en AWS CodeBuild
            🌐 La app se desplegará con AWS CodeDeploy
            ═══════════════════════════════════════════════════════════
            '''
        }
        failure {
            echo '''
            ═══════════════════════════════════════════════════════════
            ❌ PIPELINE DE VALIDACIÓN FALLIDO
            ═══════════════════════════════════════════════════════════
            🔍 Revisa los logs arriba para identificar el error.
            
            Posibles causas comunes:
            • Faltan archivos requeridos (app.py, requirements.txt)
            • Error de sintaxis en Python
            • Pruebas unitarias fallaron
            • Dependencias no instaladas correctamente
            ═══════════════════════════════════════════════════════════
            '''
        }
        always {
            echo '📋 Limpiando entorno...'
            // Limpiar caché de Python si es necesario
            bat 'python -c "import sys; print(f\\"Versión de Python: {sys.version}\\"); print(f\\"Ruta de Python: {sys.executable}\\")"'
        }
    }
}