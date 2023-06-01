pipeline {

    agent any    

    stages {

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


        stage('Building app') {
            steps {
                sshagent(['nodeapp']) {
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.95.196'                    
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.95.196 cd myproject && npm install'
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.95.196 cd myproject && node app.js'   
                }
            }
        }
 

        stage ('docker image build') {
            //in CLI, run ''usermod -aG docker ansadmin
            steps {
                sshagent(['nodeapp']) {
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.95.196'
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.95.196 cd myproject && docker-compose build -d web:v1.$BUILD_ID'
                    // maintaining version with jenkin parameters
                }                
            }
        }     


        stage ('docker image tagging') {
            steps {
                sshagent(['nodeapp']) {
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.95.196'                
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.95.196 docker tag web:v1.$BUILD_ID suribau/web:v1.$BUILD_ID'
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.95.196 docker tag suribau/web:v1.$BUILD_ID suribau/web:v1.latest '
                }
            }
        }


        stage ('Docker image push') {
            steps {
                sshagent(['nodeapp']) {
                    //login to dockerhub before running this stage
                    withCredentials([string(credentialsId: '8ea8a127-e330-428e-956c-7f8163a459b7', variable: 'Dockerhub_pswd')]) {
                        sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.95.196 docker login -u suribau -p ${Dockerhub_pswd}"
                        sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.95.196 docker image push suribau/$JOB_NAME:v1.$BUILD_ID'
                        sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.95.196 docker image push suribau/$JOB_NAME:v1.latest'
                    }
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


        stage ('Trivy scanning') {
            //install TRIVY on the server
            steps {
                sshagent(['nodeapp']) {
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.95.196'
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.95.196 trivy image web:v1.$BUILD_ID > scanning.txt'                
                }
            }    
            // Scan again and fail on HIGH,CRITICAL vulns
            sh 'trivy image --ignore-unfixed --vuln-type os,library --exit-code 1 --severity HIGH,CRITICAL '
        }


        stage ('K8s-AWS EKS deployment') {
            steps {
                sshagent(['7c6e1a46-5f81-42e5-91b2-4410b5a9e3d2']) {     //if client is chabged script must be changed
                    sh 'ssh -o StrictHostKeyChecking=no ansadmin@172.31.29.207 cd /opt'
                    sh 'ssh -o StrictHostKeyChecking=no ansadmin@172.31.29.207 ansible-playbook ansible.yml'
                }
            }
        } 
    }
}
