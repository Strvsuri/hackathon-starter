pipeline {
    agent any    
    stages {
        stage('Building app') {
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
