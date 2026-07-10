pipeline {

    agent any

    stages {

        stage('Build Docker Image') {

            steps {

                sh 'docker build -t terradockerjen:v1 ./webapp'

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

                sh 'docker run -d --name terradockerjen-container -p 80:80 terradockerjen:v1'

            }
        }

    }
}