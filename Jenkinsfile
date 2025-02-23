pipeline {
  environment {
    registry = "pedromasa/webapp"
    registryCredential = 'dockerhub'
    dockerImage = ''
    //GIT_CREDS = credentials('githubcredid')
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
            
            sh 'echo ${GIT_TOKEN}'
            sh '''
                rm -rf jenkins-gitops-k8s
                git clone https://github.com/pmasa/jenkins-gitops-k8s.git
                cd jenkins-gitops-k8s
                sed "s/nginx*/nginx:${BUILD_NUMBER}/g" deployment.yaml
                git config user.email devopsmas@gmail.com
                git config user.name devops
                git add .
                git commit -m "push to git"
                git push https://${GIT_TOKEN}@github.com/pmasa/jenkins-gitops-k8s.git HEAD:master -f
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
