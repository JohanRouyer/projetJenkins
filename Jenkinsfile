pipeline {
    agent any

    environment {
        BACKEND_DIR = '02-backend/spring-boot-restapi'
    }

    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }

        stage('Clean Workspace') {
            steps {
                deleteDir()
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
                    sh './mvnw clean install'
                }
            }
        }

        stage('Build Project') {
            steps {
                dir(BACKEND_DIR) {
                    sh './mvnw package'
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
