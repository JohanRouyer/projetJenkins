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
                git 'https://github.com/JohanRouyer/projetJenkins.git'
            }
        }

        stage('Verify Files') {
            steps {
                // Vérification des fichiers dans le répertoire backend
                dir(BACKEND_DIR) {
                    sh 'ls -la'  // Affiche le contenu du répertoire pour vérifier que pom.xml est bien là
                }
            }
        }

        stage('Install Backend Dependencies') {
            steps {
                // Aller dans le répertoire du backend et installer les dépendances Maven
                dir(BACKEND_DIR) {
                    sh 'mvn -version'  // Vérifie la version de Maven pour s'assurer que Maven est bien installé
                    sh 'mvn clean install'  // Exécute l'installation des dépendances Maven
                }
            }
        }

        stage('Build Backend') {
            steps {
                // Compiler l'application Spring Boot
                dir(BACKEND_DIR) {
                    sh 'mvn spring-boot:run'  // Démarre l'application Spring Boot
                }
            }
        }

        stage('Install Frontend Dependencies') {
            steps {
                // Aller dans le répertoire du frontend et installer les dépendances Node
                dir(FRONTEND_DIR) {
                    sh 'npm install'  // Installe les dépendances Node
                }
            }
        }

        stage('Build Frontend') {
            steps {
                // Compiler l'application Angular
                dir(FRONTEND_DIR) {
                    sh 'ng build --prod'  // Compile le frontend Angular pour la production
                }
            }
        }

        stage('Run Tests') {
            parallel {
                stage('Backend Tests') {
                    steps {
                        // Tester le backend avec Maven
                        dir(BACKEND_DIR) {
                            sh 'mvn test'  // Lance les tests pour le backend
                        }
                    }
                }
                stage('Frontend Tests') {
                    steps {
                        // Tester le frontend avec Angular
                        dir(FRONTEND_DIR) {
                            sh 'ng test --watch=false'  // Lance les tests pour le frontend
                        }
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                // Déploiement de l'application
                echo 'Déploiement de l\'application sur le serveur de staging...'
                // Exemple : copier les fichiers de build vers le serveur de production/staging
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
