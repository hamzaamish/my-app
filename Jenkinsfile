pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'hamzaamish/my-app:latest'
    }

    stages {
        stage('Checkout SCM') {
            steps {
                script { 
                    git url: 'https://github.com/hamzaamish/my-app.git', credentialsId: 'your-git-credentials-id' // Replace with your actual Git credentials ID
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    // Build the Docker image
                    sh "docker build -t ${DOCKER_IMAGE} ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    // Login to Docker Hub using credentials
                    withCredentials([usernamePassword(credentialsId: '4e00837e-a6dd-4314-af9e-c64a29a1ac84', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
                        sh "docker push ${DOCKER_IMAGE}"
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    sh 'kubectl apply -f deployment.yml'
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

