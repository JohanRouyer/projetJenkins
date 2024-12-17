pipeline {
    agent {
        node {
            label 'node1'
        }
    }
    environment {
        BACKEND_DIR = '02-backend/spring-boot-restapi'
        FRONTEND_DIR = '03-frontend/angular-ecommerce'
    }

    stages {
        stage('Prepare Workspace') {
            steps {
                // Utilisation d'un répertoire de travail spécifique
                dir('/tmp/jenkins_workspace') {
                    deleteDir()  // Clean workspace before cloning
                    sh 'git config --global http.postBuffer 524288000'
                }
            }
        }

    stages {
        stage('Prepare Workspace') {
            steps {
                // Clean workspace before cloning
                deleteDir()
                sh 'git config --global http.postBuffer 524288000'
            }
        }

        stage('Checkout SCM') {
            steps {
                script {
                    retry(3) { // Try cloning up to 3 times in case of failure
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
                    sh 'nohup java -jar target/*.jar & echo $! > backend_pid.txt'
                }
            }
        }

        stage('Install Angular CLI') {
            steps {
                sh 'npm install -g @angular/cli'
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
                    // Run HTTP server in background
                    sh '''
                    sudo npm install -g http-server
                    http-server dist/angular-ecommerce -p 8080 &
                    echo $! > http_server_pid.txt
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
