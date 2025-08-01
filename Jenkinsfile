pipeline {
    agent any

    environment {
        IMAGE_NAME = "banking-app-local"
        IMAGE_TAG = "latest"
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

     

        stage('SonarQube Analysis with Token') {
            environment {
                SONAR_HOST_URL = 'https://sonarqube-v10-hasnahatti70-dev.apps.rm2.thpm.p1.openshiftapps.com/' // ← à remplacer par ton URL réelle sur OpenShift
            }
            steps {
                withCredentials([string(credentialsId: 'banking-app', variable: 'SONAR_TOKEN')]) {
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
