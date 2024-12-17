pipeline {
    agent any

    environment {
        // Définir les variables nécessaires ici
        BACKEND_DIR = '02-backend/spring-boot-restapi'
    }

    stages {
        stage('Clean Workspace') {
            steps {
                // Nettoie l'espace de travail Jenkins pour éviter des conflits
                deleteDir()
            }
        }

        stage('Clone Repository') {
            steps {
                // Clone le dépôt Git
                git 'https://github.com/JohanRouyer/projetJenkins.git'
            }
        }

        stage('Verify Files') {
            steps {
                dir(BACKEND_DIR) {
                    // Vérifie que le fichier pom.xml est présent
                    sh 'pwd'
                    sh 'ls -la'
                }
            }
        }

        stage('Install Backend Dependencies') {
            steps {
                dir(BACKEND_DIR) {
                    // Vérifie la version de Maven
                    sh './mvnw -version'

                    // Installe les dépendances Maven
                    sh './mvnw clean install'
                }
            }
        }

        stage('Build Backend') {
            steps {
                dir(BACKEND_DIR) {
                    // Compile le backend
                    sh './mvnw package'
                }
            }
        }

        stage('Run Tests') {
            steps {
                dir(BACKEND_DIR) {
                    // Lance les tests unitaires
                    sh './mvnw test'
                }
            }
        }
    }

    post {
        always {
            // Exécute cette étape quel que soit le statut
            echo 'Pipeline terminé.'
        }
        success {
            // Étapes en cas de succès
            echo 'Build réussi !'
        }
        failure {
            // Étapes en cas d'échec
            echo 'Échec du pipeline.'
        }
    }
}
