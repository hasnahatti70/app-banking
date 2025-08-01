pipeline {
    agent any

    environment {
        SONAR_HOST_URL = 'https://sonarqube-v10-hasnahatti70-dev.apps.rm2.thpm.p1.openshiftapps.com'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Analyse SonarQube') {
            steps {
                withCredentials([string(credentialsId: 'banking-app', variable: 'SONAR_TOKEN')]) {
                    sh '''
                        sonar-scanner \
                          -Dsonar.projectKey=banking-app \
                          -Dsonar.projectName=banking-app \
                          -Dsonar.sources=. \
                          -Dsonar.language=php \
                          -Dsonar.sourceEncoding=UTF-8 \
                          -Dsonar.host.url=${SONAR_HOST_URL} \
                          -Dsonar.login=${SONAR_TOKEN}
                    '''
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
