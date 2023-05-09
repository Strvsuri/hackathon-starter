pipeline {
    agent any
    stages {
        stage ('git checkout') {
            steps {
                git 'https://github.com/Strvsuri/hackathon-starter.git'
            }
        }
        stage ('IAC stage-main server') {
            steps {
                sshagent(['ansTer']) {
                sh 'ssh -o StrictHostKeyChecking=no ansadmin@172.31.31.42'
                sh 'scp ./Dockerfile ansadmin@172.31.31.42:/opt'
                }            
            }
        }
        
    }
}
