pipeline {
    agent any
    tools {
        nodejs 'node-10.19.0'
    }
    stages {
        stage('Building app') {
             agent {
                docker {
                    image 'node:10-stretch'
                }
            }
            steps {
                sshagent(['nodeapp']) {
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.95.196'
                    //sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.95.196 git clone https://github.com/Strvsuri/hackathon-starter.git myproject'
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.95.196 cd myproject && npm install'
                    //sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.95.196 node app.js'
                    //install dependencies & start app from CLI
                }
            }
        }
    }
}
