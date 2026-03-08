pipeline {
    agent any

    environment {

        DEV_SERVER = "ec2-user@DEV_IP"##
        STAGING_SERVER = "ec2-user@STAGING_IP"##
        PROD_SERVER = "ec2-user@PROD_IP"##

        APP_DIR = "/var/www/html"
    }

    stages {

        stage('Clone Repository') {
            steps {
                git 'https://github.com/aniket-jagadale/Secure-CI-CD-Pipeline-with-Role-Based-Access-and-Environment-Promotion-Strategy.git'##
            }
        }

        stage('Build') {
            steps {
                sh '''
                echo "Building application"
                mkdir build
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
                sh """
                ssh -o StrictHostKeyChecking=no $DEV_SERVER 'sudo yum install httpd -y'
                ssh $DEV_SERVER 'sudo systemctl start httpd'
                scp build/index.html $DEV_SERVER:$APP_DIR
                """
            }
        }

        stage('Deploy to STAGING') {
            steps {
                sh """
                ssh -o StrictHostKeyChecking=no $STAGING_SERVER 'sudo yum install httpd -y'
                ssh $STAGING_SERVER 'sudo systemctl start httpd'
                scp build/index.html $STAGING_SERVER:$APP_DIR
                """
            }
        }

        stage('Approval Required') {
            steps {
                input "Approve Production Deployment?"
            }
        }

        stage('Deploy to PRODUCTION') {
            steps {
                sh """
                ssh -o StrictHostKeyChecking=no $PROD_SERVER 'sudo yum install httpd -y'
                ssh $PROD_SERVER 'sudo systemctl start httpd'
                scp build/index.html $PROD_SERVER:$APP_DIR
                """
            }
        }
    }
}