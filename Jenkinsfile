pipeline {
    agent any
    stages {
        stage('Building app') {
            steps {
                sshagent(['nodeapp']) {
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.95.196'                    
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.95.196 cd myproject && ls'                    
                }
            }
        }
    }
}
