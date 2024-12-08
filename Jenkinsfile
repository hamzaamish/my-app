pipeline {
    agent any

    environment {
        DOCKER_USERNAME = 'hamzaamish' // Your Docker Hub username
        DOCKER_PASSWORD = credentials('4e00837e-a6dd-4314-af9e-c64a29a1ac84') // Your Docker credentials ID
        GIT_CREDENTIALS_ID = '1fa18606-48c2-4009-a485-b7b4cdc419c5' // Your GitHub credentials ID
    }

    stages {
        stage('Clone Repository') {
            steps {
                script {
                    // Clone the repository with GitHub credentials
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
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
