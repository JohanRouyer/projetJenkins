pipeline {
    agent any

    environment {
        FRONTEND_DIR = '03-frontend/angular-ecommerce'
        BACKEND_DIR = '02-backend/spring-boot-restapi'
    }

    stages {
        stage('Checkout SCM') {
            steps {
                git url: 'https://github.com/NesiCodes/Fullstack-Ecommerce-Web.git', branch: 'main'
            }
        }

        stage('Verify Files') {
            steps {
                dir(BACKEND_DIR) {
                    sh 'ls -la'  // Affiche le contenu du répertoire pour vérifier que pom.xml est présent
                }
            }
        }

        stage('Install Backend Dependencies') {
            steps {
                dir(BACKEND_DIR) {
                    sh 'mvn clean install'
                }
            }
        }

        stage('Build Backend') {
            steps {
                dir(BACKEND_DIR) {
                    sh 'mvn spring-boot:run'
                }
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
                    sh 'ng build --prod'
                }
            }
        }

        stage('Run Tests') {
            parallel {
                stage('Backend Tests') {
                    steps {
                        dir(BACKEND_DIR) {
                            sh 'mvn test'
                        }
                    }
                }
                stage('Frontend Tests') {
                    steps {
                        dir(FRONTEND_DIR) {
                            sh 'ng test --watch=false'
                        }
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                echo 'Déploiement de l\'application sur le serveur de staging...'
            }
        }
    }

    post {
        success {
            echo 'Build et tests réussis!'
        }
        failure {
            echo 'Le build ou les tests ont échoué.'
        }
    }
}
