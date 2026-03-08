pipeline {
    agent any

    environment {
        DEV_SERVER = "18.212.81.157"
        STAGING_SERVER = "98.81.243.170"
        PROD_SERVER = "34.234.76.189"

        SSH_USER = "ubuntu"
    }

    stages {

        stage('Clone Repository') {
            steps {
                git 'https://github.com/aniket-jagadale/Secure-CI-CD-Pipeline-with-Role-Based-Access-and-Environment-Promotion-Strategy.git'
            }
        }

        stage('Build') {
            steps {
                sh '''
                echo "Building application"
                mkdir -p build
                cp index.html build/
                '''
            }
        }

        stage('Unit Test') {
            steps {
                sh '''
                echo "Running sample tests"
                '''
            }
        }

        stage('Deploy to DEV') {
            steps {
                sshagent(['ubuntu']) {
                    sh """
                    ssh -o StrictHostKeyChecking=no $SSH_USER@$DEV_SERVER "sudo apt update && sudo apt install apache2 -y && sudo systemctl start apache2"

                    scp -o StrictHostKeyChecking=no build/index.html $SSH_USER@$DEV_SERVER:/home/ubuntu/index.html

                    ssh $SSH_USER@$DEV_SERVER "sudo mv /home/ubuntu/index.html /var/www/html/index.html"
                    """
                }
            }
        }

        stage('Deploy to STAGING') {
            steps {
                sshagent(['ubuntu']) {
                    sh """
                    ssh -o StrictHostKeyChecking=no $SSH_USER@$STAGING_SERVER "sudo apt update && sudo apt install apache2 -y && sudo systemctl start apache2"

                    scp -o StrictHostKeyChecking=no build/index.html $SSH_USER@$STAGING_SERVER:/home/ubuntu/index.html

                    ssh $SSH_USER@$STAGING_SERVER "sudo mv /home/ubuntu/index.html /var/www/html/index.html"
                    """
                }
            }
        }

        stage('Production Approval') {
            steps {
                input message: "Approve Production Deployment?", ok: "Deploy"
            }
        }

        stage('Deploy to PRODUCTION') {
            steps {
                sshagent(['ubuntu']) {
                    sh """
                    ssh -o StrictHostKeyChecking=no $SSH_USER@$PROD_SERVER "sudo apt update && sudo apt install apache2 -y && sudo systemctl start apache2"

                    scp -o StrictHostKeyChecking=no build/index.html $SSH_USER@$PROD_SERVER:/home/ubuntu/index.html

                    ssh $SSH_USER@$PROD_SERVER "sudo mv /home/ubuntu/index.html /var/www/html/index.html"
                    """
                }
            }
        }
    }
}
