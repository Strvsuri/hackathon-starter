pipeline {

    agent any   

    tools { nodejs "nodejs" }


    stages {
        stage ('gitcheckout') {
            steps {
                git 'https://github.com/Strvsuri/hackathon-starter.git'
            }
        }
        
        stage('Building app') {
            steps {
                sshagent(['nodeapp']) {
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.95.196'                    
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.95.196 cd /home/ubuntu/myproject && npm install && node app.js'
                    //sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.95.196 cd /home/ubuntu/myproject && node app.js'   
                }
            }
        }
    }
}
