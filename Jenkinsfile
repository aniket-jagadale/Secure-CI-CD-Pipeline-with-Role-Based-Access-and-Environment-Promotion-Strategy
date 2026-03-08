pipeline {
agent any

```
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
            sh 'echo Running sample tests'
        }
    }

    stage('Deploy to DEV') {
        steps {
            sshagent(['ubuntu']) {
                sh '''
                ssh -o StrictHostKeyChecking=no ubuntu@$DEV_SERVER "sudo apt update && sudo apt install apache2 -y && sudo systemctl start apache2"
                scp -o StrictHostKeyChecking=no build/index.html ubuntu@$DEV_SERVER:$APP_DIR
                '''
            }
        }
    }

    stage('Deploy to STAGING') {
        steps {
            sshagent(['ubuntu']) {
                sh '''
                ssh -o StrictHostKeyChecking=no ubuntu@$STAGING_SERVER "sudo apt update && sudo apt install apache2 -y && sudo systemctl start apache2"
                scp -o StrictHostKeyChecking=no build/index.html ubuntu@$STAGING_SERVER:$APP_DIR
                '''
            }
        }
    }

    stage('Production Approval') {
        steps {
            input message: "Approve deployment to PRODUCTION?", ok: "Deploy"
        }
    }

    stage('Deploy to PRODUCTION') {
        steps {
            sshagent(['ubuntu']) {
                sh '''
                ssh -o StrictHostKeyChecking=no ubuntu@$PROD_SERVER "sudo apt update && sudo apt install apache2 -y && sudo systemctl start apache2"
                scp -o StrictHostKeyChecking=no build/index.html ubuntu@$PROD_SERVER:$APP_DIR
                '''
            }
        }
    }

}
```

}
