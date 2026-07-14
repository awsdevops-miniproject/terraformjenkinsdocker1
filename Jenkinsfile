pipeline {

    agent any

    environment {
        DOCKER_IMAGE = 'iron30/terradockerjen:v1'
    }

    stages {

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE ./webapp'
            }
        }

        stage('Login to Docker Hub') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-credentials',
                        usernameVariable: 'DOCKER_USERNAME',
                        passwordVariable: 'DOCKER_PASSWORD'
                    )
                ]) {
                    sh '''
                        echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
                    '''
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                sh 'docker push $DOCKER_IMAGE'
            }
        }

        stage('Stop Old Container') {
            steps {
                sh 'docker stop terradockerjen-container || true'
            }
        }

        stage('Remove Old Container') {
            steps {
                sh 'docker rm terradockerjen-container || true'
            }
        }

        stage('Run New Container') {
            steps {
                sh 'docker run -d --name terradockerjen-container -p 80:80 $DOCKER_IMAGE'
            }
        }
    }
}