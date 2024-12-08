pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'hamzaamish/my-app:latest'
    }

    stages {
        stage('Checkout Code') {
            steps {
                script {
                    // Explicitly specify the branch name to checkout
                    git url: 'https://github.com/hamzaamish/my-app.git',
                        branch: 'main',
                        credentialsId: '1fa18606-48c2-4009-a485-b7b4cdc419c5'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh "docker build -t ${DOCKER_IMAGE} ."
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                script {
                    // Log in securely to Docker Hub
                    withCredentials([usernamePassword(credentialsId: '4e00837e-a6dd-4314-af9e-c64a29a1ac84', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Push the image to Docker Hub
                    sh "docker push ${DOCKER_IMAGE}"
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Ensure `kubectl` can interact with your cluster
                    sh "kubectl apply -f k8s/deployment.yaml"
                    sh "kubectl apply -f k8s/service.yaml"
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Please review logs.'
        }
    }
}

