pipeline {
    agent any

    environment {
        DEV_SERVER = "18.212.81.157"
        STAGING_SERVER = "98.81.243.170"
        PROD_SERVER = "34.234.76.189"
        APP_DIR = "/var/www/html"
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
                sh 'echo "Running sample tests"'
            }
        }

        stage('Deploy to DEV') {
            steps {
                sshagent(['ec2-key']) {
                    sh '''
                    ssh -o StrictHostKeyChecking=no ec2-user@$DEV_SERVER 'sudo yum install httpd -y'
                    ssh ec2-user@$DEV_SERVER 'sudo systemctl start httpd'
                    scp build/index.html ec2-user@$DEV_SERVER:$APP_DIR
                    '''
                }
            }
        }

        stage('Deploy to STAGING') {
            steps {
                sshagent(['ec2-key']) {
                    sh '''
                    ssh -o StrictHostKeyChecking=no ec2-user@$STAGING_SERVER 'sudo yum install httpd -y'
                    ssh ec2-user@$STAGING_SERVER 'sudo systemctl start httpd'
                    scp build/index.html ec2-user@$STAGING_SERVER:$APP_DIR
                    '''
                }
            }
        }

        stage('Production Approval') {
            steps {
                timeout(time: 1, unit: 'HOURS') {
                    input message: 'Approve deployment to PRODUCTION?', ok: 'Deploy Now'
                }
            }
        }

        stage('Deploy to PRODUCTION') {
            steps {
                sshagent(['ec2-key']) {
                    sh '''
                    ssh -o StrictHostKeyChecking=no ec2-user@$PROD_SERVER 'sudo yum install httpd -y'
                    ssh ec2-user@$PROD_SERVER 'sudo systemctl start httpd'
                    scp build/index.html ec2-user@$PROD_SERVER:$APP_DIR
                    '''
                }
            }
        }
    }
}
