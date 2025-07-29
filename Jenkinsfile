pipeline {
    agent any

    environment {
        IMAGE_NAME = "banking-app-local"
        IMAGE_TAG = "latest"
    }

    tools {
        maven 'Maven_3.8.1'
        jdk 'jdk-17'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean compile'
            }
        }

        stage('Run Unit Tests') {
            steps {
                sh 'mvn test'
            }
        }

        stage('SonarQube Analysis with Token') {
            environment {
                SONAR_HOST_URL = 'http://<SONARQUBE_URL>' // ← à remplacer par ton URL réelle sur OpenShift
            }
            steps {
                withCredentials([string(credentialsId: 'sonarqube-token', variable: 'SONAR_TOKEN')]) {
                    sh '''
                        mvn sonar:sonar \
                          -Dsonar.projectKey=banking-app \
                          -Dsonar.projectName=banking-app \
                          -Dsonar.host.url=${SONAR_HOST_URL} \
                          -Dsonar.login=${SONAR_TOKEN}
                    '''
                }
            }
        }

        stage('Build & Run Docker Container') {
            steps {
                sh """
                    docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
                    docker run -d -p 8080:8080 --name banking-app ${IMAGE_NAME}:${IMAGE_TAG}
                """
            }
        }
    }

    post {
        always {
            sh '''
                docker stop banking-app || true
                docker rm banking-app || true
                docker rmi ${IMAGE_NAME}:${IMAGE_TAG} || true
            '''
            cleanWs()
        }
    }
}
