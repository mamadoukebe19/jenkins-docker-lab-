pipeline {
    agent any  // Jenkins peut utiliser n'importe quel agent

    environment {
        DOCKERHUB_USER = "mamakebe027"          // 🔴 MUST match Docker Hub account
        IMAGE_NAME     = "jenkins-ci-app"
        IMAGE_TAG      = "v1.${BUILD_NUMBER}"
    }

    stages {

        stage('Build Docker Image') {
            steps {
                echo "Construction de l'image Docker"
                sh '''
                  docker build \
                  -t ${DOCKERHUB_USER}/${IMAGE_NAME}:latest .
                '''
            }
        }

        stage('Tag Docker Image') {
            steps {
                echo "Tag de l'image avec un numéro de build"
                sh '''
                  docker tag \
                  ${DOCKERHUB_USER}/${IMAGE_NAME}:latest \
                  ${DOCKERHUB_USER}/${IMAGE_NAME}:${IMAGE_TAG}
                '''
            }
        }

        stage('Login Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                      echo "$DOCKER_PASS" | docker login \
                      -u "$DOCKER_USER" --password-stdin
                    '''
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                echo "Push de l'image vers Docker Hub"
                sh '''
                  docker push ${DOCKERHUB_USER}/${IMAGE_NAME}:latest
                  docker push ${DOCKERHUB_USER}/${IMAGE_NAME}:${IMAGE_TAG}
                '''
            }
        }
    }
}
