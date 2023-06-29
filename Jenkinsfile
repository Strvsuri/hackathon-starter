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
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.95.196 cd /home/ubuntu/myproject && npm install && node app.js || true'
                    //sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.95.196 cd /home/ubuntu/myproject && node app.js'   
                }
            }
        }

        stage ('docker image build') {
            //in CLI, run ''usermod -aG docker ansadmin
            steps {
                sshagent(['nodeapp']) {
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.95.196'
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.95.196 cd /home/ubuntu/myproject && docker ps'
                    //sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.95.196 cd /home/ubuntu/myproject && docker-compose build web:v1.$BUILD_ID'
                    // maintaining version with jenkin parameters
                }                
            }
        }
    }
}
