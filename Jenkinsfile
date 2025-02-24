pipeline {
  environment {
    registry = "pedromasa/webapp"
    registryCredential = 'dockerhub'
    dockerImage = ''
    GIT_REPO_NAME = "jenkins-gitops-k8s"
    GIT_USER_NAME = "pmasa"
    GIT_USER_EMAIL = "devopsmas@gmail.com"
    GIT_TOKEN = credentials('GithubToken')
  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git 'https://github.com/pmasa/CICD.git'
      }
    }
    stage('Building Docker image ') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
          
        }
      }
    }

    stage('Push Image to Docker Hub') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
            //dockerImage.push('latest')
          }
        }
      }
    }

    stage('Update Manifest'){
      steps{
        script{
            sh '''
                rm -rf ${GIT_REPO_NAME}
                git clone https://github.com/${GIT_USER_NAME}/${GIT_REPO_NAME}
                cd ${GIT_REPO_NAME}
                
                git config user.email ${GIT_USER_EMAIL}
                git config user.name devops

                cat deployment.yaml
                sed -i "s+pedromasa/webapp.*+pedromasa/webapp:${BUILD_NUMBER}+g" deployment.yaml
                cat deployment.yaml
                
                git add .
                git commit -m "push manifest file"
                git push https://${GIT_TOKEN}@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME}.git HEAD:master -f
            '''
        }
      }
    }

    //stage('Update Manifest') {
    //  steps {
    //    withCredentials([usernamePassword(credentialsId: 'gihubpwd', passwordVariable: 'xxxxxx', usernameVariable: 'pmasa')]) {
    //      sh "rm -rf jenkins-gitops-k8s"
    //      sh "git clone https://github.com/pmasa/jenkins-gitops-k8s.git"
    //      sh "cd jenkins-gitops-k8s"
    //      dir('jenkins-gitops-k8s') {
    //        sh "sed -i 's/image.*/image: ngnix:$BUILD_NUMBER/g' deployment.yaml"
    //        sh "git config user.email devopsmas@gmail.com"
    //        sh "git config user.name devops"
    //        sh "git add . "
    //        sh "git commit -m 'Update image version to: $BUILD_NUMBER'"
    //       sh"git push https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/pmasa/jenkins-gitops-k8s.git HEAD:master -f"

    //      }
    //    }
    //  }
    //}
  
  }    
}  
