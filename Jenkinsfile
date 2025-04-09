pipeline {
    agent any 

    environment {
        Registry = "docker.io"
        Image_name = "khalifi11/my-app" 
        K8s_namespace = "default"
        Helm_chart = "my-app-chart"  // Especifica el nombre de tu chart de Helm
    }

    stages {
        stage("Install kubectl and Helm") {
            steps {
                echo "Installing kubectl and Helm"
                script {
                    sh '''
                        # Install kubectl
                        curl -LO "https://dl.k8s.io/release/v1.24.6/bin/linux/amd64/kubectl"
                        chmod +x kubectl
                        mv kubectl /usr/local/bin/kubectl

                        # Install Helm
                        curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
                    '''
                }
            }
        }

        stage("Login to Docker Hub") {
            steps {
                echo "Logging in to Docker Hub"
                script {
                    withCredentials([usernamePassword(credentialsId: 'Cuenta_DokcerHub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
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

        stage("Deploy to Kubernetes using Helm") {
            steps {
                echo "Deploying Docker image to Kubernetes with Helm"
                script {
                    // Aquí aseguramos que el chart de Helm tenga la imagen correcta.
                    // Si tienes un chart con un archivo `values.yaml`, puedes modificar ese archivo o usar la opción `--set` para sobrescribir el valor.

                    sh """
                        helm upgrade --install ${Helm_chart} ./charts/${Helm_chart} \
                        --namespace ${K8s_namespace} \
                        --set image.repository=${Registry}/${Image_name} \
                        --set image.tag=latest
                    """
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
