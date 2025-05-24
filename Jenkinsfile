pipeline {

      agent {
               application
            }
    environment {
     ecr_repo_url= download from s3
     ecr_repo_name=env.ecr_repo_url.split('/').last() # will take it from repo-url
     imageExists = sh (returnStatus: true, script: "aws ecr describe-images --repository $ecr_repo_name --image-ids imageTag=$GIT_COMMIT")
   }

    stage('buildImage') {
            steps {
                script {
                    if ("$imageExists" == '0') {
                        sh "echo Image is there"
                    } else {
                        sh 'mvn clean install'
                        sh 'sudo docker build  -t reactcontainer'
                }
            }
        }
    stage('pushImageECRRepo') {
            steps {
                script {
                    if ("$imageExists" == '0') {
                        sh "echo `Image is already available on ECR`"
                    }  else {
                        sh 'sudo aws ecr get-login-password --region region | sudo docker login --username AWS --account-id-path'
                        sh "sudo docker push reactcontainer"
                    }
                }
            }
        }
    }
