pipeline {
    agent any 

    environment {
        Registry = "docker.io"
        Image_name = "khalifi11/my-app" 
        K8s_namespace = "default"
    }

    stages {
        stage("Install kubectl") {
            steps {
                echo "Installing kubectl"
                script {
                    sh '''
                        curl -LO "https://dl.k8s.io/release/v1.24.6/bin/linux/amd64/kubectl"
                        chmod +x kubectl
                        mv kubectl /usr/local/bin/kubectl
                    '''
                }
            }
        }

        stage("Login to Docker Hub") {
            steps {
                echo "Logging in to Docker Hub"
                script {
                    withCredentials([usernamePassword(credentialsId: 'Cuenta_DockerHub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh "echo $DOCKER_PASS | docker login --username $DOCKER_USER --password-stdin"
                    }
                }
            }
        }

        stage("Build Docker Image") {
            steps {
                echo "Building Docker image from Dockerfile"
                script {
                    sh "docker build -t ${Registry}/${Image_name} ."
                }
            }
        }

        stage("Run Docker Container Locally") {
            steps {
                echo "Running Docker container"
                script {
                    sh "docker run -d -p 8080:80 ${Registry}/${Image_name}"
                }
            }
        }

        stage("Push to Docker Hub") {
            steps {
                echo "Pushing to Docker Hub"
                script {
                    sh "docker push ${Registry}/${Image_name}"
                }
            }
        }

        stage("Deploy to Kubernetes") {
            steps {
                echo "Deploying Docker image to Kubernetes"
                script {
                    sh "kubectl apply -f ./k8s-deployment.yaml"
                }
            }
        }

        stage("Verify Deployment") {
            steps {
                echo "Verifying deployment in Kubernetes"
                sh "kubectl get pods --namespace ${K8s_namespace}"
            }
        }
    }
}
