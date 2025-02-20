pipeline {
  environment {
    registry = "pedromasa/webapp"
    registryCredential = 'dockerhub'
    dockerImage = ''
    GITHUB_CREDENTIALS = 'gihubpwd'

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
            dockerImage.push('latest')
          }
        }
      }
    }

    stage('Update Manifest') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'gihubpwd', passwordVariable: 'Tranchin@2024', usernameVariable: 'pmasa')]) {
          sh "rm -rf jenkins-gitops-k8s"
          sh "git clone https://github.com/pmasa/jenkins-gitops-k8s.git"
          sh "cd jenkins-gitops-k8s"
          dir('jenkins-gitops-k8s') {
            sh "sed -i 's/image.*/image: ngnix:$BUILD_NUMBER/g' deployment.yaml"
            sh "git config user.email devopsmas@gmail.com"
            sh "git config user.name devops"
            sh "git add . "
            sh "git commit -m 'Update image version to: $BUILD_NUMBER'"
            sh"git push https://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@github.com/pmasa/jenkins-gitops-k8s.git HEAD:master -f"

          }
        }
      }
    }
  
  }    
}  
