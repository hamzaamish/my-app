pipeline {
    agent any

    environment {
        KUBECONFIG = '/home/hamza-amish/.kube/config'// Update this path if necessary
    }

    stages {
        stage('Checkout SCM') {
            steps {
                // Checkout code from Git
                git url: 'https://github.com/hamzaamish/my-app.git', branch: 'main', credentialsId: 'your-git-credentials-id' // Update with actual credentials ID
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh 'docker build -t hamzaamish/my-app:latest .'
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                script {
                    // Login to Docker Hub using credentials
                    withCredentials([usernamePassword(credentialsId: '4e00837e-a6dd-4314-af9e-c64a29a1ac84', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh "echo \$DOCKER_PASSWORD | docker login -u \$DOCKER_USERNAME --password-stdin"
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Push the Docker image to Docker Hub
                    sh 'docker push hamzaamish/my-app:latest'
                }
            }
        }

        stage('Test Kubernetes Connection') {
            steps {
                script {
                    // Test connection to Kubernetes
                    sh 'kubectl get nodes'
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Deploy to Kubernetes
                    sh 'kubectl apply -f k8s/deployment.yaml --validate=false'
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
