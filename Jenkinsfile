pipeline {
    agent any

    environment {
        BACKEND_DIR = '02-backend/spring-boot-restapi'
        FRONTEND_DIR = '03-frontend/angular-ecommerce'
    }

    stages {
        stage('Prepare Workspace') {
            steps {
                // Nettoyer l'espace avant de cloner
                deleteDir()
                sh 'git config --global http.postBuffer 524288000'
            }
        }

        stage('Checkout SCM') {
            steps {
                script {
                    retry(3) { // Essayer de cloner jusqu'à 3 fois en cas d'échec
                        checkout scm
                    }
                }
            }
        }

        stage('Install Backend Dependencies') {
            steps {
                dir(BACKEND_DIR) {
                    sh './mvnw clean install -DskipTests'
                }
            }
        }

        stage('Build Backend') {
            steps {
                dir(BACKEND_DIR) {
                    sh './mvnw package -DskipTests'
                }
            }
        }

        stage('Run Backend') {
            steps {
                dir(BACKEND_DIR) {
                    sh 'nohup java -jar target/*.jar &'
                }
            }
        }

        stage('Install Angular CLI') {
            steps {
                sh 'sudo npm install -g @angular/cli@latest'
            }
        }

        stage('Install Frontend Dependencies') {
            steps {
                dir(FRONTEND_DIR) {
                    sh 'npm install'
                }
            }
        }

        stage('Build Frontend') {
            steps {
                dir(FRONTEND_DIR) {
                    sh 'ng build --configuration production'
                }
            }
        }

        stage('Deploy Frontend') {
            steps {
                dir(FRONTEND_DIR) {
                    // Copier le build vers un serveur web (par ex., Nginx ou Apache)
                    sh '''
                    sudo mkdir -p /var/www/html/angular-app
                    cp -r dist/angular-ecommerce/* /var/www/html/angular-app/
                    '''
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline terminé.'
        }
        success {
            echo 'Déploiement réussi !'
        }
        failure {
            echo 'Échec du pipeline.'
        }
    }
}
