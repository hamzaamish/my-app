pipeline {
    agent any

    environment {
        DOCKER_USERNAME = 'hamzaamish' // Your Docker Hub username
        DOCKER_PASSWORD = credentials('docker-credentials') // Your Jenkins credentials ID for Docker
        GIT_CREDENTIALS_ID = 'github-credentials' // Your Jenkins credentials ID for GitHub
    }

    stages {
        stage('Clone Repository') {
            steps {
                script {
                    // Clone the repository with credentials
                    withCredentials([usernamePassword(credentialsId: GIT_CREDENTIALS_ID, usernameVariable: 'GIT_USERNAME', passwordVariable: 'GIT_PASSWORD')]) {
                        sh 'git clone https://$GIT_USERNAME:$GIT_PASSWORD@github.com/hamzaamish/my-app.git'
                        dir('my-app') {
                            // List the contents of the workspace for debugging
                            sh 'ls -la'
                        }
                    }
                }
            }
        }
        stage('Build') {
            steps {
                script {
                    dir('my-app') {
                        // Build the Docker image
                        sh 'docker build -t hamzaamish/my-app:latest .'
                    }
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    // Log in to Docker Hub
                    sh "echo '${DOCKER_PASSWORD}' | docker login -u '${DOCKER_USERNAME}' --password-stdin"
                    // Push the Docker image to Docker Hub
                    sh 'docker push hamzaamish/my-app:latest'
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    dir('my-app') {
                        // Deploy the application to Kubernetes
                        sh 'kubectl apply -f deployment.yml'
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!' // Ensure this line is correctly formatted
        }
        failure {
            echo 'Pipeline failed!' // Ensure this line is correctly formatted
        }
    }
}
