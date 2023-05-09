pipeline {
    agent any
    stages {
        stage ('git checkout') {
            steps {
                git 'https://github.com/Strvsuri/hackathon-starter.git'
            }
        }
        stage {
            when {
                branch 'master';
            }
            steps {
               sh """
               echo "build on master"
               """
            }
        }
