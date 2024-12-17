pipeline {
    agent any

    environment {
        BACKEND_DIR = '02-backend/spring-boot-restapi'
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

        stage('Verify Files') {
            steps {
                dir(BACKEND_DIR) {
                    sh 'ls -la'
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                dir(BACKEND_DIR) {
                    sh './mvnw clean install -DskipTests'
                }
            }
        }

        stage('Build Project') {
            steps {
                dir(BACKEND_DIR) {
                    sh './mvnw package -DskipTests'
                }
            }
        }

        stage('Run Tests') {
            steps {
                dir(BACKEND_DIR) {
                    sh './mvnw test'
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline terminé.'
        }
        success {
            echo 'Build réussi !'
        }
        failure {
            echo 'Échec du pipeline.'
        }
    }
}
