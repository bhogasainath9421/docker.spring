pipeline {
    agent any

    environment {
        AWS_ACCOUNT_ID = '125840291232'
        AWS_REGION     = 'ap-south-2'
        ECR_REPO_NAME  = 'docker/spring'
        IMAGE_TAG      = "v${BUILD_NUMBER}"
        ECR_REGISTRY   = "125840291232.dkr.ecr.ap-south-2.amazonaws.com"
        IMAGE_NAME     = "${ECR_REGISTRY}/${ECR_REPO_NAME}:${IMAGE_TAG}"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main',
                    credentialsId: 'github_credentials',
                    url: 'https://github.com/bhogasainath9421/docker.spring.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${IMAGE_NAME} .'
            }
        }

        stage('Push to AWS ECR') {
            steps {
                sh '''
                    docker push ${IMAGE_NAME}
                '''
            }
        }
    }

    post {
        always {
            sh 'docker rmi ${IMAGE_NAME} || true'
            cleanWs()
        }

        success {
            echo "Successfully built and pushed image: ${IMAGE_NAME}"
        }

        failure {
            echo "Pipeline failed. Check the logs for errors."
        }
    }
}
