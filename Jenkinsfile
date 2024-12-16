pipeline {
    agent any

    environment {
        // Variables pour les commandes
        FRONTEND_DIR = '03-frontend/angular-ecommerce'
        BACKEND_DIR = '02-backend/spring-boot-restapi'
    }

    stages {
        stage('Clone') {
            steps {
                // Cloner le dépôt
                git 'https://github.com/NesiCodes/Fullstack-Ecommerce-Web.git'
            }
        }

        stage('Install Backend Dependencies') {
            steps {
                // Aller dans le répertoire du backend et installer les dépendances Maven
                dir(BACKEND_DIR) {
                    sh 'mvn clean install'
                }
            }
        }

        stage('Build Backend') {
            steps {
                // Compiler l'application Spring Boot
                dir(BACKEND_DIR) {
                    sh 'mvn spring-boot:run'
                }
            }
        }

        stage('Install Frontend Dependencies') {
            steps {
                // Aller dans le répertoire du frontend et installer les dépendances Node
                dir(FRONTEND_DIR) {
                    sh 'npm install'
                }
            }
        }

        stage('Build Frontend') {
            steps {
                // Compiler l'application Angular
                dir(FRONTEND_DIR) {
                    sh 'ng build --prod'
                }
            }
        }

        stage('Run Tests') {
            parallel {
                stage('Backend Tests') {
                    steps {
                        // Tester le backend avec Maven
                        dir(BACKEND_DIR) {
                            sh 'mvn test'
                        }
                    }
                }
                stage('Frontend Tests') {
                    steps {
                        // Tester le frontend avec Angular
                        dir(FRONTEND_DIR) {
                            sh 'ng test --watch=false'
                        }
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                // Déploiement de l'application
                echo 'Déploiement de l\'application sur le serveur de staging...'
                // Par exemple, copier les fichiers de build vers le serveur de production/staging
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
