pipeline{
    agent any 
    environment{
        Registry = "docker.io"
        Image_name = "my-app"
        K8s_namespace= "default"
    }
    stages {
        stage("Build docker image ") {
            steps{
                echo "Building docker image from dockerfile"
                script{
                    sh "docker build -t $Registry/$Image_name . "
                }  
            }
            
        }
        stage("Run Docker Container locally"){
            steps{
                echo "Running docker container"
                script{
                    sh "docker run -d -p 8080:80 $Registry/$Image_name"
                }
            }
        }
        stage("Push to Docker hub"){
            steps{
                echo "Pushing to docker hub"
                script{
                    sh "docker push $Registry/$Image_name"
                }
            }
        }    
        stage("Deploy to Kubernetes"){
            steps{
                echo "Deploying Dokcer image"
                script{
                    sh " kubectl apply -f ./k8s-deployment.yaml"
                }
            }
        }
        stage("Verify Deployment"){
            steps{
                sh "kubectl get pods --namespace $K8s_namespace"
            }
        }
    }
}
