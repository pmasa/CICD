pipeline {
  environment {
    registry = "pedromasa/webapp"
    registryCredential = 'dockerhub'
    dockerImage = ''

  }
  agent any
  stages {
    stage('Cloning Git ') {
      steps {
        git 'https://github.com/pmasa/CICD.git'
      }
    }
    stage('Building Docker image') {
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
  }    
}  