pipeline {
    agent any
    stages {
        stage('Building app') {
            steps {
                sshagent(['ba46ae8a-c439-465e-81b4-14d2d43ca568']) {
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.29.49'
                    //sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.29.49 git clone https://github.com/Strvsuri/hackathon-starter.git myproject'
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.29.49 cd myproject'
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.29.49 npm install'
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.29.49 node app.js'
                    //install dependencies & start app from CLI
                }
            }
        }
    }
}

/*pipeline {
    agent any
    stages {
        stage ('git checkout') {
            steps {
                git 'https://github.com/Strvsuri/hackathon-starter.git'
            }
        }
        stage ('IAC stage-main server') {
            steps {
                sshagent(['836dd61a-5f60-460f-ba5f-be6d96cfc880']) {
                    sh 'ssh -o StrictHostKeyChecking=no ansadmin@172.31.29.207'
                    sh 'scp *.tf ansadmin@172.31.29.207:/opt/terraform'
                    sh 'ssh -o StrictHostKeyChecking=no ansadmin@172.31.29.207 cd /opt/terraform'
                    sh 'terraform init' 
                    sh 'terraform apply'
                }           
            }
        }  

        stage ('installinmongodb,docker,compose') {
            steps {
                sshagent(['836dd61a-5f60-460f-ba5f-be6d96cfc880']) {
                    sh 'ssh -o StrictHostKeyChecking=no ansadmin@172.31.29.207'
                    sh 'scp *.sh ansadmin@172.31.29.207:/opt'
                    sh "ansible-playbook copy.yml"
                    sh "ansible-playbook installationplay.yml"                   
                }           
            }
        }

        stage ('Getting started & NPM dependency') {
            steps {
                sshagent(['7c6e1a46-5f81-42e5-91b2-4410b5a9e3d2']) {
                    sh 'ssh -o StrictHostKeyChecking=no user1@172.31.86.65'
                    sh 'ssh -o StrictHostKeyChecking=no user1@172.31.86.65 git clone https://github.com/Strvsuri/hackathon-starter.git myproject'
                    //install dependencies & start app from CLI
                }
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
            //in CLI, run ''usermod -aG docker ansadmin
            steps {
                sshagent(['7c6e1a46-5f81-42e5-91b2-4410b5a9e3d2']) {
                    sh 'ssh -o StrictHostKeyChecking=no ansadmin@172.31.29.207 cd /opt/docker'
                    sh 'ssh -o StrictHostKeyChecking=no ansadmin@172.31.29.207 docker-compose build -d web:v1.$BUILD_ID'
                    // maintaining version with jenkin parameters
                }                
            }
        }
        stage ('Trivy scanning') {
            //install TRIVY on the server
            steps {
                sshagent(['7c6e1a46-5f81-42e5-91b2-4410b5a9e3d2']) {
                    sh 'ssh -o StrictHostKeyChecking=no ansadmin@172.31.29.207 cd /opt'
                    sh 'ssh -o StrictHostKeyChecking=no ansadmin@172.31.29.207 trivy image web:v1.$BUILD_ID > scanning.txt'                
                }
            }    
            // Scan again and fail on HIGH,CRITICAL vulns
            sh 'trivy image --ignore-unfixed --vuln-type os,library --exit-code 1 --severity HIGH,CRITICAL '
        } 

        stage ('docker image tagging') {
            steps {
                sshagent(['7c6e1a46-5f81-42e5-91b2-4410b5a9e3d2']) {
                    sh 'ssh -o StrictHostKeyChecking=no ansadmin@172.31.29.207 cd /opt'
                    sh 'ssh -o StrictHostKeyChecking=no ansadmin@172.31.29.207 docker tag web:v1.$BUILD_ID web:v1.$BUILD_ID'
                    sh 'ssh -o StrictHostKeyChecking=no ansadmin@172.31.29.207 docker tag web:v1.$BUILD_ID:v1.latest'
                }
            }
        }

        stage ('Docker image push') {
            steps {
                sshagent(['7c6e1a46-5f81-42e5-91b2-4410b5a9e3d2']) {
                    //login to dockerhub before running this stage
                    withCredentials([string(credentialsId: '8ea8a127-e330-428e-956c-7f8163a459b7', variable: 'Dockerhub_pswd')]) {
                        sh "ssh -o StrictHostKeyChecking=no ansadmin@172.31.29.207 docker login -u suribau -p ${Dockerhub_pswd}"
                        sh 'ssh -o StrictHostKeyChecking=no ansadmin@172.31.29.207 docker image push suribau/$JOB_NAME:v1.$BUILD_ID'
                        sh 'ssh -o StrictHostKeyChecking=no ansadmin@172.31.29.207 docker image push suribau/$JOB_NAME:v1.latest'
                    }
                }
            }
        }
        stage ('K8s deployment') {
            steps {
                sshagent(['7c6e1a46-5f81-42e5-91b2-4410b5a9e3d2']) {
                    sh 'ssh -o StrictHostKeyChecking=no ansadmin@172.31.29.207 cd /opt'
                    sh 'ssh -o StrictHostKeyChecking=no ansadmin@172.31.29.207 ansible-playbook ansible.yml'
                }
            }
        }

    }
}*/
