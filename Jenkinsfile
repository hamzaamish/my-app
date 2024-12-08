pipeline {
    agent any

    environment {
        DOCKER_USERNAME = 'hamzaamish' // Your Docker Hub username
        DOCKER_PASSWORD = credentials('6faa9304-29cd-4ce1-9838-40aa3a77623e') // Your Jenkins credentials ID
    }

    stages {
        stage('Clone Repository') {
            steps {
                script {
                    // Clone the repository manually
                    sh 'git clone https://github.com/username/my-app.git' // Replace with your repository URL
                    dir('my-app') {
                        // List the contents of the workspace for debugging
                        sh 'ls -la'
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
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
