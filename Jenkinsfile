pipeline {
    agent any
    stages {
        stage ('git checkout') {
            steps {
                git 'https://github.com/Strvsuri/hackathon-starter.git'
            }
        }
        /*stage ('IAC stage-main server') {
            steps {
                // spinning up main node server            
            }
        }
        stage ('Preparing server & building app') {
            steps {
                // installing 1. mongo 2. node & npm 
                //docker & docker-compose
            }
        }
        stage ('Sonarqube analysis') {
            steps {
                //install Sonarqube scaner plugin in jenkins UI before creating this stage
            }
        }
        stage('Sonarqube Analysis') {
            steps {
                nodejs(nodeJSInstallationName: 'nodejs') {
                    sh "npm install"                 //in Global tool install nodejs after plugin nodejs installation
                    withsonarQubeEnv('sonar') {      //same name as in jenkins configuration: sonar 
                        sh "npm install sonar-scanner"
                        sh "npm run sonar"
                    }
                }
            }
        }  
        stage ('docker image build') {
            steps {
                // docker-compose build
                // pushing image to docker hub 
            }
        }
        stage ('Trivy scanning') {
            steps {
                sh "trivy image image_name > scanning.txt"
            }
            // Scan again and fail on CRITICAL vulns
            sh 'trivy image --ignore-unfixed --vuln-type os,library --exit-code 1 --severity HIGH,CRITICAL image_name'
        } */
    }
}
